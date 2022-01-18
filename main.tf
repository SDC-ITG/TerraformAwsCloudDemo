# Require TF version to be same as or greater than 0.12.13
terraform {
  required_version = ">=0.12.13"
  #backend "s3" {
  #  bucket         = "kyler-github-actions-demo-terraform-tfstate"
  #  key            = "terraform.tfstate"
  #  region         = "us-east-1"
  #  dynamodb_table = "aws-locks"
  #  encrypt        = true
  #}
}

# Download any stable version in AWS provider of 2.36.0 or higher in 2.36 train
provider "aws" {
  region  = "ap-northeast-1"
  version = "~> 2.36.0"
}

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

resource "aws_instance" "ec2-jung-terraform-test1" {
  ami = "ami-063c5a5e375b71d95" #CentOS 8.4.2105 x86_64
  instance_type = "t2.micro"
  key_name = "test"
  vpc_security_group_ids = [aws_security_group.terraform_test_sg.id]
  
  tags = {
    Name = "ec2-jung-terraform-test1"
  }
}
