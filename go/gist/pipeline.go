package main

import (
	"fmt"

	"github.com/songgao/go.pipeline"
)

func main() {
	counter := 0

	pipeline.NewPipeline().
		C("ls", "-h", "-l", "/bin").C("egrep", "--color=always", "-e", `\ *[0-9.]*M\ *`).
		L(func(in string) string {
			counter++
			return fmt.Sprintf("%d:\t%s", counter, in)
		}, nil).P()
}
