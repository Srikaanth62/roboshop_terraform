variable "env" {}
variable "vpc" {}
variable "app" {}
variable "bastion_cidr" {}
variable "default_vpc_cidr" {}
variable "default_vpc_id" {}
variable "default_vpc_rtid" {}
variable "docdb" {
  docdb = {
    subnet_name    = "db"
    allow_db_cidr  = "app"
    engine_version = "4.0.0"
    instance_count = 1
    instance_class = "db.t3.medium"
  }
}
variable "kms_arn" {}



