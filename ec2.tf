resource "aws_security_group" "web_sg" {
  name        = "web-sg"
  description = "Security group for web server"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    security_groups = [aws_security_group.lb_sg.id]  # Permitir tráfego apenas do SG do Load Balancer
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]  # Permitir todas as saídas
  }

  tags = {
    Name = "web-sg"
  }
}

resource "aws_instance" "web" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = aws_subnet.private[0].id  # Referência à subnet correta
  vpc_security_group_ids = [aws_security_group.web_sg.id]

  user_data = <<-EOF
              #!/bin/bash
              # Atualizar o sistema
              yum update -y
              
              # Instalar o Docker
              yum install -y docker git
              service docker start
              systemctl enable --now docker
              sleep 15

              # Baixar a imagem do Nginx e rodar o contêiner
              git clone https://github.com/iureradin/teste_terraform.git
              cd teste_terraform
              docker run -d -p 80:80 -v ./index.html:/usr/share/nginx/html/index.html --name nginx-container nginx
            EOF

  tags = {
    Name = "web-instance"
  }
}
