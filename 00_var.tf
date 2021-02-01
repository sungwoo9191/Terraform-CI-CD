#사전에 AWS 콘솔에서 key_pair 생성해서 이름을 넣어야 됨
variable "key_name" {
  default     = "KeyPair_Starlabs_Prod"
  description = "키페어 이름"
}


variable "customer" {
  default     = "Starlabs"
  description = "고객사명"
}

variable "set_code" {
  default     = "Prod"
  description = "set code"
}

variable "private_port" {
  default     = "9009"
  description = "WEB-WAS 연결 포트 등, NLB 포트"
}

variable "region" {
  default     = "ap-southeast-2"
  description = "서버 생성 지역 입력"
}
variable "country" {
  default     = "KR"
  description = "나라 이름 두 글자 입력"
}
variable "nlb_name" {
  default     = "NSPWI"
  description = "NLB-Starlabs-Prod-WAS-Int"
}

# 10_db_subnet_group, 11_db_instance 에서 사용
# 필수 확인
variable "db_engine" {
  default     = "mysql"
  description = "DB 엔진 이름"
}
variable "db_version" {
  default     = "5.7"
  description = "DB 엔진 버전"
}
variable "db_name" {
  default     = "STLDB"
  description = "DB 스토리지 이름"
}
variable "db_identifier" {
  default     = "rds-starlabs-prod-db"
  description = "DB 인스턴스 식별자 (소문자만 가능)"
}
variable "db_port" {
  default     = "3306"
  description = "DB 포트"
}

# 백업 이름 12_backup_plans에서 사용
# 명명 규칙과 명세서 확인 필수
variable "backup_target" {
  default     = "EC2"
  description = "백업 대상"
}
variable "backup_freq" {
  default     = "Daily"
  description = "백업 빈도"
}
variable "backup_time" {
  default     = "0000"
  description = "백업 시간"
}
variable "backup_cycle" {
  default     = "Day"
  description = "백업 주기"
}

#리전마다 ami 값이 다르니 확인 필수.
variable "amzn2" {
  default     = "ami-04f77aa5970939148"
  description = "Amazon Linux 2 AMI (HVM), SSD Volume Type"
}
variable "win2016" {
  default     = "ami-05f1bac3bdba6d300"
  description = "Microsoft Windows Server 2016 Base"
}
variable "ubuntu18" {
  default     = "ami-00ddb0e5626798373"
  description = "Ubuntu Server 18.04 LTS (HVM), SSD Volume Type"
}

# 스토리지 이름은 변경될 수 있음.
variable "volume_amzn2" {
  default     = "/dev/xvda"
  description = "아마존 리눅스2 인스턴스 스토리지 디바이스 이름"
}
variable "volume_win2016" {
  default     = "/dev/sda1"
  description = "윈도우 서버 2016 인스턴스 스토리지 디바이스 이름"
}

variable "os_amzn2" {
  default     = "A"
  description = "os 아마존 리눅스 1글자"
}
variable "os_win" {
  default     = "W"
  description = "os 윈도우 1글자"
}