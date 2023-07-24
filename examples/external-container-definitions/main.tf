#####
# VPC and subnets
#####
data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "all" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

#####
# ECS cluster and fargate
#####
resource "aws_ecs_cluster" "cluster" {
  name = "ecs-external-container-definitions-test"

  setting {
    name  = "containerInsights"
    value = "disabled"
  }
}

resource "aws_ecs_cluster_capacity_providers" "cluster" {
  cluster_name = aws_ecs_cluster.cluster.name

  capacity_providers = ["FARGATE_SPOT", "FARGATE"]

  default_capacity_provider_strategy {
    capacity_provider = "FARGATE_SPOT"
  }
}

module "container_1" {
  source  = "cloudposse/ecs-container-definition/aws"
  version = "0.60.0"

  container_name  = "example"
  container_image = "hello-world:latest"

  port_mappings = [
    {
      containerPort = 80
      hostPort      = 80
      protocol      = "tcp"
    }
  ]

}

module "container_2" {
  source  = "cloudposse/ecs-container-definition/aws"
  version = "0.60.0"

  container_name  = "example-2"
  container_image = "hello-world:latest"

  port_mappings = [
    {
      containerPort = 81
      hostPort      = 81
      protocol      = "udp"
    }
  ]

  container_depends_on = [
    {
      containerName = "example"
      condition     = "START"
    }
  ]
}

#####
# ALB
#####
module "alb" {
  source  = "umotif-public/alb/aws"
  version = "~> 2.0"

  name_prefix        = "alb-example"
  load_balancer_type = "application"
  internal           = false
  vpc_id             = data.aws_vpc.default.id
  subnets            = data.aws_subnets.all.ids
}

resource "aws_lb_listener" "alb_80" {
  load_balancer_arn = module.alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = module.fargate.target_group_arn[0]
  }
}

#####
# Security Group Config
#####
resource "aws_security_group_rule" "alb_ingress_80" {
  security_group_id = module.alb.security_group_id
  type              = "ingress"
  protocol          = "tcp"
  from_port         = 80
  to_port           = 80
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
}

resource "aws_security_group_rule" "task_ingress_80" {
  security_group_id        = module.fargate.service_sg_id
  type                     = "ingress"
  protocol                 = "tcp"
  from_port                = 80
  to_port                  = 80
  source_security_group_id = module.alb.security_group_id
}

module "fargate" {
  source = "../../"

  name_prefix        = "ecs-fargate-example-2"
  vpc_id             = data.aws_vpc.default.id
  private_subnet_ids = data.aws_subnets.all.ids

  cluster_id = aws_ecs_cluster.cluster.id

  container_definitions = jsonencode([
    module.container_1.json_map_object,
    module.container_2.json_map_object
  ])

  capacity_provider_strategy = [
    {
      capacity_provider = "FARGATE_SPOT",
      weight            = 100
    }
  ]

  enable_deployment_circuit_breaker          = true
  enable_deployment_circuit_breaker_rollback = true

  health_check = {
    port = "traffic-port"
    path = "/"
  }

  target_groups = [
    {
      container_name    = "example"
      target_group_name = "tg-example"
      container_port    = 80
    }
  ]

}

output "first_container_json" {
  description = "Container definition in JSON format"
  value       = module.container_1.json_map_encoded_list
}

output "second_container_json" {
  description = "Container definition in JSON format"
  value       = module.container_2.json_map_encoded_list
}

output "task_definition_container_definitions" {
  description = "A list of container definitions"
  value       = module.fargate.task_definition_container_definitions
}