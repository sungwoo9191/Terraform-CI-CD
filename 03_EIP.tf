#이름 확인 필수
resource "aws_eip" "EIP_NAT_Prod" {
  vpc                  = true
  network_border_group = var.region # 네트워크 경계 그룹
  public_ipv4_pool     = "amazon"   # 퍼블릭 IPv4 주소 폴
  tags = {
    Name = "EIP_NAT_${var.set_code}"
  }
}

#이름 확인 필수, 테그도 같이 수정
resource "aws_eip" "EIP_EC2_Starlabs_Prod_Bastion_01_KRAWSAP0001" {
  instance             = aws_instance.Bastion_01.id
  vpc                  = true
  network_border_group = var.region
  public_ipv4_pool     = "amazon"

  tags = {
    Name = "EIP_EC2_Starlabs_Prod_Bastion_01_KRAWSAP0001"
  }
}

#이름 확인 필수, 테그도 같이 수정
resource "aws_eip" "EIP_EC2_Starlabs_Prod_Bastion_02_KRAWSWP0002" {
  instance             = aws_instance.Bastion_02.id
  vpc                  = true
  network_border_group = var.region
  public_ipv4_pool     = "amazon"

  tags = {
    Name = "EIP_EC2_Starlabs_Prod_Bastion_02_KRAWSWP0002"
  }
}