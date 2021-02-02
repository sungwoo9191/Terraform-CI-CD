#TG-Starlabs-Prod-WEB-Ext
#TG-*-*-WEB-Ext 양식이면 수정x
#target_id(타겟 인스턴스) 맞는지 확인
resource "aws_lb_target_group" "WEB" {
  name        = "TG-${var.customer}-${var.set_code}-WEB-Ext"
  target_type = "instance"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.VPC_01.id
  # proxy_protocol_v2 = "enable" # HTTP2인 디폴트값은 비활성화

  health_check {
    enabled  = "true"
    path     = "/health.html"
    protocol = "HTTP"
  }
  tags = {
    Name = "TG-${var.customer}-${var.set_code}-WEB-Ext"
  }
}
resource "aws_lb_target_group_attachment" "WEB_01" {
  target_group_arn = aws_lb_target_group.WEB.arn
  target_id        = aws_instance.WEB_01.id
  # port             = 80
}
resource "aws_lb_target_group_attachment" "WEB_02" {
  target_group_arn = aws_lb_target_group.WEB.arn
  target_id        = aws_instance.WEB_02.id
  # port             = 80
}



#TG-Starlabs-Prod-WAS-Int
#TG-*-*-WAS-Int 양식이면 수정x
#target_id(타겟 인스턴스) 맞는지 확인
#포트와 프로토콜 확인
resource "aws_lb_target_group" "WAS" {
  name        = "TG-${var.customer}-${var.set_code}-WAS-Int"
  target_type = "instance"
  port        = var.private_port
  protocol    = "TCP"
  vpc_id      = aws_vpc.VPC_01.id
  # proxy_protocol_v2 = "enable" # HTTP2인 디폴트값은 비활성화

  /* TCP 기본 설정은 없음.
  health_check {
    enabled  = "true"
    path     = "/health.html"
    protocol = "HTTP"
  }
  */
  tags = {
    Name = "TG-${var.customer}-${var.set_code}-WAS-Int"
  }
}
resource "aws_lb_target_group_attachment" "WAS_01" {
  target_group_arn = aws_lb_target_group.WAS.arn
  target_id        = aws_instance.WAS_01.id
  # port             = var.private_port
}
resource "aws_lb_target_group_attachment" "WAS_02" {
  target_group_arn = aws_lb_target_group.WAS.arn
  target_id        = aws_instance.WAS_02.id
  # port             = var.private_port
}