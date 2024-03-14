build {
    name = "cwchoiit-packer"

    source "amazon-ebs.ubuntu" {
        name = "nginx"
        ami_name = "cwchoiit-packer-nginx"
    }

    # Provisioner는 정의한 순서대로 실행하기 때문에 순서가 중요하다.
    provisioner "shell" {
        inline = [
            "sudo apt-get update",
            "whoami",
        ]
    }

    provisioner "file" {
        source = "${path.root}/files/index.html"
        destination = "/tmp/index.html"
    }

    provisioner "shell" {
        inline = [
            "echo ${source.name} and ${source.type}",
            "whoami",
            "sudo apt-get install -y nginx",
            "sudo cp /tmp/index.html /var/www/html/index.html"
        ]
    }

    provisioner "breakpoint" {
        disable = false
        note = "For debugging"
    } 
}