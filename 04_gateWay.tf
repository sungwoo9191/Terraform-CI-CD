
#인터넷 게이트웨이
resource "aws_internet_gateway" "IG" {
  vpc_id = aws_vpc.VPC_01.id # VPC

  tags = {
    Name = "IG_${var.set_code}"
  }
}

#NAT 게이트웨이
resource "aws_nat_gateway" "NAT" {
  allocation_id = aws_eip.NAT.id                  # 탄력적 IP(EIP)
  subnet_id     = aws_subnet.Public_ALB_AZ1_01.id # 서브넷

  tags = {
    Name = "NAT_${var.set_code}"
  }
}
