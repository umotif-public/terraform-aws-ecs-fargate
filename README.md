# terraform-aws-ecs-fargate

Terraform module to create AWS ECS FARGATE services.

## Terraform versions

Terraform 0.12. Pin module version to `~> v1.0`. Submit pull-requests to `master` branch.

## Usage

### Application Load Balancer

```hcl
resource "aws_ecs_cluster" "cluster" {
  name = "example-ecs-cluster"
}

module "ecs-farage" {
  source = "umotif-public/ecs-fargate/aws"
  version = "~> 1.0"
  
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
    Project = "Test"
  }
}
```

## Assumptions

Module is to be used with Terraform > 0.12.

## Examples

* [ECS Fargate](https://github.com/umotif-public/terraform-aws-ecs-fargate/tree/master/examples/core)

## Authors

Module managed by [Marcin Cuber](https://github.com/marcincuber) [LinkedIn](https://www.linkedin.com/in/marcincuber/).

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| cluster\_id | The Amazon Resource Name (ARN) that identifies the cluster. | string | n/a | yes |
| health\_check | A health block containing health check settings for the target group. Overrides the defaults. | map(string) | n/a | yes |
| lb\_arn | Arn for the LB for which the service should be attach to. | string | n/a | yes |
| name\_prefix | A prefix used for naming resources. | string | n/a | yes |
| private\_subnet\_ids | A list of private subnets inside the VPC | list(string) | n/a | yes |
| task\_container\_image | The image used to start a container. | string | n/a | yes |
| task\_container\_port | The port number on the container that is bound to the user-specified or automatically assigned host port | number | n/a | yes |
| vpc\_id | The VPC ID. | string | n/a | yes |
| container\_name | Optional name for the container to be used instead of name_prefix. | string | `""` | no |
| deployment\_controller\_type | Type of deployment controller. Valid values: CODE_DEPLOY, ECS. | string | `"ECS"` | no |
| deployment\_maximum\_percent | The upper limit of the number of running tasks that can be running in a service during a deployment | number | `"200"` | no |
| deployment\_minimum\_healthy\_percent | The lower limit of the number of running tasks that must remain running and healthy in a service during a deployment | number | `"50"` | no |
| desired\_count | The number of instances of the task definitions to place and keep running. | number | `"1"` | no |
| health\_check\_grace\_period\_seconds | Seconds to ignore failing load balancer health checks on newly instantiated tasks to prevent premature shutdown, up to 7200. Only valid for services configured to use load balancers. | number | `"300"` | no |
| log\_retention\_in\_days | Number of days the logs will be retained in CloudWatch. | number | `"30"` | no |
| propogate\_tags | Specifies whether to propagate the tags from the task definition or the service to the tasks. The valid values are SERVICE and TASK_DEFINITION. | string | `"TASK_DEFINITION"` | no |
| repository\_credentials | name or ARN of a secrets manager secret (arn:aws:secretsmanager:region:aws_account_id:secret:secret_name) | string | `""` | no |
| repository\_credentials\_kms\_key | key id, key ARN, alias name or alias ARN of the key that encrypted the repository credentials | string | `"alias/aws/secretsmanager"` | no |
| service\_registry\_arn | ARN of aws_service_discovery_service resource | string | `""` | no |
| tags | A map of tags (key-value pairs) passed to resources. | map(string) | `{}` | no |
| task\_container\_assign\_public\_ip | Assigned public IP to the container. | bool | `"false"` | no |
| task\_container\_command | The command that is passed to the container. | list(string) | `[]` | no |
| task\_container\_environment | The environment variables to pass to a container. | map(string) | `{}` | no |
| task\_container\_protocol | Protocol that the container exposes. | string | `"HTTP"` | no |
| task\_definition\_cpu | Amount of CPU to reserve for the task. | number | `"256"` | no |
| task\_definition\_memory | The soft limit (in MiB) of memory to reserve for the container. | number | `"512"` | no |
| task\_host\_port | The port number on the container instance to reserve for your container. | number | `"0"` | no |

## Outputs

| Name | Description |
|------|-------------|
| log\_group\_name | The name of the Cloudwatch log group for the task. |
| service\_arn | The Amazon Resource Name (ARN) that identifies the ECS service. |
| service\_name | The name of the service. |
| service\_sg\_id | The Amazon Resource Name (ARN) that identifies the service security group. |
| target\_group\_arn | The ARN of the Target Group used by Load Balancer. |
| target\_group\_name | The Name of the Target Group used by Load Balancer. |
| task\_role\_arn | The Amazon Resource Name (ARN) specifying the ECS service role. |
| task\_role\_name | The name of the Fargate task service role. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## License

See LICENSE for full details.
