data "aws_ecr_repository" "ecr_repo" {
  name = "docker_images"
}

resource "aws_security_group" "ecs_sg" {
  name   = "ecs-security-group"
  vpc_id = aws_vpc.vpc.id

  ingress {
    protocol    = "tcp"
    from_port   = 80
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    protocol    = "tcp"
    from_port   = 443
    to_port     = 443
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_ecs_cluster" "ecs_cluster" {
  name = "ecs-cluster"
}

resource "aws_ecs_service" "ecs_service" {
  name            = "ecs-service"
  cluster         = aws_ecs_cluster.ecs_cluster.id
  task_definition = aws_ecs_task_definition.ecs_task.arn
  launch_type     = "FARGATE"
  desired_count   = 1

  network_configuration {
    assign_public_ip = true
    security_groups  = [aws_security_group.ecs_sg.id]
    subnets          = [aws_subnet.public.id, aws_subnet.public2.id]
  }

  #  load_balancer {
  #    target_group_arn = aws_lb_target_group.http.arn
  #    container_name   = "nginx"
  #    container_port   = 80
  #  }
  #
  #  load_balancer {
  #    target_group_arn = aws_lb_target_group.https.arn
  #    container_name   = "nginx"
  #    container_port   = 443
  #  }
}

resource "aws_ecs_task_definition" "ecs_task" {
  family                   = "ecs_task"
  container_definitions    = <<DEFINITION
  [
    {
      "name": "nginx",
      "image": "${data.aws_ecr_repository.ecr_repo.repository_url}:nginx-ubuntu",
      "essential": true,
      "cpu": 256,
      "memory": 512,
      "portMappings": [
        {
          "protocol": "tcp",
          "containerPort": 80,
          "hostPort": 80
        },
        {
          "protocol": "tcp",
          "containerPort": 443,
          "hostPort": 443
        }
      ]
    }
  ]
  DEFINITION
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  memory                   = 512
  cpu                      = 256
  execution_role_arn       = aws_iam_role.ecsTaskExecutionRole.arn
}

data "aws_iam_policy_document" "ecs-assume-role-policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "ecsTaskExecutionRole" {
  name               = "ecsTaskExecutionRole"
  assume_role_policy = data.aws_iam_policy_document.ecs-assume-role-policy.json
}

resource "aws_iam_role_policy_attachment" "ecsTaskExecutionRole_policy" {
  role       = aws_iam_role.ecsTaskExecutionRole.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}