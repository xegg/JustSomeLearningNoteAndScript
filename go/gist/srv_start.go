package main

import (
	"bufio"
	"context"
	"errors"
	"fmt"
	"os"
	"os/signal"
	"strings"
	"sync"
	"time"
)

//标准程序执行和退出的执行接口,运行程序要实现接口定义的方法
type Service interface {
	Init() error
	//当程序启动运行的时候,需要执行的代码。不得阻塞。
	Start() error
	//程序退出的时候,需要执行的代码。不得阻塞。
	Stop() error
}

var msgChan = make(chan os.Signal, 1)

// 程序运行、退出的包装容器,主程序直接调用。
func Run(service Service) error {
	if err := service.Init(); err != nil {
		return err
	}
	if err := service.Start(); err != nil {
		return err
	}
	signal.Notify(msgChan, os.Interrupt, os.Kill)
	<-msgChan
	return service.Stop()
}

// 通常不需要调用,特殊情况下,在程序内其他模块中，需要通知程序退出才会使用。
func Interrupt() {
	msgChan <- os.Interrupt
}

type Program struct {
	ctx        context.Context
	exitFunc   context.CancelFunc
	cancelFunc map[string]context.CancelFunc
	wg         WaitGroupWrapper
}

func main() {
	p := &Program{
		cancelFunc: make(map[string]context.CancelFunc),
	}
	p.ctx, p.exitFunc = context.WithCancel(context.Background())
	svc.Run(p)

}
func (p *Program) Init() error {
	//just demon,do nothing
	return nil
}

func (p *Program) Start() error {
	fmt.Println("本程序将会根据输入,启动或终止服务。")

	reader := bufio.NewReader(os.Stdin)
	go func() {
		for {
			fmt.Println("程序退出命令:exit;服务启动命令:<start||s>-[name];服务停止命令:<cancel||c>-[name]。请注意大小写!")
			input, _, _ := reader.ReadLine()
			command := string(input)
			switch command {
			case "exit":
				goto OutLoop
			default:
				command, name, err := splitInput(input)
				if err != nil {
					fmt.Println(err)
					continue
				}
				switch command {
				case "start", "s":
					newctx, cancelFunc := context.WithCancel(p.ctx)
					p.cancelFunc[name] = cancelFunc

					p.wg.Wrap(func() {
						Func(newctx, name)
					})

				case "cancel", "c":
					cancelFunc, founded := p.cancelFunc[name]
					if founded {
						cancelFunc()
					}
				}
			}
		}
	OutLoop:
		//由于程序退出被Run的os.Notify阻塞，因此调用以下方法通知退出代码执行。
		svc.Interrupt()
	}()
	return nil
}
func (p *Program) Stop() error {
	p.exitFunc()
	p.wg.Wait()
	fmt.Println("所有服务终止,程序退出!")
	return nil
}

//用来转换输入字符串为输入命令
func splitInput(input []byte) (command, name string, err error) {
	line := string(input)
	strs := strings.Split(line, "-")
	if strs == nil || len(strs) != 2 {
		err = errors.New("输入不符合规则。")
		return
	}
	command = strs[0]
	name = strs[1]
	return
}

// 一个简单的循环方法,模拟被加载、释放的微服务
func Func(ctx context.Context, name string) {
	for {
		select {
		case <-ctx.Done():
			goto OutLoop
		case <-time.Tick(time.Second * 2):
			fmt.Printf("%s is running.\n", name)
		}
	}
OutLoop:
	fmt.Printf("%s is end.\n", name)
}

//WaitGroup封装结构
type WaitGroupWrapper struct {
	sync.WaitGroup
}

func (w *WaitGroupWrapper) Wrap(f func()) {
	w.Add(1)
	go func() {
		f()
		w.Done()
	}()
}
