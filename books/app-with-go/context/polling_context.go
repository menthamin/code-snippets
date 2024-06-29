package main

import (
	"context"
	"fmt"
	"time"
)

func PollingContext() {
	ctx, cancel := context.WithCancel(context.Background())
	task := make(chan int)
	go func() {
		for {
			select {
			case <-ctx.Done():
				return
			case i := <-task:
				fmt.Println("task:", i)
			default:
				fmt.Println("default (not stopped)")
			}
			time.Sleep(200 * time.Millisecond)
		}
	}()
	time.Sleep(1 * time.Second)
	for i := 0; i < 5; i++ {
		task <- i
	}
	cancel()
}
