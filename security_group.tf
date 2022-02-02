##----------------------------------------------------------
##Security Groups
##----------------------------------------------------------

resource "aws_security_group" "terraform_test_sg" {
  name        = "terraform_test"
  description = "Allow http and https traffic."
  vpc_id      = "vpc-f33c0a97" # デフォルトvpcのID
  # ここにingressを書かず、ルールはaws_security_group_ruleを使って定義する
}

# 80番ポート許可のインバウンドルール
resource "aws_security_group_rule" "inbound_http" {
  type        = "ingress"
  from_port   = 80
  to_port     = 80
  protocol    = "tcp"
  cidr_blocks = [
    "0.0.0.0/0"
  ]

  # ここでterraform_testセキュリティグループに紐付け
  security_group_id = "${aws_security_group.terraform_test_sg.id}"
}

# 443番ポート許可のインバウンドルール
resource "aws_security_group_rule" "inbound_https" {
  type        = "ingress"
  from_port   = 443
  to_port     = 443
  protocol    = "tcp"
  cidr_blocks = [
    "0.0.0.0/0"
  ]

  # ここでterraform_testセキュリティグループに紐付け
  security_group_id = "${aws_security_group.terraform_test_sg.id}"
}
# 22番ポート許可のインバウンドルール
resource "aws_security_group_rule" "inbound_ssh" {
  type        = "ingress"
  from_port   = 22
  to_port     = 22
  protocol    = "tcp"
  cidr_blocks = [
    "0.0.0.0/0"
  ]

  # ここでterraform_testセキュリティグループに紐付け
  security_group_id = "${aws_security_group.terraform_test_sg.id}"
}
# 3389番ポート許可のインバウンドルール
resource "aws_security_group_rule" "inbound_rdp" {
  type        = "ingress"
  from_port   = 3389
  to_port     = 3389
  protocol    = "tcp"
  cidr_blocks = [
    "0.0.0.0/0"
  ]

  # ここでterraform_testセキュリティグループに紐付け
  security_group_id = "${aws_security_group.terraform_test_sg.id}"
}
