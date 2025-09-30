locals {
  workspace_name = terraform.workspace
  instance_name  = "${terraform.workspace}-tmp-bastion-instance-removeit"
}

resource "aws_instance" "instancetmp_remove1" {
  ami                    = var.ami
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.subnet-removeit-private[0].id
  key_name               = aws_key_pair.tmp_removeit_generated_key.key_name
  vpc_security_group_ids = [aws_security_group.tmp-sg-removeit.id]

  tags = {
    Name = "${local.instance_name}"
  }
  depends_on = [aws_key_pair.tmp_removeit_generated_key]

  connection {
    type        = "ssh"
    user        = var.instance_username
    private_key = tls_private_key.tmp_removeit_pk.private_key_pem
    host        = aws_instance.instancetmp_remove1.public_ip
  }
}
