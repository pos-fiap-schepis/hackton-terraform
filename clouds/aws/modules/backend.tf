terraform {
  backend "s3" {
    bucket         = "pos-fiap-schepis"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    encrypt        = false
  }
}