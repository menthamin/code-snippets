package main

//https://mingrammer.com/gobyexample/epoch/

import (
	"fmt"
	"time"
)

func main() {
	// time.LoadLocation(("UTC"))
	now := time.Now().UTC()
	// secs := now.Unix()
	// nanos := now.UnixNano()
	fmt.Println(now)

	// millis := nanos / 1000000
	// fmt.Println(secs)
	// fmt.Println(millis)
	// fmt.Println(nanos)

	// fmt.Println(time.Unix(secs, 0))
	// fmt.Println(time.Unix(0, nanos))

	time.Sleep(100 * time.Millisecond) // 0.1s
	// time.Sleep(3000 * time.Millisecond) // 3s
	time.Sleep(1 * time.Second)         // 1s

	start := time.Now()
	time.Sleep(2000 * time.Millisecond) // 2s
	elapsed := time.Now().Sub(start)
	fmt.Println( elapsed ) // 2.001080669s
}