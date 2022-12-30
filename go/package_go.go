package main

import (
	"fmt"
	"models"
	"reflect"
)
 
func main() {
    song := models.GetMusic("Alicia Keys")
    println(song)
    
    googleAdsVendorConversionTags := models.GoogleAdsVendorConversionTags{}
    fmt.Println(reflect.TypeOf(googleAdsVendorConversionTags))
}

// package main

// import "fmt"
 
// func main(){
//  fmt.Println("Hello")
// }