# 모니터링이 대상이 되는 인스턴스 보안그룹에 포트 9100 열어주어야 됨. (WEB WAS 등)
# Bastion 인스턴스 보안그룹에 모니터링 EIP로 포트포워딩을 허용할 포트를 열어줘야됨. (Monitering_EC2 - Bastion_EC2 - 모니터링 대상 순서)
# 모니터링 인스턴스를 백업에 추가해야 함.

# 모니터링 EIP
# 명세서에 맞게 수정 필요
resource "aws_eip" "Monitoring_01" {
  instance             = aws_instance.Monitoring_01.id
  vpc                  = true
  network_border_group = var.region
  public_ipv4_pool     = "amazon"

  tags = {
    Name = "EIP_EC2_${var.customer}_${var.set_code}_Monitoring_01_${var.country}AWS${var.os_amzn2}P0007"
  }
}
resource "aws_security_group" "Monitoring" {
  name        = "SG_${var.customer}_${var.set_code}_Monitoring"
  description = "SG_${var.customer}_${var.set_code}_Monitoring"
  vpc_id      = aws_vpc.VPC_01.id

  ingress {
    description = "${var.customer} to EC2 SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["183.98.156.109/32"]
  }
  ingress {
    description = "${var.customer} to Prometheus"
    from_port   = 9090
    to_port     = 9090
    protocol    = "tcp"
    cidr_blocks = ["183.98.156.109/32"]
  }
  ingress {
    description = "${var.customer} to Grafana"
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["183.98.156.109/32"]
  }

  egress {
    description = "External Connection"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "SG_${var.customer}_${var.set_code}_Monitoring"
  }
}

resource "aws_instance" "Monitoring_01" {
  ami                                  = var.amzn2                           # 생성 OS
  instance_type                        = "t2.micro"                          # 인스턴스 타입
  availability_zone                    = "${var.region}a"                    # 생성 지역
  subnet_id                            = aws_subnet.Public_Bastion_AZ1_01.id # bastion subnet
  instance_initiated_shutdown_behavior = "stop"                              # 종료방식
  disable_api_termination              = "true"                              # 우발적 종료 보호

  #EIP와 연결된 인스턴스는 public_ip를 적지 않음.
  private_ip             = "10.0.2.12"
  vpc_security_group_ids = [aws_security_group.Monitoring.id] # 보안 그룹
  key_name               = var.key_name

  #저장소
  root_block_device {
    volume_type           = "gp2"   # default: gp2
    volume_size           = "30"    # 용량
    delete_on_termination = "true"  # 인스턴스 삭제 시, 자동 삭제
    encrypted             = "false" # 암호화

    tags = {
      Name = "Volume_EC2_${var.customer}_${var.set_code}_Monitoring_01_${var.country}AWS${var.os_amzn2}P0007_${var.volume_amzn2}"
    }
  }

  tags = {
    Name = "EC2_${var.customer}_${var.set_code}_Monitoring_01_${var.country}AWS${var.os_amzn2}P0007"
  }
}