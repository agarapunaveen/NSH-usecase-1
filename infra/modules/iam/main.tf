resource "aws_iam_role" "ecs_task_execution_role" {
  name = "${var.project_name}-ecs-execution-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "ecs_task_execution_role_policy" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_iam_role" "ecs_task_role" {
  name = "${var.project_name}-ecs-task-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy" "ecs_task_ecr_policy" {

  name = "ecsTaskECRPullPolicy"

  role = aws_iam_role.ecs_task_role.id
 
  policy = jsonencode({

    Version = "2012-10-17",

    Statement = [

      {

        Effect   = "Allow"

        Action   = [

          "ecr:GetAuthorizationToken",

          "ecr:BatchGetImage",

          "ecr:BatchCheckLayerAvailability"

        ]

        Resource = "arn:aws:ecr:us-east-1:010928202531:repository/*"

      }

    ]

  })

}
 