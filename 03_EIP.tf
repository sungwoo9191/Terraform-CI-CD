resource "aws_eip" "NAT" {
  vpc                  = true
  network_border_group = var.region # 네트워크 경계 그룹
  public_ipv4_pool     = "amazon"   # 퍼블릭 IPv4 주소 폴
  tags = {
    Name = "EIP_NAT_${var.set_code}"
  }
}

resource "aws_eip" "Bastion_01" {
  instance             = aws_instance.Bastion_01.id
  vpc                  = true
  network_border_group = var.region
  public_ipv4_pool     = "amazon"

  tags = {
    Name = "EIP_EC2_${var.customer}_${var.set_code}_Bastion_01_${var.country}AWS${var.os_amzn2}P0001"
  }
}

resource "aws_eip" "Bastion_02" {
  instance             = aws_instance.Bastion_02.id
  vpc                  = true
  network_border_group = var.region
  public_ipv4_pool     = "amazon"

  tags = {
    Name = "EIP_EC2_${var.customer}_${var.set_code}_Bastion_02_${var.country}AWS${var.os_win}P0002"
  }
}