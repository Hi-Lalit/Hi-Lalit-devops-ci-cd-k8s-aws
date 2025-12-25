resource "aws_key_pair" "devops_key" {
  key_name   = "devops-key"
  public_key = file("/home/gautam/.ssh/devops-key.pub")
}
