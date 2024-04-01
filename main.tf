provider "aws" {
    region = "us-east-2"  
}

resource "aws_instance" "foo" {
  ami           = "ami-019f9b3318b7155c5" # us-east-2
  instance_type = "t2.micro"
  tags = {
      Name = "TF-Instance"
  }
}
