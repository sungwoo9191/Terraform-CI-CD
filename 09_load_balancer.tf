# HTTPS 적용 안함 (주석처리)
# ALB-Starlabs-Prod-WEB-Ext
# ALB-*-*-WEB-Ext 형식, 이름 변경 시 태그와 같이 변경
resource "aws_lb" "ALB" {
  name               = "ALB-${var.customer}-${var.set_code}-WEB-Ext"
  internal           = false
  load_balancer_type = "application"
  ip_address_type    = "ipv4"
  security_groups    = [aws_security_group.ALB.id]

  # enable_deletion_protection = true
  subnet_mapping {
    subnet_id = local.subnet_alb_az1.id
  }
  subnet_mapping {
    subnet_id = local.subnet_alb_az2.id
  }

  tags = {
    Name = "ALB-${var.customer}-${var.set_code}-WEB-Ext"
  }
}
resource "aws_lb_listener" "ALB_forward" {
  load_balancer_arn = aws_lb.ALB.arn
  port              = "80"   # HTTPS 리다이렉션 적용시, 443 아래 주석 제거
  protocol          = "HTTP" # HTTPS 적용시, HTTPS

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.WEB.arn
  }
}
/*
resource "aws_lb_listener" "ALB_redirect" {
  load_balancer_arn = aws_lb.ALB.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"

      # host  = "호스트"  # 디폴트 {host}
      # path  = "path"   # 디폴트 {host}
      # query = "쿼리"    # 디폴트 {query}
    }
  }
}
resource "aws_lb_listener_rule" "host_based_weighted_routing" {
  listener_arn = aws_lb_listener.front_end.arn
  priority     = 99

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.static.arn
  }

  condition {
    host_header {
      values = ["my-service.*.terraform.io"]
    }
  }
}
*/



# var에서 이름 수정
# 태그 이름, 포트 확인
resource "aws_lb" "NLB" {
  name               = var.nlb_name
  internal           = true
  load_balancer_type = "network"
  ip_address_type    = "ipv4"

  # enable_deletion_protection = true
  subnet_mapping {
    subnet_id = local.subnet_nlb_az1.id
  }
  subnet_mapping {
    subnet_id = local.subnet_nlb_az2.id
  }

  tags = {
    Name = "NLB-${var.customer}-${var.set_code}-WAS-Int"
  }
}
resource "aws_lb_listener" "NLB" {
  load_balancer_arn = aws_lb.NLB.arn
  port              = var.private_port
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.WAS.arn
  }
}