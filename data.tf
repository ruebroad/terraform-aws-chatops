data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

resource "null_resource" "build" {
  count = local.build_command != "" ? 1 : 0

  triggers = local.build_triggers

  provisioner "local-exec" {
    command = local.build_command
  }
}

# Trick to run the build command before archiving.
# See below for more detail.
# https://github.com/terraform-providers/terraform-provider-archive/issues/11
data "null_data_source" "build_dep" {
  inputs = {
    build_id   = length(null_resource.build) > 0 ? null_resource.build[0].id : ""
    source_dir = local.source_dir
  }
}

data "archive_file" "source" {
  type        = "zip"
  source_dir  = data.null_data_source.build_dep.outputs.source_dir
  output_path = local.output_path
}

data "template_file" "chime" {
  count    = local.use_chime
  template = local.template_file
  vars = {
    webhook_url = var.webhook_url
  }
}

data "template_file" "slack" {
  count    = local.use_slack
  template = local.template_file
  vars = {
    webhook_url    = var.webhook_url
    slack_channel  = var.slack_channel
    slack_username = var.slack_username
  }
}

data "template_file" "teams" {
  count    = local.use_teams
  template = local.template_file
  vars = {
    webhook_url = var.webhook_url
  }
}

resource "local_file" "chime_code" {
  depends_on = [data.template_file.chime]
  count      = local.use_chime
  content    = data.template_file.chime.*.rendered[count.index]
  filename   = "${path.module}/code/chatops.py"
}

resource "local_file" "slack_code" {
  depends_on = [data.template_file.slack]
  count      = local.use_slack
  content    = data.template_file.slack.*.rendered[count.index]
  filename   = "${path.module}/code/chatops.py"
}

resource "local_file" "teams_code" {
  depends_on = [data.template_file.teams]
  count      = local.use_teams
  content    = data.template_file.teams.*.rendered[count.index]
  filename   = "${path.module}/code/chatops.py"
}
