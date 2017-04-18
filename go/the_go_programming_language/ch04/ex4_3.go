package main

import (
	"fmt"
	"unicode"
)

func main() {
	a := [...]int{0, 1, 2, 3, 4, 5}
	array_reverse(&a)
	fmt.Println(a)

	b := [...]int{0, 1, 2, 3, 4, 5}
	slice_reverse(b[:])
	fmt.Println(b)

	// 4.4
	s := []int{0, 1, 2, 3, 4, 5}
	// Rotate s left by two positions.
	rotate(s, 2)
	fmt.Println(s) // "[2 3 4 5 0 1]"

	// 4.6
	c := []byte("abc\r  \n\rdef")
	fmt.Printf("%q\n", string(removeDupSpace(c)))
	fmt.Printf("%q\n", c)
}

func array_reverse(s *[6]int) {
	for i, j := 0, len(s)-1; i < j; i, j = i+1, j-1 {
		s[i], s[j] = s[j], s[i]
	}
}

func slice_reverse(s []int) {
	for i, j := 0, len(s)-1; i < j; i, j = i+1, j-1 {
		s[i], s[j] = s[j], s[i]
	}
}

func removeDupSpace(b []byte) []byte {
	out := b[:0]
	for i, c := range b {
		if unicode.IsSpace(rune(c)) {
			if i > 0 && unicode.IsSpace(rune(b[i-1])) {
				continue
			} else {
				out = append(out, ' ')
			}
		} else {
			out = append(out, c)
		}
	}
	return out
}

func rotate(s []int, n int) {
	length := len(s)
	tmp := make([]int, n)
	copy(tmp, s[:n])
	copy(s, s[n:])
	copy(s[length-n:], tmp)
}
