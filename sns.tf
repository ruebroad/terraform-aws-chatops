resource "aws_sns_topic" "main" {
  name                                = var.name
  lambda_success_feedback_role_arn    = aws_iam_role.sns.arn
  lambda_failure_feedback_role_arn    = aws_iam_role.sns.arn
  lambda_success_feedback_sample_rate = 10

  tags = merge(var.tags,
    map("Name", var.name),
    map("Workspace", lower(terraform.workspace)),
  )
}

resource "aws_sns_topic_subscription" "main" {
  topic_arn = aws_sns_topic.main.arn
  protocol  = "lambda"
  endpoint  = aws_lambda_function.main.arn
}
