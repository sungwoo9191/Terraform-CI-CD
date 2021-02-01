
#인터넷 게이트웨이
#이름 변경시, locals id 이름도 변경
resource "aws_internet_gateway" "IG_Prod" {
  vpc_id = local.vpc_id_value # VPC

  tags = {
    Name = "IG_${var.set_code}"
  }
}

#NAT 게이트웨이
# allocation_id와 subnet_id 확인 필수
# 이름 변경시, locals id 이름도 변경
resource "aws_nat_gateway" "NAT_Prod" {
  allocation_id = aws_eip.EIP_NAT_Prod.id # 탄력적 IP(EIP)
  subnet_id     = local.subnet_alb_az1.id # 서브넷

  tags = {
    Name = "NAT_Prod"
  }
}
