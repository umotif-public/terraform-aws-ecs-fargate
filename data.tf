data "aws_region" "current" {}

# Task role assume policy
data "aws_iam_policy_document" "task_assume" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

# Task logging privileges
data "aws_iam_policy_document" "task_permissions" {
  statement {
    effect = "Allow"

    resources = [
      aws_cloudwatch_log_group.main.arn,
      "${aws_cloudwatch_log_group.main.arn}:*"
    ]

    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]
  }
}

# Task ecr privileges
data "aws_iam_policy_document" "task_execution_permissions" {
  statement {
    effect = "Allow"

    resources = [
      "*",
    ]

    actions = [
      "ecr:GetAuthorizationToken",
      "ecr:BatchCheckLayerAvailability",
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchGetImage",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]
  }
}

data "aws_kms_key" "secretsmanager_key" {
  count = var.create_repository_credentials_iam_policy ? 1 : 0

  key_id = var.repository_credentials_kms_key
}

data "aws_iam_policy_document" "read_repository_credentials" {
  count = var.create_repository_credentials_iam_policy ? 1 : 0

  statement {
    effect = "Allow"

    resources = [
      var.repository_credentials,
      data.aws_kms_key.secretsmanager_key[0].arn,
    ]

    actions = [
      "secretsmanager:GetSecretValue",
      "kms:Decrypt",
    ]
  }
}
