resource "aws_instance" "instance" {
  ami = data.aws_ami.centos.image_id
  instance_type = var.instance_type
  vpc_security_group_ids = [ data.aws_security_group.allow-all.id ]
  tags = {
    Name = local.name
  }
}

resource "null_resource" "provisioner" {
  depends_on = [ aws_instance.instance, aws_route53_record.records ]
  triggers = {
    private_ip = aws_instance.instance.private_ip
  }
  provisioner "remote-exec" {
    connection {
      type     = "ssh"
      user     = "centos"
      password = "DevOps321"
      host     = aws_instance.instance.private_ip
    }

    inline = var.app_type == "db"  ? local.db_commands : local.app_commands
  }
}

resource "aws_route53_record" "records" {
  name    = "${var.components_name}-dev.srikaanth62.online"
  type    = "A"
  ttl     = 30
  records = [aws_instance.instance.private_ip]
  zone_id = "Z088180210HCZBPL2XI2M"
}

resource "aws_iam_role" "role" {
  name = "${var.components_name}-${var.env}-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })

  tags = {
    tag-key = "${var.components_name}-${var.env}-role"
  }
}


