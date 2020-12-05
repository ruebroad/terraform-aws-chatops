variable "name" {
  description = "Name to apply to resources"
}
variable "region" { default = "eu-west-1" }
variable "cw_logs_retention_in_days" {
  default     = 3
  description = "Cloudwatch log retention in days"
}
variable "tags" {
  type        = map(any)
  default     = {}
  description = "Map of tags to apply"
}
# Lambda variables
variable "runtime" {
  default = "python3.6"
}
variable "memory_size" {
  default = 128
}
variable "timeout" {
  default = 15
}
variable "tracing_config" {
  default     = "Active"
  description = "Lambda X-Ray config - Active or Passive"
}
# Chatops variables
variable "chatops_app" {
  default     = "teams"
  description = "Chatops app - Chime, Slack, Teams"
}
variable "webhook_url" {
  description = "Chatops app webhook url"
}
variable "slack_channel" {
  default     = ""
  description = "Slack channel for notifications"
}
variable "slack_username" {
  default     = ""
  description = "Slack webhook username"
}
# Template File
variable "template_file" {
  default     = ""
  description = "Path to alternative template file"
}
# SNS
variable "kms_master_key_id" {
  default     = ""
  description = "The ID of an AWS-managed customer master key (CMK) for Amazon SNS or a custom CMK. For more information"
}
variable "encrypt_sns_topic" {
  default     = true
  type        = bool
  description = "If master key is not provided a AWS managed key will be created"
}

variable "key_usage" {
  description = "Specifies the intended use of the key. Valid values: ENCRYPT_DECRYPT or SIGN_VERIFY"
  default     = "ENCRYPT_DECRYPT"
}
variable "customer_master_key_spec" {
  description = "Specifies whether the key contains a symmetric key or an asymmetric key pair and the encryption algorithms or signing algorithms that the key supports. Valid values: SYMMETRIC_DEFAULT, RSA_2048, RSA_3072, RSA_4096, ECC_NIST_P256, ECC_NIST_P384, ECC_NIST_P521, or ECC_SECG_P256K1"
  default     = "SYMMETRIC_DEFAULT"
}
variable "kms_policy" {
  default     = ""
  description = "A valid policy JSON document"
}
variable "kms_deletion_window_in_days" {
  default     = 10
  description = "Duration in days after which the key is deleted after destruction of the resource, must be between 7 and 30 days"
}
variable "enable_key_rotation" {
  default     = true
  description = "Specifies whether key rotation is enabled"
}