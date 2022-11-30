################################################################################
# Bucket Variables
################################################################################
variable "bucket_name" {
  type = string
  description = "Name of Bucket"
}

variable "bucket_folders" {
  type = list(string)
  description = "List of folder structure" 
}

################################################################################
# Lambda Variables
################################################################################
# Lambda - Name a
variable "lambda_function_name" {
  type        = string
  description = "Lambda function name to be applied"

  default = "lmb_fun_name"
}

variable "lambda_function_description" {
  type        = string
  description = "Lambda function description (What it does)"

  default = "Lambda new description"
}
# Versioning
variable "lambda_publish" {
  type        = bool
  description = "Whetever publish or not the lambda function"

  default = false
}
variable "lambda_version" {
  type        = string
  description = "Publish version if lambda set to true"

  default = null
}
variable "lambda_alias_name" {
  type        = string
  description = "Alias environment name"

  default = "dev"
}
variable "lambda_alias_description" {
  type        = string
  description = "Description to be applied to name"

  default = "Alias default environment description"
}
variable "lambda_fun_version" {
  type        = string
  description = "Version of lambda function to be applied"

  default = "1"
}

variable "lambda_source_folder_code" {
  type = string
  description = "Source folder of code to be exported"
}

variable "lambda_destination_folder" {
  type = string
  description = "Destination folder where .zip file will be created"
}

# Roles and policies
variable "lambda_role_name" {
  type = string
  description = "Lambda role name"
}
variable "lambda_policy_name" {
  type = string
  description = "Lambda policy name"
}
variable "lambda_policy_revoke_name" {
  type = string
  description = "Lambda revoke policy name"
}