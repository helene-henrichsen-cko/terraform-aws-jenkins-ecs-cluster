# AWS Jenkins Master running on ECS Module

***

## Terraform versions

Terraform >= 0.12

## Usage

```
module "jenkins" {
  source = "git@github.com:cko-core-terraform/"

  project      = "${var.project}"
  environment  = "${var.environment}"
  region       = "${var.region}"
  tag          = "Inspector"
  schedule     = "cron(0 0/6 * * ? * )"
}
```

## Examples

No examples yet.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.12 |
| terraform | >= 0.12 |

## Providers

| Name | Version |
|------|---------|
| aws | n/a |
| template | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| amis | Which AMI to spawn. Defaults to the AWS ECS optimized images. | `map` | <pre>{<br>  "us-west-1": "ami-9ad4dcfa"<br>}</pre> | no |
| availability\_zone | The availability zone | `string` | `"us-west-1b"` | no |
| cidr\_base | 16 first bits of the IPv4 VPC range, see https://checkout.atlassian.net/wiki/spaces/DevOps/pages/411075192/Amazon+Web+Services+-+CKO | `string` | `"10.0"` | no |
| desired\_instance\_capacity | Desired number of EC2 instances. | `number` | `1` | no |
| desired\_service\_count | Desired number of ECS services. | `number` | `1` | no |
| ecs\_cluster\_name | The name of the Amazon ECS cluster. | `string` | `"jenkins"` | no |
| environment | n/a | `string` | `"playground"` | no |
| instance\_type | n/a | `string` | `"m5.xlarge"` | no |
| jenkins\_repository\_url | ECR Repository for Jenkins. | `string` | `"jenkins"` | no |
| key\_name | SSH key name in your AWS account for AWS instances. | `string` | `"devops-tf"` | no |
| max\_instance\_size | Maximum number of EC2 instances. | `number` | `2` | no |
| min\_instance\_size | Minimum number of EC2 instances. | `number` | `1` | no |
| qualys\_agent\_url | The URL in which to download qualys from | `any` | n/a | yes |
| qualys\_lookup\_arn | n/a | `any` | n/a | yes |
| region | The AWS region to create resources in. | `string` | `"us-west-1"` | no |
| restore\_backup | Whether or not to restore Jenkins backup. | `bool` | `false` | no |
| s3\_bucket | S3 bucket where remote state and Jenkins data will be stored. | `string` | `"terraform-jenkins-playground-helene"` | no |

## Outputs

No output.

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Third party software
This repository uses third party software:
* [pre-commit](https://pre-commit.com/) - Used to help ensure code and documentation consistency
  * Install with `brew install pre-commit`
  * Manually use with `pre-commit run`
* [terraform-docs](https://github.com/segmentio/terraform-docs) - Used to generate the [Inputs](#Inputs) and [Outputs](#Outputs) sections
  * Install with `brew install terraform-docs`
  * Manually use via pre-commit

## .gitignore
*.terraform
*.tfstate
*.zip
