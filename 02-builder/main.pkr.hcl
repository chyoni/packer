# Without name
build {
    sources = [
        "source.null.one",
        "source.null.two",
    ]
}

# With name
build {
    name = "cwchoiit-packer"

    sources = [
        "source.null.one",
        "source.null.two",
    ]
}

# Fill-in (기존 source를 확장하는 기능, 근데 원래 있던 것을 변경하는 것은 불가능하다. 예를 들어, 기존에 null.one이 가지고 있던 communicator를 여기서 변경하는 행위)
build {
    name = "cwchoiit-packer-fill-in"
    
    source "null.one" {
        name = "terraform"
    }

    source "null.two" {
        name = "vault"
    }
}

