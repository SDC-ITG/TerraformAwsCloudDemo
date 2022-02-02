##----------------------------------------------------------
##Resource
##----------------------------------------------------------

# Require TF version to be same as or greater than 0.12.13
terraform {
  required_version = ">=1.1.0"
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

resource "aws_instance" "ec2-jung-terraform-test2" {
  ami = "ami-0902e32cadc848c1a" #Microsoft Windows Server 2019 Base
  instance_type = "t2.micro"
  key_name = "test"
  vpc_security_group_ids = [aws_security_group.terraform_test_sg.id]

  tags = {
    Name = "ec2-jung-terraform-test2"
  }
}
