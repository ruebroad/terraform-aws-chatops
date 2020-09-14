resource "aws_cloudwatch_log_group" "lambda" {
  name              = "/aws/lambda/${aws_lambda_function.main.function_name}"
  retention_in_days = var.cw_logs_retention_in_days
}

resource "aws_cloudwatch_log_group" "sns" {
  name              = "sns/${data.aws_region.current.name}/${data.aws_caller_identity.current.account_id}/${var.name}"
  retention_in_days = var.cw_logs_retention_in_days
}

