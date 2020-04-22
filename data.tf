# # ---------------------------------------------------------------------------------------------------------------------
# # Get base vpc variables
# # ---------------------------------------------------------------------------------------------------------------------
# data "aws_vpc" "default_vpc" {
#   cidr_block = "${var.cidr_base}0.0/16"
# }
#
# data "aws_subnet_ids" "private" {
#   vpc_id = data.aws_vpc.hub_vpc.id
#   filter {
#     name   = "tag:Name"
#     values = [var.private_subnets_name]
#   }
# }

#----- ECS  Resources--------
#For now we only use the AWS ECS optimized ami <https://docs.aws.amazon.com/AmazonECS/latest/developerguide/ecs-optimized_AMI.html>
data "aws_ami" "amazon_linux_ecs" {
  most_recent = true

  owners = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-ecs-hvm-*-x86_64-ebs"]
  }

  filter {
    name   = "owner-alias"
    values = ["amazon"]
  }
}
