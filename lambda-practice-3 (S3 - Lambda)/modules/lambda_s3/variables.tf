variable "bucket_id" {
  type        = string
  description = "Bucket id to connect"
}

variable "lambda_function_arn" {
  type        = string
  description = "Lambda ARN Route"
}

variable "lambda_function_name" {
  type        = string
  description = "Lambda function name"
}
