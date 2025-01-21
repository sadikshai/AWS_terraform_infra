resource "aws_key_pair" "mykey" {
  key_name   = var.key_pair_info.name
  public_key = file(var.key_pair_info.public_key_path)
}

resource "aws_instance" "web" {
  ami                         = data.aws_ami.webimage.id
  instance_type               = var.web_server_info.instance_type
  key_name                    = aws_key_pair.mykey.key_name
  associate_public_ip_address = var.web_server_info.associate_public_ip_address
  subnet_id                   = aws_subnet.web[0].id
  vpc_security_group_ids      = [aws_security_group.web.id]
  tags                        = var.web_server_info.tags

}

resource "null_resource" "webnull" {
  triggers = {
    build_id = var.build_id
  }
  connection {
    type        = "ssh"
    user        = var.web_server_info.username
    private_key = file(var.key_pair_info.private_key_path)
    host        = aws_instance.web.public_ip
  }
  provisioner "remote-exec" {
    script = "./install.sh"

  }

}




