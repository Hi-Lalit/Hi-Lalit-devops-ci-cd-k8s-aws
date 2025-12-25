resource "aws_instance" "jenkins" {
  ami                    = "ami-0ecb62995f68bb549"
  instance_type          = "t3.micro"
  key_name               = aws_key_pair.devops_key.key_name
  subnet_id              = aws_subnet.public_subnet.id
  vpc_security_group_ids = [aws_security_group.jenkins_sg.id]
  iam_instance_profile   = aws_iam_instance_profile.jenkins_profile.name


  root_block_device {
    volume_size = 8 # 8 GB root volume
    volume_type = "gp2"
  }
  tags = {
    Name = "jenkins-server"
  }
}
