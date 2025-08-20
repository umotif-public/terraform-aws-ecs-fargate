locals {
  #####
  # This format of using container definitions will be deprecated in a later version in favour of using external container definitions.
  # An example of using external container definitions can be found in examples/external-container-definitions folder
  #####
  default_container_definitions = <<EOF
[{
  "name": "${var.container_name != "" ? var.container_name : var.name_prefix}",
  "image": "${var.task_container_image}",
  %{if var.repository_credentials != ""~}
  "repositoryCredentials": {
    "credentialsParameter": "${var.repository_credentials}"
  },
  %{~endif}
  "essential": true,
  %{if length(local.target_group_portMaps) > 0}
  "portMappings": ${jsonencode(local.target_group_portMaps)},
  %{else}
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
  %{~endif}
  %{if var.enable_logs~}
  "logConfiguration": {
    "logDriver": "awslogs",
    "options": {
      "awslogs-group": "${aws_cloudwatch_log_group.main[0].name}",
      "awslogs-region": "${data.aws_region.current.id}",
      "awslogs-stream-prefix": "container"
    }
  }
  %{~endif},
  %{if var.task_health_check != null || var.task_health_command != null~}
  "healthcheck": {
    "command": ${jsonencode(var.task_health_command)},
    "interval": ${lookup(var.task_health_check, "interval", 30)},
    "timeout": ${lookup(var.task_health_check, "timeout", 5)},
    "retries": ${lookup(var.task_health_check, "retries", 3)},
    "startPeriod": ${lookup(var.task_health_check, "startPeriod", 0)}
  },
  %{~endif}
  "command": ${jsonencode(var.task_container_command)},
  %{if var.task_container_entrypoint != ""~}
  "entryPoint": ${jsonencode(var.task_container_entrypoint)},
  %{~endif}
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
  %{if var.task_start_timeout != null~}
  "startTimeout": ${var.task_start_timeout},
  %{~endif}
  %{if var.task_stop_timeout != null~}
  "stopTimeout": ${var.task_stop_timeout},
  %{~endif}
  %{if var.task_mount_points != null~}
  "mountPoints": ${jsonencode(var.task_mount_points)},
  %{~endif}
  %{if var.task_container_secrets != null~}
  "secrets": ${jsonencode(var.task_container_secrets)},
  %{~endif}
  %{if var.task_pseudo_terminal != null~}
  "pseudoTerminal": ${var.task_pseudo_terminal},
  %{~endif}
  "environment": ${jsonencode(local.task_environment)},
  "environmentFiles": ${jsonencode(local.task_environment_files)},
  "readonlyRootFilesystem": ${var.readonlyRootFilesystem ? true : false}
}]
EOF

  container_definitions = var.container_definitions != null ? var.container_definitions : local.default_container_definitions
}
