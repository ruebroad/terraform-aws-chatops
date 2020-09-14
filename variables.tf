variable "name" {
  description = "Name to apply to resources"
}

variable "cw_logs_retention_in_days" {
  default     = 3
  description = "Cloudwatch log retention in days"
}

variable "tags" {
  type        = map
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
