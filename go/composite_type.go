package main

import (
	"crypto/sha256"
	"crypto/sha512"
	"flag"
	"fmt"
)

type Currency int

func zero(ptr *[32]byte) {
	for i := range ptr {
		ptr[i] = 0
	}
}

func zero1(ptr *[32]byte) {
	*ptr = [32]byte{}
}

func diffbyte(a [32]byte, b [32]byte) int {
	var count int
	for i := 0; i < 32; i++ {
		if a[i] != b[i] {
			count += 1
		}
	}
	return count
}

const (
	USD Currency = iota
	EUR
	GBP
	RMB
)

func reverse(s []int) {
	for i, j := 0, len(s)-1; i < j; i, j = i+1, j-1 {
		s[i], s[j] = s[j], s[i]
	}
}

func appendInt(x []int, y int) []int {
	var z []int
	zlen := len(x) + 1
	if zlen <= cap(x) {
		z = x[:zlen]
	} else {
		zcap := zlen
		if zcap < 2*len(x) {
			zcap = 2 * len(x)
		}
		z = make([]int, zlen, zcap)
		copy(z, x)
	}
	z[len(x)] = y
	return z
}

func nonempty(strings []string) []string {
	i := 0
	for _, s := range strings {
		if s != "" {
			strings[i] = s
			i++
		}
	}
	return strings[:1]
}

func nonempty2(strings []string) []string {
	out := strings[:0]
	for _, s := range strings {
		if s != "" {
			out = append(out, s)
		}
	}
	return out
}

func main() {
	var a [3]int
	fmt.Println(a[0])
	fmt.Println(a[len(a)-1])

	for i, v := range a {
		fmt.Printf("%d %d\n", i, v)
	}

	//var q [3]int = [3]int{1, 2, 3}
	//var r [3]int = [3]int{1, 2}

	q := [...]int{1, 2, 3}
	fmt.Printf("%T\n", q)

	symbol := [...]string{USD: "$", EUR: "#", GBP: "*", RMB: "("}
	fmt.Println(USD, EUR, RMB, symbol[RMB])

	r := [...]int{32: 1, 99: -1}
	fmt.Println(r)

	c1 := sha256.Sum256([]byte("x"))
	c2 := sha256.Sum256([]byte("X"))
	fmt.Printf("%x\n%x\n%t\n%T\n", c1, c2, c1 == c2, c1)
	fmt.Printf("diff %d\n", diffbyte(c1, c2))

	hashmethod := flag.String("hashmethod", "sha256", "hash method")
	outstring := flag.String("ostring", "test", "test string")
	flag.Parse()
	fmt.Println(*hashmethod)
	switch *hashmethod {
	case "sha256":
		fmt.Printf("%x\n", sha256.Sum256([]byte(*outstring)))
	case "sha384":
		fmt.Printf("%x\n", sha256.Sum256([]byte(*outstring)))
	case "sha512":
		fmt.Printf("%x\n", sha512.Sum512([]byte(*outstring)))
	}

	//Slice
	months := [...]string{1: "January", 12: "December"}
	fmt.Printf("content:%v, len:%v, cap:%v", months, len(months), cap(months))
	Q2 := months[4:7]
	summer := months[6:9]
	fmt.Println(Q2)
	fmt.Println(summer)

	for _, s := range summer {
		for _, q := range Q2 {
			if s == q {
				fmt.Printf("%s appears in both\n", s)
			}
		}
	}

	//fmt.Println(summer[:20])
	endlessSummer := summer[:5]
	fmt.Println(endlessSummer)
	b := [...]int{0, 1, 2, 3, 4, 5}
	reverse(b[:])
	fmt.Println(b)

	var runes []rune
	for _, r := range "Hello, 世界" {
		runes = append(runes, r)
	}
	fmt.Println(runes)

	var x, y []int
	for i := 0; i < 10; i++ {
		y = appendInt(x, i)
		fmt.Printf("%d cap=%d\t%v\n", i, cap(y), y)
		x = y
	}

}
