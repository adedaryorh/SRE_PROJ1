# ---------------------------------------------------------------------------------------------------------------------
# ALB
# ---------------------------------------------------------------------------------------------------------------------

resource "aws_alb" "alb" {
  name            = var.name
  subnets         = var.subnets
  internal        = var.is_internal
  security_groups = [aws_security_group.sg.id]


}
# ---------------------------------------------------------------------------------------------------------------------
# Target group
# ---------------------------------------------------------------------------------------------------------------------

resource "aws_alb_target_group" "app_tg" {
  name        = "${var.name}-tg"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "instance"
  depends_on = [aws_alb.alb]
  health_check {
    protocol = "HTTP"
    path     = "/metrics"
    port     = 80
  }


}
# ---------------------------------------------------------------------------------------------------------------------
# 80 listener 
# ---------------------------------------------------------------------------------------------------------------------

resource "aws_lb_listener" "app_80" {
  load_balancer_arn = aws_alb.alb.id
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.app_tg.arn
  }
}
# ---------------------------------------------------------------------------------------------------------------------
# Security group
# ---------------------------------------------------------------------------------------------------------------------

resource "aws_security_group" "sg" {
  name        = "alb_sg"
  description = "controls access to the ALB"
  vpc_id      = var.vpc_id

  ingress {
    protocol    = "tcp"
    from_port   = 80
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
