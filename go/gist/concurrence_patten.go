package main

import "fmt"

func fanIn(input1, input2 <-chan string) <-chan string {
	c := make(chan string)
	go func() {
		for {
			c <- <-input1
		}
	}()
	go func() {
		for {
			c <- <-input2
		}
	}()
	return c
}
func main() {
	c := fanIn(boring("Joe"), boring("Ann"))
	for i := 0; i < 10; i++ {
		fmt.Println(<-c)
	}
	fmt.Println("You're both boring; I'm leaving.")
}

The select statement provides another way to handle multiple channels. 
It's like a switch, but each case is a communication: 
- All channels are evaluated. 
- Selection blocks until one communication can proceed, which then does. 
- If multiple can proceed, select chooses pseudo-randomly. 
- A default clause, if present, executes immediately if no channel is ready.
    select {
    case v1 := <-c1:
        fmt.Printf("received %v from c1\n", v1)
    case v2 := <-c2:
        fmt.Printf("received %v from c2\n", v1)
    case c3 <- 23:
        fmt.Printf("sent %v to c3\n", 23)
    default:
        fmt.Printf("no one was ready to communicate\n")
    }

Fan-in using select
Rewrite our original fanIn function. Only one goroutine is needed. New:
func fanIn(input1, input2 <-chan string) <-chan string {
    c := make(chan string)
    go func() {
        for {
            select {
            case s := <-input1:  c <- s
            case s := <-input2:  c <- s
            }
        }
    }()
    return c
}

Timeout using select
The time.After function returns a channel that blocks for the specified duration. 
After the interval, the channel delivers the current time, once.
func main() {
    c := boring("Joe")
    for {
        select {
        case s := <-c:
            fmt.Println(s)
        case <-time.After(1 * time.Second):
            fmt.Println("You're too slow.")
            return
        }
    }
}

Timeout for whole conversation using select
Create the timer once, outside the loop, to time out the entire conversation. 
(In the previous program, we had a timeout for each message.)
func main() {
    c := boring("Joe")
    timeout := time.After(5 * time.Second)
    for {
        select {
        case s := <-c:
            fmt.Println(s)
        case <-timeout:
            fmt.Println("You talk too much.")
            return
        }
    }
}

Quit channel
We can turn this around and tell Joe to stop when we're tired of listening to him.
    quit := make(chan bool)
    c := boring("Joe", quit)
    for i := rand.Intn(10); i >= 0; i-- { fmt.Println(<-c) }
    quit <- true
            select {
            case c <- fmt.Sprintf("%s: %d", msg, i):
                // do nothing
            case <-quit:
                return
            }


package main

import "fmt"

func f(left, right chan int) {
	left <- 1 + <-right
}

func main() {
	const n = 10000
	leftmost := make(chan int)
	right := leftmost
	left := leftmost
	for i := 0; i < n; i++ {
		right = make(chan int)
		go f(left, right)
		left = right
	}
	go func(c chan int) { c <- 1 }(right)
	fmt.Println(<-leftmost)
}

var (
    Web = fakeSearch("web")
    Image = fakeSearch("image")
    Video = fakeSearch("video")
)

type Search func(query string) Result

func fakeSearch(kind string) Search {
        return func(query string) Result {
              time.Sleep(time.Duration(rand.Intn(100)) * time.Millisecond)
              return Result(fmt.Sprintf("%s result for %q\n", kind, query))
        }
}
func main() {
    rand.Seed(time.Now().UnixNano())
    start := time.Now()
    results := Google("golang")
    elapsed := time.Since(start)
    fmt.Println(results)
    fmt.Println(elapsed)
}
func Google(query string) (results []Result) {
    results = append(results, Web(query))
    results = append(results, Image(query))
    results = append(results, Video(query))
    return
}

func Google(query string) (results []Result) {
    c := make(chan Result)
    go func() { c <- Web(query) } ()
    go func() { c <- Image(query) } ()
    go func() { c <- Video(query) } ()

    for i := 0; i < 3; i++ {
        result := <-c
        results = append(results, result)
    }
    return
}
    c := make(chan Result)
    go func() { c <- Web(query) } ()
    go func() { c <- Image(query) } ()
    go func() { c <- Video(query) } ()

    timeout := time.After(80 * time.Millisecond)
    for i := 0; i < 3; i++ {
        select {
        case result := <-c:
            results = append(results, result)
        case <-timeout:
            fmt.Println("timed out")
            return
        }
    }
    return
func First(query string, replicas ...Search) Result {
    c := make(chan Result)
    searchReplica := func(i int) { c <- replicas[i](query) }
    for i := range replicas {
        go searchReplica(i)
    }
    return <-c
}
func main() {
    rand.Seed(time.Now().UnixNano())
    start := time.Now()
    result := First("golang",
        fakeSearch("replica 1"),
        fakeSearch("replica 2"))
    elapsed := time.Since(start)
    fmt.Println(result)
    fmt.Println(elapsed)
}
    c := make(chan Result)
    go func() { c <- First(query, Web1, Web2) } ()
    go func() { c <- First(query, Image1, Image2) } ()
    go func() { c <- First(query, Video1, Video2) } ()
    timeout := time.After(80 * time.Millisecond)
    for i := 0; i < 3; i++ {
        select {
        case result := <-c:
            results = append(results, result)
        case <-timeout:
            fmt.Println("timed out")
            return
        }
    }
    return

Don't overdo it
They're fun to play with, but don't overuse these ideas.
Goroutines and channels are big ideas. They're tools for program construction.
But sometimes all you need is a reference counter.
Go has "sync" and "sync/atomic" packages that provide mutexes, condition variables, etc. They provide tools for smaller problems.
Often, these things will work together to solve a bigger problem.
Always use the right tool for the job.
