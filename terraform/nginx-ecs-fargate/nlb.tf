resource "aws_lb" "ecs_lb" {
  name               = "ecs-lb"
  load_balancer_type = "network"
  internal           = false
  subnets            = [aws_subnet.public.id, aws_subnet.public2.id]

  tags = {
    name = "ecs-nginx"
  }
}

# for_each these
resource "aws_lb_target_group" "http" {
  name     = "ecs-lb-tg-http"
  port     = 80
  protocol = "tcp"
  vpc_id   = aws_vpc.vpc.id
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.ecs_lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.http.arn
  }
}