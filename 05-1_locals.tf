#서브넷 이름 확인 필수
locals {
  #퍼블릭 서브넷과 라우팅 하는 리스트. 뒤에 ,있음
  public_subnets = {
    name = list(
      aws_subnet.Public_ALB_AZ1_01,
      aws_subnet.Public_ALB_AZ2_01,
      aws_subnet.Public_Bastion_AZ1_01
    )
  }

  #프라이빗 서브넷과 라우팅 하는 리스트. 뒤에 ,있음
  private_subnets = {
    name = list(
      aws_subnet.Private_NLB_AZ1_01,
      aws_subnet.Private_NLB_AZ2_01,
      aws_subnet.Private_WEB_AZ1_01,
      aws_subnet.Private_WEB_AZ2_01,
      aws_subnet.Private_WAS_AZ1_01,
      aws_subnet.Private_WAS_AZ2_01,
      aws_subnet.Private_DB_AZ1_01,
      aws_subnet.Private_DB_AZ2_01
    )
  }
}