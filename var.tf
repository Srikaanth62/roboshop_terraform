variable "env" {
  default = [ "dev", "prod" ]
}

variable "db_servers" {
  default = {
    redis = {
      name = "redis"
      instance_type = "t3.micro"
    }
    mongodb = {
      name = "mongodb"
      instance_type = "t3.micro"
    }
    mysql = {
      name = "mysql"
      instance_type = "t3.micro"
    }

    rabbitmq = {
      name = "rabbitmq"
      instance_type = "t3.micro"
    }
  }
}
variable "app_servers" {
  default = {
    frontend = {
      name = "frontend"
      instance_type = "t3.micro"
    }
    catalogue = {
      name = "catalogue"
      instance_type = "t3.micro"
    }
    user = {
      name = "user"
      instance_type = "t3.micro"
    }
    cart = {
      name = "cart"
      instance_type = "t3.micro"
    }
    shipping = {
      name = "shipping"
      instance_type = "t3.micro"
    }
    payment = {
      name = "payment"
      instance_type = "t3.micro"
    }
    dispatch = {
      name = "dispatch"
      instance_type = "t3.micro"
    }
  }
}