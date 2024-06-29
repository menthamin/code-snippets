package main

import (
	"context"
	"fmt"
	"time"
)

func CaseDone() {
	// 1. WithTimeout을 사용하여 2초 후에 타임아웃이 발생하는 Context를 생성합니다.
	ctx, cancel := context.WithTimeout(context.Background(), 2*time.Second)
	defer cancel() // main 함수가 종료될 때 cancel 함수가 호출되어 Context가 해제됩니다.

	// 2. 고루틴을 시작합니다.
	go func() {
		// 3. select문을 사용하여 두 가지 경우 중 하나를 대기합니다.
		select {
		case <-time.After(1 * time.Second):
			// 4. 1초 후에 이 케이스가 실행됩니다.
			fmt.Println("작업 완료")
		case <-ctx.Done():
			// 5. Context가 취소되거나 타임아웃이 발생하면 이 케이스가 실행됩니다.
			fmt.Println("작업 취소됨:", ctx.Err())
		}
	}()

	// 6. main 함수가 3초 동안 대기합니다.
	time.Sleep(3 * time.Second)
}
