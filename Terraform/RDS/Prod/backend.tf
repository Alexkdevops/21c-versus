terraform {
  backend "s3" {
    bucket = "21b-centos"
    key    = "rds-db-versus.tfstate"
    region = "us-east-1"
  }
}
