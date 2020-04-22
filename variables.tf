variable "region" {
  description = "The AWS region to create resources in."
  default     = "us-west-1"
}

variable environment {
  default = "playground"
}

variable cidr_base {
  description = "16 first bits of the IPv4 VPC range, see https://checkout.atlassian.net/wiki/spaces/DevOps/pages/411075192/Amazon+Web+Services+-+CKO"
  default     = "10.0"
}

variable "availability_zone" {
  description = "The availability zone"
  default     = "us-west-1b"
}

variable "ecs_cluster_name" {
  description = "The name of the Amazon ECS cluster."
  default     = "jenkins"
}

variable "amis" {
  description = "Which AMI to spawn. Defaults to the AWS ECS optimized images."
  default = {
    us-west-1 = "ami-8f7687e2"
    us-west-1 = "ami-bb473cdb"
    us-west-1 = "ami-9ad4dcfa"
  }
}

variable "instance_type" {
  default = "m5.xlarge"
}

variable "key_name" {
  default     = "devops-tf"
  description = "SSH key name in your AWS account for AWS instances."
}

variable "min_instance_size" {
  default     = 1
  description = "Minimum number of EC2 instances."
}

variable "max_instance_size" {
  default     = 2
  description = "Maximum number of EC2 instances."
}

variable "desired_instance_capacity" {
  default     = 1
  description = "Desired number of EC2 instances."
}

variable "desired_service_count" {
  default     = 1
  description = "Desired number of ECS services."
}

variable "s3_bucket" {
  default     = "terraform-jenkins-playground-helene"
  description = "S3 bucket where remote state and Jenkins data will be stored."
}

variable "restore_backup" {
  default     = false
  description = "Whether or not to restore Jenkins backup."
}

variable "jenkins_repository_url" {
  default     = "jenkins"
  description = "ECR Repository for Jenkins."
}

variable "qualys_agent_url" {
  description = "The URL in which to download qualys from"
}

variable "qualys_lookup_arn" {}
