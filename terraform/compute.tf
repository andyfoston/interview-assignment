data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  # 099720109477 is the id of the Canonical account
  # that releases the official AMIs.
  owners = ["099720109477"]
}

resource "aws_instance" "web" {
  count                  = 2 # To keep costs down
  instance_type          = "t2.micro"
  ami                    = data.aws_ami.ubuntu.id
  key_name               = aws_key_pair.andy.id
  subnet_id              = aws_subnet.main[count.index].id
  vpc_security_group_ids = [aws_security_group.ec2.id]
}

output "aws_instance_ips" {
  value = aws_instance.web[*].public_ip
}
