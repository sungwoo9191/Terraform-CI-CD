#해당 인스턴스는 EIP와 연결되어있음
#명세서와 맞는지 확인 필수(ami, region, type, subnet, ip, 용량)
#EC2_Starlabs_Prod_Bastion_01_KRAWSAP0001
resource "aws_instance" "Bastion_01" {
  ami                                  = var.amzn2               # 생성 OS
  instance_type                        = "t2.micro"              # 인스턴스 타입
  availability_zone                    = "${var.region}a"        # 생성 지역
  subnet_id                            = local.subnet_bastion.id # bastion subnet
  instance_initiated_shutdown_behavior = "stop"                  # 종료방식
  disable_api_termination              = "false"                 # 우발적 종료 보호

  #EIP와 연결된 인스턴스는 public_ip를 적지 않음.
  private_ip             = "10.0.2.10"
  vpc_security_group_ids = [aws_security_group.Bastion.id] # 보안 그룹
  key_name               = var.key_name

  #저장소
  root_block_device {
    volume_type           = "gp2"   # default: gp2
    volume_size           = "30"    # 용량
    delete_on_termination = "true"  # 인스턴스 삭제 시, 자동 삭제
    encrypted             = "false" # 암호화

    tags = {
      Name = "Volume_EC2_${var.customer}_${var.set_code}_Bastion_01_${var.country}AWS${var.os_amzn2}P0001_${var.volume_amzn2}"
    }
  }

  tags = {
    Name = "EC2_${var.customer}_${var.set_code}_Bastion_01_${var.country}AWS${var.os_amzn2}P0001"
  }
}



#해당 인스턴스는 EIP와 연결되어있음
#명세서와 맞는지 확인 필수(ami, region, type, subnet, ip, 용량)
#EC2_Starlabs_Prod_Bastion_02_KRAWSWP0002
resource "aws_instance" "Bastion_02" {
  ami                                  = var.win2016             # 생성 OS
  instance_type                        = "t2.micro"              # 인스턴스 타입
  availability_zone                    = "${var.region}a"        # 생성 지역
  subnet_id                            = local.subnet_bastion.id # bastion subnet
  instance_initiated_shutdown_behavior = "stop"                  # 종료방식
  disable_api_termination              = "false"                 # 우발적 종료 보호

  #EIP와 연결된 인스턴스는 public_ip를 적지 않음.
  private_ip             = "10.0.2.11"
  vpc_security_group_ids = [aws_security_group.Bastion.id] # 보안 그룹
  key_name               = var.key_name

  #저장소
  root_block_device {
    volume_type           = "gp2"   # default: gp2
    volume_size           = "30"    # 용량
    delete_on_termination = "true"  # 인스턴스 삭제 시, 자동 삭제
    encrypted             = "false" # 암호화

    tags = {
      Name = "Volume_EC2_${var.customer}_${var.set_code}_Bastion_02_${var.country}AWS${var.os_win}P0002_${var.volume_win2016}"
    }
  }

  tags = {
    Name = "EC2_${var.customer}_${var.set_code}_Bastion_02_${var.country}AWS${var.os_win}P0002"
  }
}


#명세서와 맞는지 확인 필수(ami, region, type, subnet, ip, 용량)
#EC2_Starlabs_Prod_WEB_01_KRAWSAP0003
resource "aws_instance" "WEB_01" {
  ami                                  = var.amzn2               # 생성 OS
  instance_type                        = "t2.micro"              # 인스턴스 타입
  availability_zone                    = "${var.region}a"        # 생성 지역
  subnet_id                            = local.subnet_web_az1.id # bastion subnet
  instance_initiated_shutdown_behavior = "stop"                  # 종료방식
  disable_api_termination              = "false"                 # 우발적 종료 보호

  #EIP와 연결된 인스턴스는 public_ip를 적지 않음.
  private_ip             = "10.0.13.10"
  vpc_security_group_ids = [aws_security_group.WEB.id] # 보안 그룹
  key_name               = var.key_name

  #저장소
  root_block_device {
    volume_type           = "gp2"   # default: gp2
    volume_size           = "30"    # 용량
    delete_on_termination = "true"  # 인스턴스 삭제 시, 자동 삭제
    encrypted             = "false" # 암호화

    tags = {
      Name = "Volume_EC2_${var.customer}_${var.set_code}_WEB_01_${var.country}AWS${var.os_amzn2}P0003_${var.volume_amzn2}"
    }
  }

  tags = {
    Name = "EC2_${var.customer}_${var.set_code}_WEB_01_${var.country}AWS${var.os_amzn2}P0003"
  }
}


#명세서와 맞는지 확인 필수(ami, region, type, subnet, ip, 용량)
#EC2_Starlabs_Prod_WEB_02_KRAWSAP0004
resource "aws_instance" "WEB_02" {
  ami                                  = var.amzn2               # 생성 OS
  instance_type                        = "t2.micro"              # 인스턴스 타입
  availability_zone                    = "${var.region}c"        # 생성 지역
  subnet_id                            = local.subnet_web_az2.id # bastion subnet
  instance_initiated_shutdown_behavior = "stop"                  # 종료방식
  disable_api_termination              = "false"                 # 우발적 종료 보호

  #EIP와 연결된 인스턴스는 public_ip를 적지 않음.
  private_ip             = "10.0.13.210"
  vpc_security_group_ids = [aws_security_group.WEB.id] # 보안 그룹
  key_name               = var.key_name

  #저장소
  root_block_device {
    volume_type           = "gp2"   # default: gp2
    volume_size           = "30"    # 용량
    delete_on_termination = "true"  # 인스턴스 삭제 시, 자동 삭제
    encrypted             = "false" # 암호화

    tags = {
      Name = "Volume_EC2_${var.customer}_${var.set_code}_WEB_02_${var.country}AWS${var.os_amzn2}P0004_${var.volume_amzn2}"
    }
  }

  tags = {
    Name = "EC2_${var.customer}_${var.set_code}_WEB_02_${var.country}AWS${var.os_amzn2}P0004"
  }
}


#명세서와 맞는지 확인 필수(ami, region, type, subnet, ip, 용량)
#EC2_Starlabs_Prod_WAS_01_KRAWSAP0005
resource "aws_instance" "WAS_01" {
  ami                                  = var.amzn2               # 생성 OS
  instance_type                        = "t2.micro"              # 인스턴스 타입
  availability_zone                    = "${var.region}a"        # 생성 지역
  subnet_id                            = local.subnet_was_az1.id # bastion subnet
  instance_initiated_shutdown_behavior = "stop"                  # 종료방식
  disable_api_termination              = "false"                 # 우발적 종료 보호

  #EIP와 연결된 인스턴스는 public_ip를 적지 않음.
  private_ip             = "10.0.14.10"
  vpc_security_group_ids = [aws_security_group.WAS.id] # 보안 그룹
  key_name               = var.key_name

  #저장소
  root_block_device {
    volume_type           = "gp2"   # default: gp2
    volume_size           = "30"    # 용량
    delete_on_termination = "true"  # 인스턴스 삭제 시, 자동 삭제
    encrypted             = "false" # 암호화

    tags = {
      Name = "Volume_EC2_${var.customer}_${var.set_code}_WAS_01_${var.country}AWS${var.os_amzn2}P0005_${var.volume_amzn2}"
    }
  }

  tags = {
    Name = "EC2_${var.customer}_${var.set_code}_WAS_01_${var.country}AWS${var.os_amzn2}P0005"
  }
}


#명세서와 맞는지 확인 필수(ami, region, type, subnet, ip, 용량)
#EC2_Starlabs_Prod_WAS_02_KRAWSAP0006
resource "aws_instance" "WAS_02" {
  ami                                  = var.amzn2               # 생성 OS
  instance_type                        = "t2.micro"              # 인스턴스 타입
  availability_zone                    = "${var.region}c"        # 생성 지역
  subnet_id                            = local.subnet_was_az2.id # bastion subnet
  instance_initiated_shutdown_behavior = "stop"                  # 종료방식
  disable_api_termination              = "false"                 # 우발적 종료 보호

  #EIP와 연결된 인스턴스는 public_ip를 적지 않음.
  private_ip             = "10.0.14.210"
  vpc_security_group_ids = [aws_security_group.WAS.id] # 보안 그룹
  key_name               = var.key_name

  #저장소
  root_block_device {
    volume_type           = "gp2"   # default: gp2
    volume_size           = "30"    # 용량
    delete_on_termination = "true"  # 인스턴스 삭제 시, 자동 삭제
    encrypted             = "false" # 암호화

    tags = {
      Name = "Volume_EC2_${var.customer}_${var.set_code}_WAS_02_${var.country}AWS${var.os_amzn2}P0006_${var.volume_amzn2}"
    }
  }

  tags = {
    Name = "EC2_${var.customer}_${var.set_code}_WAS_02_${var.country}AWS${var.os_amzn2}P0006"
  }
}