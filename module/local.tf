locals {
  name = var.env != "" ? "${var.components_name}-${var.env}" : var.components_name
  db_commands = [
    "rm -rf Roboshop-Project-Shell",
    "git clone https://github.com/Srikaanth62/Roboshop-Project-Shell",
    "cd Roboshop-Project-Shelll",
    "sudo bash ${var.components_name}.sh ${var.password}"
  ]
 /* app_commands = [
    "sudo labauto ansible",
    "ansible-pull -i localhost, -U https://github.com/Srikaanth62/Roboshop-Project-Shell roboshop.yml -e env=${var.env} -e role_name=${var.components_name}"
  ]*/
}