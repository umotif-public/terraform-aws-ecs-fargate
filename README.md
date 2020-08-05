# terraform-aws-ecs-fargate

Terraform module to create AWS ECS FARGATE services. Module support both FARGATE and FARGATE-SPOT capacity provider settings.

## Terraform versions

Terraform 0.12. Pin module version to `~> v4.0`. Submit pull-requests to `master` branch.

## Usage

### ECS Fargate Service

```hcl
resource "aws_ecs_cluster" "cluster" {
  name = "example-ecs-cluster"

  capacity_providers = ["FARGATE_SPOT", "FARGATE"]

  default_capacity_provider_strategy {
    capacity_provider = "FARGATE_SPOT"
  }

  setting {
    name  = "containerInsights"
    value = "disabled"
  }
}

module "ecs-fargate" {
  source = "umotif-public/ecs-fargate/aws"
  version = "~> 4.0.0"

  name_prefix        = "ecs-fargate-example"
  vpc_id             = "vpc-abasdasd132"
  private_subnet_ids = ["subnet-abasdasd132123", "subnet-abasdasd132123132"]
  lb_arn             = "arn:aws:asdasdasdasdasdasad"

  cluster_id         = aws_ecs_cluster.cluster.id

  task_container_image   = "marcincuber/2048-game:latest"
  task_definition_cpu    = 256
  task_definition_memory = 512

  task_container_port             = 80
  task_container_assign_public_ip = true

  health_check = {
    port = "traffic-port"
    path = "/"
  }

  tags = {
    Environment = "test"
    Project = "Test"
  }
}
```

## Assumptions

Module is to be used with Terraform > 0.12.

## Examples

* [ECS Fargate](https://github.com/umotif-public/terraform-aws-ecs-fargate/tree/master/examples/core)
* [ECS Fargate Spot](https://github.com/umotif-public/terraform-aws-ecs-fargate/tree/master/examples/fargate-spot)
* [ECS Fargate with EFS](https://github.com/umotif-public/terraform-aws-ecs-fargate/tree/master/examples/fargate-efs)

## Authors

Module managed by [Marcin Cuber](https://github.com/marcincuber) [LinkedIn](https://www.linkedin.com/in/marcincuber/).

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.12.6, < 0.14 |
| aws | >= 2.68, < 4.0 |

## Providers

| Name | Version |
|------|---------|
| aws | >= 2.68, < 4.0 |
| null | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| capacity\_provider\_strategy | (Optional) The capacity\_provider\_strategy configuration block. This is a list of maps, where each map should contain "capacity\_provider ", "weight" and "base" | `list` | `[]` | no |
| cluster\_id | The Amazon Resource Name (ARN) that identifies the cluster. | `string` | n/a | yes |
| container\_name | Optional name for the container to be used instead of name\_prefix. | `string` | `""` | no |
| create\_repository\_credentials\_iam\_policy | Set to true if you are specifying `repository_credentials` variable, it will attach IAM policy with necessary permissions to task role. | `bool` | `false` | no |
| deployment\_controller\_type | Type of deployment controller. Valid values: CODE\_DEPLOY, ECS. | `string` | `"ECS"` | no |
| deployment\_maximum\_percent | The upper limit of the number of running tasks that can be running in a service during a deployment | `number` | `200` | no |
| deployment\_minimum\_healthy\_percent | The lower limit of the number of running tasks that must remain running and healthy in a service during a deployment | `number` | `50` | no |
| desired\_count | The number of instances of the task definitions to place and keep running. | `number` | `1` | no |
| force\_new\_deployment | Enable to force a new task deployment of the service. This can be used to update tasks to use a newer Docker image with same image/tag combination (e.g. myimage:latest), roll Fargate tasks onto a newer platform version. | `bool` | `false` | no |
| health\_check | A health block containing health check settings for the target group. Overrides the defaults. | `map(string)` | n/a | yes |
| health\_check\_grace\_period\_seconds | Seconds to ignore failing load balancer health checks on newly instantiated tasks to prevent premature shutdown, up to 7200. Only valid for services configured to use load balancers. | `number` | `300` | no |
| lb\_arn | Arn for the LB for which the service should be attach to. | `string` | n/a | yes |
| load\_balanced | Whether the task should be loadbalanced. | `bool` | `true` | no |
| log\_retention\_in\_days | Number of days the logs will be retained in CloudWatch. | `number` | `30` | no |
| logs\_kms\_key | The KMS key ARN to use to encrypt container logs. | `string` | `""` | no |
| name\_prefix | A prefix used for naming resources. | `string` | n/a | yes |
| placement\_constraints | (Optional) A set of placement constraints rules that are taken into consideration during task placement. Maximum number of placement\_constraints is 10. This is a list of maps, where each map should contain "type" and "expression" | `list` | `[]` | no |
| platform\_version | The platform version on which to run your service. Only applicable for launch\_type set to FARGATE. | `string` | `"LATEST"` | no |
| private\_subnet\_ids | A list of private subnets inside the VPC | `list(string)` | n/a | yes |
| propogate\_tags | Specifies whether to propagate the tags from the task definition or the service to the tasks. The valid values are SERVICE and TASK\_DEFINITION. | `string` | `"TASK_DEFINITION"` | no |
| proxy\_configuration | (Optional) The proxy configuration details for the App Mesh proxy. This is a list of maps, where each map should contain "container\_name", "properties" and "type" | `list` | `[]` | no |
| repository\_credentials | name or ARN of a secrets manager secret (arn:aws:secretsmanager:region:aws\_account\_id:secret:secret\_name) | `string` | `""` | no |
| repository\_credentials\_kms\_key | key id, key ARN, alias name or alias ARN of the key that encrypted the repository credentials | `string` | `"alias/aws/secretsmanager"` | no |
| service\_registry\_arn | ARN of aws\_service\_discovery\_service resource | `string` | `""` | no |
| sg\_name\_prefix | A prefix used for Security group name. | `string` | `""` | no |
| tags | A map of tags (key-value pairs) passed to resources. | `map(string)` | `{}` | no |
| target\_group\_name | The name for the tasks target group | `string` | `""` | no |
| task\_container\_assign\_public\_ip | Assigned public IP to the container. | `bool` | `false` | no |
| task\_container\_command | The command that is passed to the container. | `list(string)` | `[]` | no |
| task\_container\_cpu | Amount of CPU to reserve for the container. | `number` | `null` | no |
| task\_container\_environment | The environment variables to pass to a container. | `map(string)` | `{}` | no |
| task\_container\_image | The image used to start a container. | `string` | n/a | yes |
| task\_container\_memory | The hard limit (in MiB) of memory for the container. | `number` | `null` | no |
| task\_container\_memory\_reservation | The soft limit (in MiB) of memory to reserve for the container. | `number` | `null` | no |
| task\_container\_port | The port number on the container that is bound to the user-specified or automatically assigned host port | `number` | n/a | yes |
| task\_container\_protocol | Protocol that the container exposes. | `string` | `"HTTP"` | no |
| task\_container\_working\_directory | The working directory to run commands inside the container. | `string` | `""` | no |
| task\_definition\_cpu | Amount of CPU to reserve for the task. | `number` | `256` | no |
| task\_definition\_memory | The soft limit (in MiB) of memory to reserve for the task. | `number` | `512` | no |
| task\_health\_check | An optional healthcheck definition for the task | `object({ command = list(string), interval = number, timeout = number, retries = number, startPeriod = number })` | `null` | no |
| task\_host\_port | The port number on the container instance to reserve for your container. | `number` | `0` | no |
| task\_mount\_points | The mount points for data volumes in your container. Each object inside the list requires "sourceVolume", "containerPath" and "readOnly". For more information see https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task_definition_parameters.html | `list(object({ sourceVolume = string, containerPath = string, readOnly = bool }))` | `null` | no |
| task\_start\_timeout | Time duration (in seconds) to wait before giving up on resolving dependencies for a container. If this parameter is not specified, the default value of 3 minutes is used (fargate). | `number` | `null` | no |
| task\_stop\_timeout | Time duration (in seconds) to wait before the container is forcefully killed if it doesn't exit normally on its own. The max stop timeout value is 120 seconds and if the parameter is not specified, the default value of 30 seconds is used. | `number` | `null` | no |
| volume | (Optional) A set of volume blocks that containers in your task may use. This is a list of maps, where each map should contain "name", "host\_path", "docker\_volume\_configuration" and "efs\_volume\_configuration". Full set of options can be found at https://www.terraform.io/docs/providers/aws/r/ecs_task_definition.html | `list` | `[]` | no |
| vpc\_id | The VPC ID. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| execution\_role\_arn | The Amazon Resource Name (ARN) specifying the ECS execution role. |
| execution\_role\_name | The name of the ECS execution role. |
| log\_group\_name | The name of the Cloudwatch log group for the task. |
| service\_arn | The Amazon Resource Name (ARN) that identifies the ECS service. |
| service\_name | The name of the service. |
| service\_sg\_id | The Amazon Resource Name (ARN) that identifies the service security group. |
| target\_group\_arn | The ARN of the Target Group used by Load Balancer. |
| target\_group\_name | The Name of the Target Group used by Load Balancer. |
| task\_definition\_arn | The Amazon Resource Name (ARN) of the task definition created |
| task\_definition\_name | The name of the task definition created |
| task\_role\_arn | The Amazon Resource Name (ARN) specifying the ECS service role. |
| task\_role\_name | The name of the Fargate task service role. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## License

See LICENSE for full details.

## Pre-commit hooks

### Install dependencies

* [`pre-commit`](https://pre-commit.com/#install)
* [`terraform-docs`](https://github.com/segmentio/terraform-docs) required for `terraform_docs` hooks.
* [`TFLint`](https://github.com/terraform-linters/tflint) required for `terraform_tflint` hook.

#### MacOS

```bash
brew install pre-commit terraform-docs tflint

brew tap git-chglog/git-chglog
brew install git-chglog
```
