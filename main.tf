

resource "aws_lambda_function" "main" {
  filename         = data.archive_file.source.output_path
  role             = aws_iam_role.lambda.arn
  source_code_hash = data.archive_file.source.output_base64sha256

  runtime       = var.runtime
  handler       = local.handler
  description   = "Lambda SNS to Chat Notifications"
  function_name = var.name
  memory_size   = var.memory_size
  timeout       = var.timeout
  tracing_config {
    mode = var.tracing_config
  }

  tags = merge(
    var.tags,
    map(
      "Name", var.name,
      "Workspace", terraform.workspace
    )
  )

  lifecycle {
    ignore_changes = [filename]
  }
}

resource "aws_lambda_permission" "with_sns" {
  statement_id  = "AllowExecutionFromSNS"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.main.function_name
  principal     = "sns.amazonaws.com"
  source_arn    = aws_sns_topic.main.arn
}
