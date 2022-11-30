################################################################################
# Roles and Policies
################################################################################
# Role
resource "aws_iam_role" "lambda_role" {
  name               = var.lambda_role_name
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
  name        = var.lambda_policy_name
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

resource "aws_iam_role_policy" "revoke_keys_role_policy" {
  name = var.lambda_policy_revoke_name
  # role = aws_iam_role.lambda_iam.id
  role = aws_iam_role.lambda_role.id

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:*",
        "ses:*"
      ],
      "Effect": "Allow",
      "Resource": "*"
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
  source_dir  = var.lambda_source_folder_code
  output_path = var.lambda_destination_folder
}
# Lambda - Create lambda functions
resource "aws_lambda_function" "lambda_fun" {
  filename = data.archive_file.zip_python_code.output_path

  function_name    = var.lambda_function_name
  description      = var.lambda_function_description
  role             = aws_iam_role.lambda_role.arn
  handler          = "lambda_function.lambda_handler"
  runtime          = "python3.7"
  publish          = var.lambda_publish
  source_code_hash = filebase64sha256(data.archive_file.zip_python_code.output_path)

  depends_on = [
    aws_iam_role_policy_attachment.lambda_logs_attachment,
    data.archive_file.zip_python_code
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
    aws_lambda_function.lambda_fun,
    data.archive_file.zip_python_code
  ]
  /* routing_config {
    additional_version_weights = {
      "2" = 0.5
    }
  } */
}
