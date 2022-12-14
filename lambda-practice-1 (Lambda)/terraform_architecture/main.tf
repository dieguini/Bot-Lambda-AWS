terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.37.0"
    }
  }

  required_version = ">= 1.3.0"
}

provider "aws" {
  region = "us-east-1"
}
################################################################################
# Roles and Policies
################################################################################
# Role
resource "aws_iam_role" "lambda_role" {
  name               = "role_ca_2_lambda"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}
# Policy
resource "aws_iam_policy" "lambda_policy" {
  name        = "policy_ca_2_lambda_for_role_ca_2_lambda"
  path        = "/"
  description = "IAM policy for logging from a lambda"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      "Resource": "arn:aws:logs:*:*:*",
      "Effect": "Allow"
    }
  ]
}
EOF
}
# Attachment - Between Role & Policy
resource "aws_iam_role_policy_attachment" "lambda_logs_attachment" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = aws_iam_policy.lambda_policy.arn
}
################################################################################
# Archive & Lambda Function
################################################################################
# Archive - Creates a Zip file
data "archive_file" "zip_python_code" {
  type        = "zip"
  source_dir  = "../${path.module}/canary_app/"
  output_path = "../${path.module}/canary_app.zip"
}
# Lambda - Create lambda functions
resource "aws_lambda_function" "lambda_fun" {
  filename      = "../${path.module}/canary_app.zip"
  function_name = var.lambda_function_name
  description   = var.lambda_function_description
  role          = aws_iam_role.lambda_role.arn
  handler       = "lambda_function.lambda_handler"
  runtime       = "python3.7"
  publish       = var.lambda_publish

  depends_on = [
    aws_iam_role_policy_attachment.lambda_logs_attachment
  ]
}
# Lambda - Creates lambda functions
resource "aws_lambda_alias" "lambda_fun_alias" {
  count = var.lambda_publish ? 1 : 0

  name             = var.lambda_alias_name
  description      = var.lambda_alias_description
  function_name    = aws_lambda_function.lambda_fun.arn
  function_version = var.lambda_fun_version

  depends_on = [
    aws_lambda_function.lambda_fun
  ]
  /* routing_config {
    additional_version_weights = {
      "2" = 0.5
    }
  } */
}

################################################################################
# Outputs
################################################################################
output "aws_role_output" {
  value = aws_iam_role.lambda_role.name
}
output "aws_role_arn" {
  value = aws_iam_role.lambda_role.arn
}
output "loggin_arn_output" {
  value = aws_iam_policy.lambda_policy.arn
}