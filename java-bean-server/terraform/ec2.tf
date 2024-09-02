module "ec2-instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "5.6.0"

  iam_instance_profile =  aws_iam_instance_profile.free-the-beans-instance-profile.name

  name                        = aws_key_pair.generated_key.key_name
  associate_public_ip_address = true

  instance_type = "t2.micro"
  key_name      = var.ec2-key-name
  vpc_security_group_ids = [aws_security_group.free_the_beans_ec2_sg.id]
  subnet_id              = module.vpc.public_subnets[0]

  user_data = templatefile("${path.module}/templates/ec2_user_data.sh.tpl", {
    # No variables to pass in
  })


}

resource "aws_security_group" "free_the_beans_ec2_sg" {
  name_prefix = "free-the-beans-ec2-"

  vpc_id = module.vpc.vpc_id
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 31415
    to_port     = 31415
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "tls_private_key" "private_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "generated_key" {
  key_name   = var.ec2-key-name
  public_key = tls_private_key.private_key.public_key_openssh
}

resource "aws_ssm_parameter" "private_key_param" {
  name  = "private_key_free_the_beans_ec2"
  type  = "SecureString"
  value = tls_private_key.private_key.private_key_pem
}

resource "aws_eip" "ec2-eip" {
  instance = module.ec2-instance.id
}
