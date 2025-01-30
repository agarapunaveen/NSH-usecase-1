# # # ECR Repository
# # resource "aws_ecr_repository" "main" {
# #   name                 = var.project_name
# #   image_tag_mutability = "MUTABLE"

# #   image_scanning_configuration {
# #     scan_on_push = true
# #   }

# #   encryption_configuration {
# #     encryption_type = "KMS"
# #   }

# #   tags = {
# #     Name = "${var.project_name}-ecr"
# #   }
# # }

# # resource "aws_ecr_lifecycle_policy" "main" {
# #   repository = aws_ecr_repository.main.name

# #   policy = jsonencode({
# #     rules = [
# #       {
# #         rulePriority = 1
# #         description  = "Keep last 30 images"
# #         selection = {
# #           tagStatus     = "any"
# #           countType     = "imageCountMoreThan"
# #           countNumber   = 30
# #         }
# #         action = {
# #           type = "expire"
# #         }
# #       }
# #     ]
# #   })
# # }



# locals {
#   app_image = "public.ecr.aws/v1w2h2l9/hackathon/usecase-1:latest"
# }

# # Get AWS account ID
# data "aws_caller_identity" "current" {}

# # Get AWS region
# data "aws_region" "current" {
#     name = "us-east-1"
# }

# resource "null_resource" "docker_build_push" {
#   triggers = {
#     dockerfile_hash = filesha256("${path.root}/../Dockerfile")
#     package_json_hash = filesha256("${path.root}/../package.json")
#     src_hash = sha256(join("", [for f in fileset("${path.root}/../src", "**"): filesha256("${path.root}/../src/${f}")]))
#   }

#   provisioner "local-exec" {
#     command = <<EOF
#       # Login to ECR
#       aws ecr get-login-password --region ${data.aws_region.current.name} | docker login --username AWS --password-stdin ${data.aws_caller_identity.current.account_id}.dkr.ecr.${data.aws_region.current.name}.amazonaws.com

#       # Build the Docker image
#       docker build -t ${local.app_image} ..

#       # Push the image to ECR
#       docker push ${local.app_image}
#     EOF
#   }

# #   depends_on = [aws_ecr_repository.main]
# }


resource "null_resource" "docker_build_push" {
#   triggers = {
#     dockerfile_hash = filesha256("${path.root}/../Dockerfile")
#     package_json_hash = filesha256("${path.root}/../package.json")
#     src_hash = sha256(join("", [for f in fileset("${path.root}/../src", "**"): filesha256("${path.root}/../src/${f}")]))
#   }
provisioner "local-exec" {
    # command = <<EOF
    #   # Login to ECR
    #   aws ecr get-login-password --region ${data.aws_region.current.name} | docker login --username AWS --password-stdin ${data.aws_caller_identity.current.account_id}.dkr.ecr.${data.aws_region.current.name}.amazonaws.com

    #   # Build the Docker image
    #   docker build -t ${local.app_image} ..

    #   # Push the image to ECR
    #   docker push ${local.app_image}
    # EOF
    #!/bin/bash

# Set Variables
command = <<EOF
ECR_URL="public.ecr.aws/v1w2h2l9/hackathon/usecase-1"

# Authenticate Docker to AWS ECR
aws ecr get-login-password --region $AWS_REGION | docker login --username AWS --password-stdin $ECR_URL

# Build and Push Docker Image
docker build -t my-app .
docker tag my-app:latest $ECR_URL:latest
docker push $ECR_URL:latest
EOF
# echo "Docker image pushed to ECR: $ECR_URL"

  }
}