resource "aws_sns_topic" "main" {
  name                                = var.name
  lambda_success_feedback_role_arn    = aws_iam_role.sns.arn
  lambda_failure_feedback_role_arn    = aws_iam_role.sns.arn
  lambda_success_feedback_sample_rate = 10
  kms_master_key_id                   = local.kms_master_key_id

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

resource "aws_kms_key" "sns" {
  count                    = local.create_kms_key
  description              = var.name
  deletion_window_in_days  = var.kms_deletion_window_in_days
  key_usage                = var.key_usage
  customer_master_key_spec = var.customer_master_key_spec
  policy                   = var.kms_policy
  enable_key_rotation      = var.enable_key_rotation

  tags = merge(var.tags,
    map("Name", var.name),
    map("Workspace", lower(terraform.workspace)),
  )
}

resource "aws_kms_alias" "sns" {
  count         = local.create_kms_key
  name          = "alias/${var.name}"
  target_key_id = aws_kms_key.sns[0].key_id
}
