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
# S3 bucket
################################################################################
# Bucket creation
module "s3_bucket" {
  source = "terraform-aws-modules/s3-bucket/aws"

  bucket = var.bucket_name
  acl    = "private"

  versioning = {
    enabled = true
  }
}
# Folder structure creation
resource "aws_s3_object" "folder_structure" {
  count = length(var.bucket_folders)

  bucket = module.s3_bucket.s3_bucket_id
  acl    = "private"
  key    = var.bucket_folders[count.index]
  source = "/dev/null"
}
################################################################################
# Lambda Function Creation
################################################################################
module "lambda_function" {
  source             = "./modules/lambda"

  # Lambda Function Variables
  lambda_function_name = var.lambda_function_name
  lambda_function_description = var.lambda_function_description
  lambda_publish = var.lambda_publish

  # Lmabda Publish Variables
  lambda_alias_name = var.lambda_alias_name
  lambda_alias_description = var.lambda_alias_description
  lambda_fun_version = var.lambda_fun_version

  lambda_source_folder_code = var.lambda_source_folder_code
  lambda_destination_folder = var.lambda_destination_folder

  lambda_role_name = var.lambda_role_name
  lambda_policy_name = var.lambda_policy_name
  lambda_policy_revoke_name = var.lambda_policy_revoke_name
}
################################################################################
# Lambda and S3 Integration
################################################################################
module "s3_lambda_intgration" {
  source = "./modules/lambda_s3"

  bucket_id = module.s3_bucket.s3_bucket_id
  lambda_function_arn = module.lambda_function.lambda_function_arn
  lambda_function_name = module.lambda_function.lambda_function_name
}