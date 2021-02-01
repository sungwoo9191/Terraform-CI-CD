/*
DB 생성에서 모니터링 사용시, AWS 정책으로 인하여 CLI로 변경 불가능한 부분 수정해야됨
(백업과 다르게 필수가 아님, 이미 액세스 허용은 되어있기 때문.)
IAM - 역할 - rds-monitoring-role 에서 Permissions policies 정책 연결 클릭
 -> AmazonRDSEnhancedMonitoringRole 정책 연결

역할을 콘솔로 부여하면, 테라폼으로 삭제 전에 콘솔 IAM으로 들어가서 만들어진 역할(rds-monitoring-role)을 직접 삭제해야됨.
*/

# 인스턴스 이름 rds-*-*-db 형식
# 변경 확인, 스토리지 타입 gp2 사용시 iops 주석 처리 및 파라미터 그룹 주석 확인
resource "aws_db_instance" "DB" {
  engine         = var.db_engine     # DB 엔진 이름
  engine_version = var.db_version    # DB 엔진 버전
  identifier     = var.db_identifier # DB 인스턴스 식별자 이름

  username              = "admin"       # 마스터 사용자 이름
  password              = "starlabs!"   # 마스터 암호
  instance_class        = "db.t3.micro" # 인스턴스 타입
  storage_type          = "io1"         # 스토리지 타입, io1(IOPS) or gp2
  allocated_storage     = "100"         # 스토리지 크기
  iops                  = "3000"        # 프로비저닝 IOPS, 스토리지 타입 gp2 사용시 주석처리
  max_allocated_storage = "1000"        # 오토스케일링 최대 스토리지 크기
  multi_az              = "true"        # 멀티 AZ 사용 여부, true면 availability_zone 사용안됨.

  publicly_accessible    = "false"                         # 퍼블릭 엑세스 기능
  db_subnet_group_name   = aws_db_subnet_group.RDS_01.name # db 서브넷
  vpc_security_group_ids = [aws_security_group.DB.id]      # db 보안 그룹

  name = var.db_name # DB 스토리지 이름
  port = var.db_port # DB 포트

  # multi_az 사용시, availability_zone 적용 안됨.
  # availability_zone = "${var.region}a" # 가용지역 (명세서 확인)

  #iam_database_authentication_enabled = "true" # iam 보안 로그인 허용
  #character_set_name                  = "UTF8" # 오라클DB or 마크로소프트DB 전용

  backup_retention_period = "7"           # 백업 보존 기간
  backup_window           = "17:00-17:30" # 백업 시간
  copy_tags_to_snapshot   = "true"        # 스냅샷으로 태그 복사
  storage_encrypted       = "true"        # 암호화 활성화

  # performance_insights_enabled          = "true" # 성능 개선 도우미 활성화, mysql 지원안함
  # performance_insights_retention_period = "7"    # 보존기간, mysql 지원안함

  monitoring_role_arn = aws_iam_role.rds-monitoring-role.arn # 모니터링 역할 default 이름
  monitoring_interval = "60"                                 # 모니터링 세부 수준

  allow_major_version_upgrade = "false"               # 마이너 업그레이드
  maintenance_window          = "Fri:19:00-Fri:19:30" # 유지 관리 기간
  deletion_protection         = "true"                # 삭제 방지 기능

  parameter_group_name = aws_db_parameter_group.utf8.name # mysql 아니면 주석 처리 or 변경
}


# DB 모니터링을 위한 IAM 생성
# 기존 콘솔에서 생성 시 생성되는 Default 설정임.
resource "aws_iam_role" "rds-monitoring-role" {
  name               = "rds-monitoring-role"
  assume_role_policy = data.aws_iam_policy_document.rds-monitoring-role.json

  max_session_duration = "3600" # 최대 세션 시간 (초)
  path                 = "/"

  tags = {
    Name = "rds-monitoring-role"
  }
}

# Attach Amazon's managed policy for RDS enhanced monitoring
resource "aws_iam_role_policy_attachment" "rds-monitoring-role" {
  role       = aws_iam_role.rds-monitoring-role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonRDSEnhancedMonitoringRole"
}

# allow rds to assume this role
data "aws_iam_policy_document" "rds-monitoring-role" {
  statement {
    actions = [
      "sts:AssumeRole",
    ]

    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["monitoring.rds.amazonaws.com"]
    }
  }
}