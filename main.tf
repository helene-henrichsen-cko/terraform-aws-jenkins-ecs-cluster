resource "aws_vpc" "jenkins" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true

  tags = {
    Name = "helene-test"
  }
}

resource "aws_route_table" "external" {
  vpc_id = aws_vpc.jenkins.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.jenkins.id
  }

  tags = {
    Name = "helene-test"
  }
}

resource "aws_route_table_association" "external-jenkins" {
  subnet_id      = aws_subnet.jenkins.id
  route_table_id = aws_route_table.external.id
}

resource "aws_subnet" "jenkins" {
  vpc_id            = aws_vpc.jenkins.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = var.availability_zone

  tags = {
    Name    = "helene-test"
    Product = "test"
  }
}

resource "aws_internet_gateway" "jenkins" {
  vpc_id = aws_vpc.jenkins.id

  tags = {
    Name = "helene-test"
  }
}

resource "aws_security_group" "sg_jenkins" {
  name        = "sg_${var.ecs_cluster_name}"
  description = "Allows all traffic"
  vpc_id      = aws_vpc.jenkins.id

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    cidr_blocks = [
      "0.0.0.0/0",
    ]
  }

  ingress {
    from_port = 80
    to_port   = 80
    protocol  = "tcp"
    cidr_blocks = [
      "0.0.0.0/0",
    ]
  }

  ingress {
    from_port = 443
    to_port   = 443
    protocol  = "tcp"
    cidr_blocks = [
      "0.0.0.0/0",
    ]
  }

  ingress {
    from_port = 50000
    to_port   = 50000
    protocol  = "tcp"
    cidr_blocks = [
      "0.0.0.0/0",
    ]
  }

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = [
      "0.0.0.0/0",
    ]
  }
}

resource "aws_ecs_cluster" "jenkins" {
  name = var.ecs_cluster_name
}

data "template_file" "user_data" {
  template = file("templates/user_data.tpl")

  vars = {
    s3_bucket        = var.s3_bucket
    ecs_cluster_name = var.ecs_cluster_name
    restore_backup   = var.restore_backup
  }
}

module "autoscaling" {
  source  = "terraform-aws-modules/autoscaling/aws"
  version = "~> 3.0"

  name = "asg_${var.ecs_cluster_name}"

  # Launch configuration
  lc_name = "lc_${var.ecs_cluster_name}-"

  image_id                    = data.aws_ami.amazon_linux_ecs.id
  instance_type               = "m5.large"
  security_groups             = ["${aws_security_group.sg_jenkins.id}"]
  iam_instance_profile        = aws_iam_instance_profile.iam_instance_profile.name
  user_data                   = data.template_file.user_data.rendered
  key_name                    = var.key_name
  associate_public_ip_address = true

  # Auto scaling group
  asg_name                  = local.ec2_resources_name
  vpc_zone_identifier       = ["${aws_subnet.jenkins.id}"]
  health_check_type         = "EC2"
  min_size                  = var.min_instance_size
  max_size                  = var.max_instance_size
  desired_capacity          = var.desired_instance_capacity
  wait_for_capacity_timeout = 0

  tags = list(
    map("key", "Environment", "value", var.environment, "propagate_at_launch", true),
    map("key", "Team", "value", local.team, "propagate_at_launch", true),
  )
}
