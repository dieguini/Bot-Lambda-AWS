# Adding S3 bucket as trigger to my lambda and giving the permissions
resource "aws_s3_bucket_notification" "aws_lambda_trigger" {
  # bucket = aws_s3_bucket.bucket.id
  bucket = var.bucket_id
  
  lambda_function {
    # lambda_function_arn = aws_lambda_function.test_lambda.arn
    lambda_function_arn = var.lambda_function_arn
    events              = ["s3:ObjectCreated:*", "s3:ObjectRemoved:*"]
    filter_prefix = "input/"
  }
}
resource "aws_lambda_permission" "lambda_s3_permission" {
  statement_id  = "AllowS3Invoke"
  action        = "lambda:InvokeFunction"
  # function_name = aws_lambda_function.test_lambda.function_name
  function_name = var.lambda_function_name
  principal     = "s3.amazonaws.com"
  # source_arn    = "arn:aws:s3:::${aws_s3_bucket.bucket.id}"
  source_arn    = "arn:aws:s3:::${var.bucket_id}"
}