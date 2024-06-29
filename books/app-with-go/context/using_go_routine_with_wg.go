package main

import (
	"context"
	"fmt"
	"sync"
	"time"
)

func GoRoutineWithWG() {
	var wg sync.WaitGroup

	// 1초 후에 타임아웃되는 컨텍스트와 cancel 함수를 생성합니다.
	ctx, cancel := context.WithTimeout(context.Background(), 1*time.Second)
	defer cancel() // main 함수가 종료될 때 cancel 함수를 호출하여 컨텍스트를 취소합니다.

	wg.Add(1) // 고루틴의 작업을 기다리기 위해 WaitGroup의 카운터를 증가시킵니다.

	// 고루틴을 생성합니다.
	go func() {
		defer wg.Done() // 고루틴이 끝날 때 WaitGroup의 카운터를 감소시킵니다.
		// select 문을 사용하여 두 개의 채널을 기다립니다.
		select {
		case <-time.After(2 * time.Second):
			// 2초 후에 "작업 완료" 메시지를 출력합니다.
			fmt.Println("작업 완료")
		case <-ctx.Done():
			// 컨텍스트가 취소되었을 때 "작업 취소됨" 메시지와 오류를 출력합니다.
			fmt.Println("작업 취소됨:", ctx.Err())
		}
	}()

	wg.Wait() // 고루틴의 작업이 끝날 때까지 기다립니다.
}
