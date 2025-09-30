resource "tls_private_key" "tmp_removeit_pk" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# resource "local_file" "tmp-myterrakey" {
#   content  = tls_private_key.tmp_removeit_pk.private_key_pem
#   filename = "myterrakey.pem"
# }

resource "aws_key_pair" "tmp_removeit_generated_key" {
  key_name   = var.key_name
  public_key = tls_private_key.tmp_removeit_pk.public_key_openssh

  provisioner "local-exec" { # Create "myKey.pem" to your computer!!
    command = "echo '${tls_private_key.tmp_removeit_pk.private_key_pem}' > ../../../keys/officehour/tmp_removeit_generated_key.pem"
  }
}
