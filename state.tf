terraform {
  backend "s3" {
    bucket = "srikaanth62"
    key    = "roboshop/dev/terraform.tfstate"
    region = "us-east-1"
  }
}
