package main

import (
	"fmt"
	"net/http"
	"net/url"
)

func main() {
	// Set up the parameters
	params := url.Values{}
	params.Set("key1", "value1")
	params.Set("key2", "value2")

	// Create the request
	req, err := http.NewRequest("GET", "http://example.com", nil)
	if err != nil {
		fmt.Println(err)
		return
	}

	// Set the parameters in the query string
	req.URL.RawQuery = params.Encode()

	// Send the request and print the response
	client := &http.Client{}
	resp, err := client.Do(req)
	if err != nil {
		fmt.Println(err)
		return
	}
	defer resp.Body.Close()
	fmt.Println(resp.StatusCode)
}