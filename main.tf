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


resource "aws_instance" "ec2-jung-terraform-test1" {
  ami = "ami-063c5a5e375b71d95" #CentOS 8.4.2105 x86_64
  instance_type = "t2.micro"
  key_name = "test"
  vpc_security_group_ids = [aws_security_group.terraform_test_sg.id]
  
  tags = {
    Name = "ec2-jung-terraform-test1"
  }
}
