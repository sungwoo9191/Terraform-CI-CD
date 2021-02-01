#locals에 id를 얻기위한 이름을 모아둠.


#vpc만 id까지 입력, 이름 확인 필수
locals {
  vpc_id_value = aws_vpc.VPC_Starlabs_Prod.id
}


#서브넷 이름 확인 필수
locals {
  subnet_alb_az1 = aws_subnet.Subnet_Public_Prod_ALB_AZ1_01
  subnet_alb_az2 = aws_subnet.Subnet_Public_Prod_ALB_AZ2_01
  subnet_bastion = aws_subnet.Subnet_Public_Prod_Bastion_AZ1_01

  subnet_nlb_az1 = aws_subnet.Subnet_Private_Prod_NLB_AZ1_01
  subnet_nlb_az2 = aws_subnet.Subnet_Private_Prod_NLB_AZ2_01
  subnet_web_az1 = aws_subnet.Subnet_Private_Prod_WEB_AZ1_01
  subnet_web_az2 = aws_subnet.Subnet_Private_Prod_WEB_AZ2_01
  subnet_was_az1 = aws_subnet.Subnet_Private_Prod_WAS_AZ1_01
  subnet_was_az2 = aws_subnet.Subnet_Private_Prod_WAS_AZ2_01
  subnet_db_az1  = aws_subnet.Subnet_Private_Prod_DB_AZ1_01
  subnet_db_az2  = aws_subnet.Subnet_Private_Prod_DB_AZ2_01

  #퍼블릭 서브넷과 라우팅 하는 리스트. 뒤에 ,있음
  public_subnet = {
    name = list(
      aws_subnet.Subnet_Public_Prod_ALB_AZ1_01,
      aws_subnet.Subnet_Public_Prod_ALB_AZ2_01,
      aws_subnet.Subnet_Public_Prod_Bastion_AZ1_01
    )
  }

  #프라이빗 서브넷과 라우팅 하는 리스트. 뒤에 ,있음
  private_subnet = {
    name = list(
      aws_subnet.Subnet_Private_Prod_NLB_AZ1_01,
      aws_subnet.Subnet_Private_Prod_NLB_AZ2_01,
      aws_subnet.Subnet_Private_Prod_WEB_AZ1_01,
      aws_subnet.Subnet_Private_Prod_WEB_AZ2_01,
      aws_subnet.Subnet_Private_Prod_WAS_AZ1_01,
      aws_subnet.Subnet_Private_Prod_WAS_AZ2_01,
      aws_subnet.Subnet_Private_Prod_DB_AZ1_01,
      aws_subnet.Subnet_Private_Prod_DB_AZ2_01
    )
  }
}

#게이트웨이
locals {
  IG  = aws_internet_gateway.IG_Prod
  NAT = aws_nat_gateway.NAT_Prod
}