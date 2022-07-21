resource "aws_alb" "alb" {
  security_groups = var.security_groups
  count = 2
  subnets         = var.subnets
  #Name            = "terraform-alb"
}
resource "aws_alb_target_group" "group" {
  port     = 80
  protocol = "HTTP"
  vpc_id = var.vpcid
  stickiness {
    type = "lb_cookie"
  }
  # Alter the destination of the health check to be the login page.
  health_check {
    path = "/login"
    port = 80
  }
}
resource "aws_alb_listener" "listener_http" {
  count = 2
  load_balancer_arn = "${aws_alb.alb[count.index].arn}"
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = "${aws_alb_target_group.group.arn}"
    type             = "forward"
  }
}
resource "aws_alb_listener" "listener_https" {
  count = 2
  load_balancer_arn = "${aws_alb.alb[count.index].arn}"
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  #certificate_arn   = "${var.certificate_arn}"
  default_action {
    target_group_arn = "${aws_alb_target_group.group.arn}"
    type             = "forward"
  }
}
