module "vpc" {
  source = "git::https://github.com/Srikaanth62/tf-module-vpc.git"
  for_each = var.vpc
  cidr_block = each.value["cidr_block"]
  subnets = each.value["subnets"]
  tags = local.tags
  env = var.env
}

module "app" {
  source = "git::https://github.com/Srikaanth62/tf-module-app.git"
  for_each = var.app
  instance_type = each.value["instance_type"]
  name = each.value["name"]
  env = var.env
  desired_capacity = each.value["desired_capacity"]
  min_size = each.value["min_size"]
  max_size = each.value["max_size"]
  bastion_cidr = var.bastion_cidr
  subnet_ids = lookup(lookup(lookup(lookup(module.vpc, "main", null), "subnets", null), each.value["subnet_name"], null), "subnet_ids", null)
  vpc_id = lookup(lookup(module.vpc, "main", null), "vpc_id", null)
  allow_app_cidr = lookup(lookup(lookup(lookup(module.vpc, "main", null), "subnets", null), each.value["allow_app_cidr"], null), "subnet_cidrs", null)

}



