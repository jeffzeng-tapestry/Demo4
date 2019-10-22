resource "aws_security_group" "ActiveDirectory" {
  name        = "${var.project}-${var.environment}-instance-sg"
  description = "${var.project}-${var.environment}-instance-sg"
  vpc_id      = data.terraform_remote_state.vpc.outputs.vpc_id

  ingress {
    description = "Allow inbound from internal networks"
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["172.16.0.0/12", "10.0.0.0/8", "156.146.0.0/16"]
  }

  tags = merge(
    { Name = "${var.project}-${var.environment}-instance-sg" },
    module.tags.tags
  )
}