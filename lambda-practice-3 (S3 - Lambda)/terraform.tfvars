################################################################################
# Bucket Variables
################################################################################
bucket_name = "s3-monitoting-bucket-diegojauregui-tf"
bucket_folders = ["output/", "input/"]

################################################################################
# Lambda Variables
################################################################################
lambda_function_name        = "s3_monitoring_diego_jauregui_terraform"
lambda_function_description = "Terraform lambda function - Practice 3"
# Version
lambda_publish           = true
lambda_alias_name        = "dev"
lambda_alias_description = "Development environment"
lambda_fun_version       = "3"

lambda_source_folder_code = "s3_monitoring/"
lambda_destination_folder = "s3_monitoring.zip"

lambda_role_name = "lambda_role_s3_monitoring_tf"
lambda_policy_name = "policy_lambda_for_lambda_role_s3_monitoring_tf"
lambda_policy_revoke_name = "policy_lambda_revoke_lambda_role_s3_monitoring_tf"
