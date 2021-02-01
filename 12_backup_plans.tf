# 매뉴얼과 다른 부분, 수정 필수
# 아래 백업할 리소스 (EC2 등) 확인 필수
resource "aws_backup_selection" "Backup" {
  iam_role_arn = aws_iam_role.AWSBackupDefaultServiceRole.arn
  name         = "Backup_${var.backup_target}_${var.set_code}"
  plan_id      = aws_backup_plan.backup.id

  resources = [
    aws_instance.Bastion_01.arn,
    aws_instance.Bastion_02.arn,
    aws_instance.WEB_01.arn,
    aws_instance.WEB_02.arn,
    aws_instance.WAS_01.arn,
    aws_instance.WAS_02.arn
  ]
}

resource "aws_backup_vault" "vault" {
  name = "Backup_${var.backup_target}_${var.set_code}"
}
resource "aws_backup_plan" "backup" {
  name = "Backup_${var.backup_target}_${var.set_code}"

  rule {
    rule_name         = "Backup_${var.backup_freq}_${var.backup_time}_${var.backup_cycle}" # 규칙 이름
    target_vault_name = aws_backup_vault.vault.name                                        # 백업 볼트 이름

    # https://docs.aws.amazon.com/ko_kr/AmazonCloudWatch/latest/events/ScheduledEvents.html?icmpid=docs_console_unmapped
    schedule = "cron(0 15 * * ? *)" # 매일 UTC 오후 3시 시작

    start_window      = 60  # 다음 시간 내에 시작 (분)
    completion_window = 120 # 다음 시간 내에 완료 (분)

    lifecycle {
      # cold_storage_after = "0" # 콜드 스트리지로 전환
      delete_after = "7" # 생성후 경과 기간 (일) [보관주기]
    }
  }
  /* VSS 백업 사용시 활성화
  advanced_backup_setting {
    backup_options = {
      WindowsVSS = "enabled"
    }
    resource_type = "EC2"
  }
  */

  tags = {
    Name = "Backup_${var.backup_target}_${var.set_code}"
  }
}


# 백업을 위한 IAM role 생성
# 매뉴얼 백업 기본값
resource "aws_iam_role" "AWSBackupDefaultServiceRole" {
  name = "AWSBackupDefaultServiceRole"

  assume_role_policy   = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": ["sts:AssumeRole"],
      "Effect": "allow",
      "Principal": {
        "Service": ["backup.amazonaws.com"]
      }
    }
  ]
}
POLICY
  max_session_duration = "3600" # 최대 세션 시간 (초)
  path                 = "/service-role/"
  description          = "Provides AWS Backup permission to create backups and perform restores on your behalf across AWS services."
  tags = {
    Name = "AWSBackupDefaultServiceRole"
  }
}
resource "aws_iam_role_policy_attachment" "AWSBackupDefaultServiceRole_Backup" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSBackupServiceRolePolicyForBackup"
  role       = aws_iam_role.AWSBackupDefaultServiceRole.name
}
resource "aws_iam_role_policy_attachment" "AWSBackupDefaultServiceRole_Restores" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSBackupServiceRolePolicyForRestores"
  role       = aws_iam_role.AWSBackupDefaultServiceRole.name
}