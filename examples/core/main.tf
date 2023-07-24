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

#####
# private repo credentials secretsmanager
#####
# data "aws_kms_key" "secretsmanager_key" {
#   key_id = "alias/aws/secretsmanager"
# }

# resource "aws_secretsmanager_secret" "task_credentials" {
#   name = "task_repository_credentials"

#   kms_key_id = data.aws_kms_key.secretsmanager_key.arn
# }

#####
# ECS cluster and fargate
#####
resource "aws_ecs_cluster" "cluster" {
  name = "example-ecs-cluster"
}

module "fargate" {
  source = "../../"

  name_prefix = "ecs-fargate-example"
  # sg_name_prefix     = "my-security-group-name" # uncomment if you want to name security group with specific name

  vpc_id             = data.aws_vpc.default.id
  private_subnet_ids = data.aws_subnets.all.ids
  cluster_id         = aws_ecs_cluster.cluster.id

  wait_for_steady_state = false

  platform_version = "1.4.0" # defaults to LATEST

  task_container_image   = "marcincuber/2048-game:latest"
  task_definition_cpu    = 256
  task_definition_memory = 512

  task_container_port             = 80
  task_container_assign_public_ip = true

  target_groups = [
    {
      target_group_name = "tg-example"
      container_port    = 80
      container_name    = "ecs-fargate-example" # should be equal to container_name in container definition
    }
  ]

  health_check = {
    port = "traffic-port"
    path = "/"
  }

  task_stop_timeout = 90

  depends_on = [
    module.alb
  ]

  ### To use task credentials, below paramaters are required
  # create_repository_credentials_iam_policy = false
  # repository_credentials                   = aws_secretsmanager_secret.task_credentials.arn
}

resource "aws_security_group" "allow_sg_test" {
  name        = "allow_sg_test"
  description = "Allow sg inbound traffic"
  vpc_id      = data.aws_vpc.default.id
}

resource "aws_security_group_rule" "test_sg_ingress" {
  security_group_id        = aws_security_group.allow_sg_test.id
  type                     = "ingress"
  protocol                 = "tcp"
  from_port                = 3022
  to_port                  = 3022
  source_security_group_id = module.fargate.service_sg_id
}
