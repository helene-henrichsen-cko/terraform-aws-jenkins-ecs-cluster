resource "aws_ecr_repository" "jenkins" {
  name = var.jenkins_image_name
  provisioner "local-exec" {
    command = "./deploy-image.sh ${self.repository_url} ${var.jenkins_image_name}"
  }
}
