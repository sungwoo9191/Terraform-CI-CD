# 도메인 이름 및 원하는 도메인 추가



# Route53 없을시 이와 같이 생성
/*
resource "aws_route53_zone" "domain_01" {
  name = "example.com"
}
*/

# root domain (www O)
resource "aws_route53_record" "www_zone" {
  zone_id = "Z012345678P2ZFJKIP56R" # your 호스팅 영역 ID, 테라폼으로 생성시 주석 변경
  # zone_id = aws_route53_zone.domain_01.zone_id
  name = "www.example.com"
  type = "CNAME"
  ttl  = 300

  records = [aws_lb.ALB.dns_name]
}

# root domain (www X)
resource "aws_route53_record" "A_zone" {
  zone_id = "Z012345678P2ZFJKIP56R" # your 호스팅 영역 ID, 테라폼으로 생성시 주석 변경
  # zone_id = aws_route53_zone.domain_01.zone_id
  name = "example.com"
  type = "A" # OR "AAAA"

  alias {
    name                   = aws_lb.ALB.dns_name
    zone_id                = aws_lb.ALB.zone_id
    evaluate_target_health = true
  }
}
