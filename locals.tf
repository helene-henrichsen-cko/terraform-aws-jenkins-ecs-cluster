locals {
  tags = {
    default = {
      "Creator"     = "core platform"
      "Team"        = local.team
      "Product"     = local.product
      "Environment" = var.environment
    }
  }
  ec2_resources_name = "${local.team}-${var.environment}"
  team               = "core platform"
  product            = "core platform"

  //  qualys_activation_id = jsondecode(data.aws_secretsmanager_secret_version.core-platform.secret_string)["qualys_activation_id"]
  //  qualys_customer_id   = jsondecode(data.aws_secretsmanager_secret_version.core-platform.secret_string)["qualys_customer_id"]
}
