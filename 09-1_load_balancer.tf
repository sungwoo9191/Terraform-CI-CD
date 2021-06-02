# HTTPS 적용 안함 (주석처리)
# ALB-Starlabs-Prod-WEB-Ext
# ALB-*-*-WEB-Ext 형식, 이름 변경 시 태그와 같이 변경

# 80 -> 443 리다이렉트 사용 안하면, 09-2_LB_HTTPS.tf 주석처리
# 마찬가지로 아래 ALB_forward default_action 주석 변경

resource "aws_lb" "ALB" {
  name               = "ALB-${var.customer}-${var.set_code}-WEB-Ext"
  internal           = false
  load_balancer_type = "application"
  ip_address_type    = "ipv4"
  security_groups    = [aws_security_group.ALB.id]

  # enable_deletion_protection = true
  subnet_mapping {
    subnet_id = aws_subnet.Public_ALB_AZ1_01.id
  }
  subnet_mapping {
    subnet_id = aws_subnet.Public_ALB_AZ2_01.id
  }

  tags = {
    Name = "ALB-${var.customer}-${var.set_code}-WEB-Ext"
  }
}
resource "aws_lb_listener" "ALB_http" {
  load_balancer_arn = aws_lb.ALB.arn
  port              = "80" # HTTPS 리다이렉션 사용안하면, default_action 주석 변경
  protocol          = "HTTP"
  /*
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.WEB.arn
  }
  */
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



# var에서 이름 수정
# 태그 이름, 포트 확인
resource "aws_lb" "NLB" {
  name               = var.nlb_name
  internal           = true
  load_balancer_type = "network"
  ip_address_type    = "ipv4"

  enable_cross_zone_load_balancing = true # 교차 영역 로드 밸런싱

  # enable_deletion_protection = true
  subnet_mapping {
    subnet_id = aws_subnet.Private_NLB_AZ1_01.id
  }
  subnet_mapping {
    subnet_id = aws_subnet.Private_NLB_AZ2_01.id
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