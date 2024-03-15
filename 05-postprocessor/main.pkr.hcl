build {
    name = "cwchoiit-packer"

    source "amazon-ebs.ubuntu" {
        name = "nginx"
        ami_name = "cwchoiit-packer"
    }

    post-processor "manifest" {} # 첫번째 post-processor는 빌드 산출물을 다이렉트로 입력으로 받게 된다.

    post-processors {
        # post-processors의 첫번째 post-processor 역시 빌드 산출물을 다이렉트로 입력으로 받는다.
        post-processor "shell-local" {
            inline = ["echo Hello World ! > artifact.txt"]
        }
        # post-processors의 첫번째가 아닌 post-processor들은 첫번째 단계의 산출물을 입력으로 가져올 수 있게 된다.
        # 여기 같은 경우는 첫번째 post-processor가 shell-local이라 딱히 산출물이 없는데 파일(artifact.txt)을 만들어내는 스크립트가 있다.
        # 그리고 그 파일을 post-processor의 산출물로 만들고 싶으면 이 "artifice" 라는 후처리기를 사용하면 된다.
        # 그러면 이 files에 지정한 파일들을 다음 post-processor에게 전달하게 된다.
        post-processor "artifice" {
            files = ["artifact.txt"]
        }
        post-processor "compress" {}
    }

    post-processors {
        # post-processors의 첫번째 post-processor 역시 빌드 산출물을 다이렉트로 입력으로 받는다.
        post-processor "shell-local" {
            inline = ["echo Finished!"]
        }
    }
}