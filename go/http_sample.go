// http://golang.site/go/article/103-HTTP-POST-%ED%98%B8%EC%B6%9C
package main
 
import (
	"bytes"
    "encoding/xml"
	"fmt"
    "io/ioutil"
    "net/http"
	"os"
	"github.com/joho/godotenv"
	// "text/template"
)
 
//Person -
type Person struct {
    Name string
    Age  int
}


func main() {
	person := Person{"Alex", 10}
    pbytes, _ := xml.Marshal(person)
    buff := bytes.NewBuffer(pbytes)

	godotenv.Load()
	url := os.Getenv("lambda_url")
	client_id := os.Getenv("client_id")
	client_secret := os.Getenv("client_secret")
	developer_token := os.Getenv("developer_token")
	refresh_token := os.Getenv("refresh_token")
	login_customer_id := os.Getenv("login_customer_id")


    // Request 객체 생성
	method := "get_conversion_tag_info"
	customer_parameter_name := "customerId"
	customer_id := "1234567890"
	param := fmt.Sprintf("%s=%s", customer_parameter_name, customer_id)
	// URL := template.Must(template.New("my").Parse("{{.url}}"))
	URL := fmt.Sprintf("%s/%s?%s", url, method, param)
	println(URL)

    req, err := http.NewRequest("POST", URL, buff)
    if err != nil {
        panic(err)
    }

	// println(developer_token)
	// println(client_id)
	// println(client_secret)
	// println(refresh_token)
	// println(login_customer_id)
	
    // 헤더 추가
    req.Header.Add("client-id", client_id)
    req.Header.Add("developer-token", developer_token)
    req.Header.Add("client-secret", client_secret)
    req.Header.Add("refresh-token", refresh_token)
    req.Header.Add("login-customer-id", login_customer_id)


    // Client객체에서 Request 실행
    client := &http.Client{}
    resp, err := client.Do(req)
    if err != nil {
        panic(err)
    }
    defer resp.Body.Close()
    // Response 체크.
    respBody, err := ioutil.ReadAll(resp.Body)
    if err == nil {
        str := string(respBody)
        println(str)
    }
}