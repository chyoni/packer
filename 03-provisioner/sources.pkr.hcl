source "amazon-ebs" "ubuntu" {
    instance_type = "t2.micro"
    region = "ap-northeast-2"
    subnet_id = "subnet-0b23fd05b5919269e"
    associate_public_ip_address = true
    ssh_interface = "public_ip"

    source_ami_filter {
        filters = {
            name = "ubuntu/images/*ubuntu-focal-20.04-amd64-server-*"
            root-device-type = "ebs"
            virtualization-type = "hvm"
        }

        most_recent = true
        owners = ["099720109477"]
    }

    ssh_username = "ubuntu"
}