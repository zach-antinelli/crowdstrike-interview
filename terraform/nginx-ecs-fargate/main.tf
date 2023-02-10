terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

provider "docker" {}

provider "aws" {
  region = var.region
}

#output "public_ip" {
#  description = "Public IP Address for NLB associated with the ECS NGINX container"
#  value       = aws_lb.ecs_lb.public_ip
#}