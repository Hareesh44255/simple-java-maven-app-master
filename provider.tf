//
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.5.0"
    }
  }
}

//
provider "aws" {
  region  = var.region
  profile = "default" # if you have multiple profiles, else default is used
}

# resource "docker_image" "nginx" {
#   name         = "nginx:latest"
#   keep_locally = false
# }

# resource "docker_container" "nginx" {
#   image = docker_image.nginx.image_id
#   name  = "tutorial"
#   ports {
#     internal = 80
#     external = 8000
#   }
# }