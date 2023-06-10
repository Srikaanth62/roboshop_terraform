module "vpc" {
  source = "git::https://github.com/Srikaanth62/tf-module-vpc.git"
  for_each = var.vpc
  cidr_block = each.value["cidr_block"]
  subnets = each.value["subnets"]
  tags = local.tags
  env = var.env
  default_vpc_cidr = var.default_vpc_cidr
  default_vpc_id = var.default_vpc_id
  default_vpc_rtid = var.default_vpc_rtid
}

module "app" {
  source = "git::https://github.com/Srikaanth62/tf-module-app.git"
  for_each = var.app
  instance_type = each.value["instance_type"]
  name = each.value["name"]
  env = var.env
  tags = local.tags
  desired_capacity = each.value["desired_capacity"]
  min_size = each.value["min_size"]
  max_size = each.value["max_size"]
  bastion_cidr = var.bastion_cidr
  subnet_ids = lookup(lookup(lookup(lookup(module.vpc, "main", null), "subnets", null), each.value["subnet_name"], null), "subnet_ids", null)
  vpc_id = local.vpc_id
  allow_app_cidr = lookup(lookup(lookup(lookup(module.vpc, "main", null), "subnets", null), each.value["allow_app_cidr"], null), "subnet_cidrs", null)

}

module "docdb" {
  source = "git::https://github.com/Srikaanth62/tf-module-docdb.git"
  for_each = var.docdb
  subnets = lookup(lookup(lookup(lookup(module.vpc, "main", null), "subnets", null), each.value["subnet_name"], null), "subnet_ids", null)
  tags = local.tags
  env = var.env
  vpc_id = local.vpc_id
  allow_db_cidr = lookup(lookup(lookup(lookup(module.vpc, "main", null), "subnets", null), each.value["allow_db_cidr"], null), "subnet_cidrs", null)
  engine_version = each.value["engine_version"]
  instance_count = each.value["instance_count"]
  instance_class = each.value["instance_class"]
  kms_arn = var.kms_arn
}







