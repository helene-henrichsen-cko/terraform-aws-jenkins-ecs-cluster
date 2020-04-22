provider "aws" {
  region = var.region
}

# provider "aws" {
#   alias  = "qualys_lookup"
#   region = var.region
#
#   assume_role {
#     role_arn = var.qualys_lookup_arn
#   }
# }

provider "aws" {
  alias  = "mgmt"
  region = var.region
}

terraform {
  required_version = ">= 0.12"

  backend "s3" {
    bucket = "terraform-jenkins-playground-helene"
    key    = "jenkins/terraform.tfstate"
    region = "us-west-1"
  }
}
