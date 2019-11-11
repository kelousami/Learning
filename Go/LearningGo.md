
# Basics

## Install
```
$ wget https://dl.google.com/go/go1.13.4.linux-amd64.tar.gz
$ tar -C /usr/local -xzf go1.13.4.linux-amd64.tar.gz
$ export PATH=$PATH:/usr/local/go/bin
$ go version
```

## Hello, world!

We need a workspace which is known by go as $GOPATH.

```
$ mkdir /home/me/go_workspace
$ export GOPATH=/home/me/go_workspace
$ mkdir -p /home/me/go_workspace/src/hello
$ cd /home/me/go_workspace/src/hello
$ cat > hello.go
package main

import "fmt"

func main() {
	fmt.Printf("hello, world\n")
}
(CRLT+D)

$ go build

$ ./hello
hello, world

$ go install

```
