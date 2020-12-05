locals {
  handler       = "chatops.lambda_handler"
  build_command = "${path.module}/pip.sh ${path.module}/requirements.txt ${path.module}/code"
  source_dir    = "${path.module}/code"
  output_path   = "${path.module}/output/chatops.zip"
  build_triggers = {
    requirements = base64sha256(file("${path.module}/requirements.txt"))
    execute      = base64sha256(file("${path.module}/pip.sh"))
  }
  chime_template = "chime.tpl"
  slack_template = "slack.tpl"
  teams_template = "teams.tpl"
  use_chime      = var.chatops_app == "chime" ? 1 : 0
  use_slack      = var.chatops_app == "slack" ? 1 : 0
  use_teams      = var.chatops_app == "teams" ? 1 : 0
  template_file = var.template_file != "" ? var.template_file : (
    var.chatops_app == "chime" ? file("${path.module}/files/${local.chime_template}") :
    var.chatops_app == "teams" ? file("${path.module}/files/${local.teams_template}") :
    file("${path.module}/files/${local.slack_template}")
  )

  create_kms_key    = var.encrypt_sns_topic == true && var.kms_master_key_id == "" ? 1 : 0
  kms_master_key_id = (var.encrypt_sns_topic == true && var.kms_master_key_id == "") ? aws_kms_key.sns[0].key_id : (var.encrypt_sns_topic == true && var.kms_master_key_id != "") ? var.kms_master_key_id : ""
}
