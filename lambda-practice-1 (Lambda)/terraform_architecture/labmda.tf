################################################################################
# Lambda Module TODO
################################################################################
# module "lambda_function" {
#   source = "terraform-aws-modules/lambda/aws"

#   function_name = "canary_app_diego-jauregui-2"
#   description   = "Lambda function fo canary app"
#   handler       = "lambda_function.lambda_handler"
#   runtime       = "python3.8"

#   source_path = "../canary_app"

#   tags = {
#     Name = "canary_app_diego-jauregui-2"
#   }
# }