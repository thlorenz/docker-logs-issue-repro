from ubuntu:12.10

entrypoint [ "cat" ]
cmd [ "docker-license.txt" ]

add . /src
workdir /src
