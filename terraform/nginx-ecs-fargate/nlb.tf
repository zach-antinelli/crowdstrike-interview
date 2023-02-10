resource "aws_lb" "ecs_lb" {
  name               = "ecs-lb"
  load_balancer_type = "network"
  internal           = false
  subnets = [aws_subnet.public.id]

  tags = {
    name = "ecs-nginx"
  }
}

resource "aws_lb_target_group" "ecs_lb_tg" {
  name        = "ecs-lb-tg"
  port        = 80
  protocol    = "TCP"
  target_type = "ip"
  vpc_id      = aws_vpc.vpc.id
}

resource "aws_lb_listener" "ecs_lb_ls" {
  load_balancer_arn = aws_lb.ecs_lb.arn
  port              = 80
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ecs_lb_tg.arn
  }
}