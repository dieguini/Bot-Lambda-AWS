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
output "lambda_function_name" {
  value = aws_lambda_function.lambda_fun.function_name
}
output "lambda_function_arn" {
  value = aws_lambda_function.lambda_fun.arn
}