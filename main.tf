#####
# Cloudwatch
#####
resource "aws_cloudwatch_log_group" "main" {
  name              = var.name_prefix
  retention_in_days = var.log_retention_in_days

  kms_key_id = var.logs_kms_key
  tags       = var.tags
}

#####
# IAM - Task execution role, needed to pull ECR images etc.
#####
resource "aws_iam_role" "execution" {
  name               = "${var.name_prefix}-task-execution-role"
  assume_role_policy = data.aws_iam_policy_document.task_assume.json
}

resource "aws_iam_role_policy" "task_execution" {
  name   = "${var.name_prefix}-task-execution"
  role   = aws_iam_role.execution.id
  policy = data.aws_iam_policy_document.task_execution_permissions.json
}

resource "aws_iam_role_policy" "read_repository_credentials" {
  count = length(var.repository_credentials) != 0 ? 1 : 0

  name   = "${var.name_prefix}-read-repository-credentials"
  role   = aws_iam_role.execution.id
  policy = data.aws_iam_policy_document.read_repository_credentials.json
}

#####
# IAM - Task role, basic. Append policies to this role for S3, DynamoDB etc.
#####
resource "aws_iam_role" "task" {
  name               = "${var.name_prefix}-task-role"
  assume_role_policy = data.aws_iam_policy_document.task_assume.json
}

resource "aws_iam_role_policy" "log_agent" {
  name   = "${var.name_prefix}-log-permissions"
  role   = aws_iam_role.task.id
  policy = data.aws_iam_policy_document.task_permissions.json
}

#####
# Security groups
#####
resource "aws_security_group" "ecs_service" {
  vpc_id      = var.vpc_id
  name        = "${var.name_prefix}-ecs-service-sg"
  description = "Fargate service security group"
  tags = merge(
    var.tags,
    {
      Name = "${var.name_prefix}-sg"
    },
  )
}

resource "aws_security_group_rule" "egress_service" {
  security_group_id = aws_security_group.ecs_service.id
  type              = "egress"
  protocol          = "-1"
  from_port         = 0
  to_port           = 0
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
}

#####
# Load Balancer Target group
#####
resource "aws_lb_target_group" "task" {
  count       = var.load_balanced ? 1 : 0
  name        = var.target_group_name != "" ? var.target_group_name : "${var.name_prefix}-target-${var.task_container_port}"
  vpc_id      = var.vpc_id
  protocol    = var.task_container_protocol
  port        = var.task_container_port
  target_type = "ip"
  dynamic "health_check" {
    for_each = [var.health_check]
    content {
      enabled             = lookup(health_check.value, "enabled", null)
      healthy_threshold   = lookup(health_check.value, "healthy_threshold", null)
      interval            = lookup(health_check.value, "interval", null)
      matcher             = lookup(health_check.value, "matcher", null)
      path                = lookup(health_check.value, "path", null)
      port                = lookup(health_check.value, "port", null)
      protocol            = lookup(health_check.value, "protocol", null)
      timeout             = lookup(health_check.value, "timeout", null)
      unhealthy_threshold = lookup(health_check.value, "unhealthy_threshold", null)
    }
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = merge(
    var.tags,
    {
      Name = var.target_group_name != "" ? var.target_group_name : "${var.name_prefix}-target-${var.task_container_port}"
    },
  )
}

#####
# ECS Task/Service
#####
locals {
  task_environment = [
    for k, v in var.task_container_environment : {
      name  = k
      value = v
    }
  ]
}

resource "aws_ecs_task_definition" "task" {
  family                   = var.name_prefix
  execution_role_arn       = aws_iam_role.execution.arn
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.task_definition_cpu
  memory                   = var.task_definition_memory
  task_role_arn            = aws_iam_role.task.arn

  container_definitions = <<EOF
[{
  "name": "${var.container_name != "" ? var.container_name : var.name_prefix}",
  "image": "${var.task_container_image}",
  %{if var.repository_credentials != ""~}
  "repositoryCredentials": {
    "credentialsParameter": "${var.repository_credentials}"
  },
  %{~endif}
  "essential": true,
  %{if var.task_container_port != 0 || var.task_host_port != 0~}
  "portMappings": [
    {
      %{if var.task_host_port != 0~}
      "hostPort": ${var.task_host_port},
      %{~endif}
      %{if var.task_container_port != 0~}
      "containerPort": ${var.task_container_port},
      %{~endif}
      "protocol":"tcp"
    }
  ],
  %{~endif}
  "logConfiguration": {
    "logDriver": "awslogs",
    "options": {
      "awslogs-group": "${aws_cloudwatch_log_group.main.name}",
      "awslogs-region": "${data.aws_region.current.name}",
      "awslogs-stream-prefix": "container"
    }
  },
  %{if var.task_health_check != null~}
  "healthcheck": {
    "command": ${jsonencode(var.task_health_check.command)},
    "interval": ${var.task_health_check.interval},
    "timeout": ${var.task_health_check.timeout},
    "retries": ${var.task_health_check.retries},
    "startPeriod": ${var.task_health_check.startPeriod}
  },
  %{~endif}
  "command": ${jsonencode(var.task_container_command)},
  %{if var.task_container_working_directory != ""~}
  "workingDirectory": ${var.task_container_working_directory},
  %{~endif}
  %{if var.task_container_memory != null~}
  "memory": ${var.task_container_memory},
  %{~endif}
  %{if var.task_container_memory_reservation != null~}
  "memoryReservation": ${var.task_container_memory_reservation},
  %{~endif}
  %{if var.task_container_cpu != null~}
  "cpu": ${var.task_container_cpu},
  %{~endif}
  "environment": ${jsonencode(local.task_environment)}
}]
EOF

  dynamic "placement_constraints" {
    for_each = var.placement_constraints
    content {
      expression = lookup(placement_constraints.value, "expression", null)
      type       = placement_constraints.value.type
    }
  }

  dynamic "proxy_configuration" {
    for_each = var.proxy_configuration
    content {
      container_name = proxy_configuration.value.container_name
      properties     = lookup(proxy_configuration.value, "properties", null)
      type           = lookup(proxy_configuration.value, "type", null)
    }
  }

  dynamic "volume" {
    for_each = var.volume
    content {
      name      = volume.value.name
      host_path = lookup(volume.value, "host_path", null)

      dynamic "docker_volume_configuration" {
        for_each = lookup(volume.value, "docker_volume_configuration", [])
        content {
          scope         = lookup(docker_volume_configuration.value, "scope", null)
          autoprovision = lookup(docker_volume_configuration.value, "autoprovision", null)
          driver        = lookup(docker_volume_configuration.value, "driver", null)
          driver_opts   = lookup(docker_volume_configuration.value, "driver_opts", null)
          labels        = lookup(docker_volume_configuration.value, "labels", null)
        }
      }

      dynamic "efs_volume_configuration" {
        for_each = lookup(volume.value, "efs_volume_configuration", [])
        content {
          file_system_id = lookup(efs_volume_configuration.value, "file_system_id", null)
          root_directory = lookup(efs_volume_configuration.value, "root_directory", null)
        }
      }
    }
  }

  tags = merge(
    var.tags,
    {
      Name = var.container_name != "" ? var.container_name : var.name_prefix
    },
  )
}

resource "aws_ecs_service" "service" {
  name = var.name_prefix

  cluster         = var.cluster_id
  task_definition = aws_ecs_task_definition.task.arn

  desired_count  = var.desired_count
  propagate_tags = var.propogate_tags

  platform_version = var.platform_version
  launch_type      = length(var.capacity_provider_strategy) == 0 ? "FARGATE" : null

  deployment_minimum_healthy_percent = var.deployment_minimum_healthy_percent
  deployment_maximum_percent         = var.deployment_maximum_percent
  health_check_grace_period_seconds  = var.load_balanced ? var.health_check_grace_period_seconds : null

  network_configuration {
    subnets          = var.private_subnet_ids
    security_groups  = [aws_security_group.ecs_service.id]
    assign_public_ip = var.task_container_assign_public_ip
  }

  dynamic "capacity_provider_strategy" {
    for_each = var.capacity_provider_strategy
    content {
      capacity_provider = capacity_provider_strategy.value.capacity_provider
      weight            = capacity_provider_strategy.value.weight
      base              = lookup(capacity_provider_strategy.value, "base", null)
    }
  }

  dynamic "load_balancer" {
    for_each = var.load_balanced ? [1] : []
    content {
      container_name   = var.container_name != "" ? var.container_name : var.name_prefix
      container_port   = var.task_container_port
      target_group_arn = aws_lb_target_group.task[0].arn
    }
  }

  deployment_controller {
    type = var.deployment_controller_type # CODE_DEPLOY or ECS
  }

  dynamic "service_registries" {
    for_each = var.service_registry_arn == "" ? [] : [1]
    content {
      registry_arn   = var.service_registry_arn
      container_port = var.task_container_port
      container_name = var.container_name != "" ? var.container_name : var.name_prefix
    }
  }

  tags = merge(
    var.tags,
    {
      Name = "${var.name_prefix}-service"
    },
  )

  depends_on = [null_resource.lb_exists]
}

# HACK: The workaround used in ecs/service does not work for some reason in this module, this fixes the following error:
# "The target group with targetGroupArn arn:aws:elasticloadbalancing:... does not have an associated load balancer."
# see https://github.com/hashicorp/terraform/issues/12634.
# Service depends on this resources which prevents it from being created until the LB is ready
resource "null_resource" "lb_exists" {
  triggers = {
    alb_name = var.lb_arn
  }
}
