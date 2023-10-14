resource "null_resource" "example" {
  # This is a unique name for the resource block.
  
  triggers = {
    # Triggers are a map of values that, when changed, will cause the null_resource to be recreated.
    timestamp = "${timestamp()}"
  }

  # This is a provisioner block that specifies the action to be taken.
  provisioner "local-exec" {
    # The provisioner type "local-exec" allows you to run local shell commands.
    command = "echo 'Hello, Terraform!'"
  }

  # This is a depends_on block that specifies dependencies on other resources.
  # If you need to ensure that the null_resource runs after other resources, list them here.
  depends_on = [aws_instance.example]
}

resource "aws_instance" "example" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"
}
