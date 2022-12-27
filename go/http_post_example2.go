# Wrong
package main

import (
	"fmt"
    "bytes"
    "io/ioutil"
    "net/http"
	"net/url"
	"strconv"
)

func main() {
    URL := "http://example.com/api/v1/create"

    // 파라미터를 전달하기 위해서는 Form 메서드를 사용합니다.
    data := url.Values{}
    data.Set("key", "value")
    data.Add("key2", "value2")

    // POST 요청을 위해서는 http.NewRequest 메서드를 사용합니다.
    req, _ := http.NewRequest("POST", URL, bytes.NewBufferString(data.Encode()))

    // 요청 헤더를 설정할 수 있습니다.
    req.Header.Add("Content-Type", "application/x-www-form-urlencoded")
    req.Header.Add("Content-Length", strconv.Itoa(len(data.Encode())))

	fmt.Println(req.URL)
	fmt.Println(req.Body)
	fmt.Println(req.Header)

    // 요청을 수행합니다.
    client := &http.Client{}
    resp, _ := client.Do(req)
    defer resp.Body.Close()

    // 응답 본문을 읽습니다.
    body, _ := ioutil.ReadAll(resp.Body)
    fmt.Println(string(body))
}