# terraform-aws-ecs-fargate
Terraform module to create AWS ECS FARGATE services

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

Module managed by [Marcin Cuber](https://github.com/marcincuber) [linkedin](https://www.linkedin.com/in/marcincuber/).

## License

See LICENSE for full details.