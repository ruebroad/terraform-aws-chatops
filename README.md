# Terraform Chatops Module

Current version: v0.3.0

[![CircleCI](https://circleci.com/gh/ruebroad/terraform-aws-chatops.svg?style=shield)](https://app.circleci.com/pipelines/github/ruebroad/terraform-aws-chatops)

SNS topic and Lambda function for sending messages to MS Teams, AWS Chime or Slack

Works with AWS Chime, MS Teams or Slack. If the default lambda function (template file) is not suitable it can be replaced with a different function.

## Usage

```(terraform)
module "aws_chatops" {
  source = "https://github.com/ruebroad/terraform-aws-chatops?ref=v0.3.0"

  name = ""
  webhook_url = ""
}
```

## Replacing the default Lambda function

Specify the path to a template file when calling the module e.g.

```(terraform)
template_file  = file("${path.root}/files/slack.tpl")
```

For Slack, Teams and Chime it must include:

```(python)
url = "${webhook_url}"
```

For Slack the message body must also include:

```(python)
"channel": "${slack_channel}",
"username": "${slack_username}",
```

The "files" folder contains a modified version of the slack Lambda function template as there is some additional processing of the SNS event message required to be able to extract specific fields.

### Language

Language can also be changed to PowerShell, Node or whatever. In this case the runtime variable should be changed from the default of "python3.6"

## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| archive | n/a |
| aws | n/a |
| local | n/a |
| null | n/a |
| template | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| chatops\_app | Chatops app - Chime, Slack, Teams | `string` | `"teams"` | no |
| cw\_logs\_retention\_in\_days | Cloudwatch log retention in days | `number` | `3` | no |
| memory\_size | n/a | `number` | `128` | no |
| name | Name to apply to resources | `any` | n/a | yes |
| runtime | Lambda variables | `string` | `"python3.6"` | no |
| slack\_channel | Slack channel for notifications | `string` | `""` | no |
| slack\_username | Slack webhook username | `string` | `""` | no |
| tags | Map of tags to apply | `map` | n/a | no |
| template\_file | Path to alternative template file | `string` | `""` | no |
| timeout | n/a | `number` | `15` | no |
| tracing\_config | Lambda X-Ray config - Active or Passive | `string` | `"Active"` | no |
| webhook\_url | Chatops app webhook url | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| function\_name | n/a |
| invoke\_arn | n/a |
| sns\_topic\_arn | n/a |
