# 사전에 AWS Console에서 AWS Certificate Manager 들어가서 인증서 생성함.
# data를 사용하여 발급한 인증서를 불러옴.

data "aws_acm_certificate" "domain_01" {
  domain   = "*.example.com" # AWS Certificate Manager 도메인 이름
  statuses = ["ISSUED"]
}

resource "aws_alb_listener" "ALB_https" {
  load_balancer_arn = aws_lb.ALB.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = data.aws_acm_certificate.domain_01.arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.WEB.arn
  }
}