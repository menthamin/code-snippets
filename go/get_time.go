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
}