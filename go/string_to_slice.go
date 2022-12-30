// You can edit this code!
// Click here and start typing.
package main

import (
	"encoding/json"
	"fmt"
	"reflect"
)

type googleAdsTagInfo struct {
	CustoemrId				string `json:"amount"`
	ResourceName			string `json:"date"`
	ConversionActionId  	string `json:"price"`
	ConversionActionName    uint   `json:"tid"`
	}


func main() {
	data := `[
		{
		  "custoemr_id": 123456789,
		  "resource_name": "customers/123456789/conversionActions/123459028",
		  "conversion_action_id": 123459028,
		  "conversion_action_name": "Purchase Paid",
		  "conversion_tag_id": "AW-12345",
		  "conversion_tag_label": "0cBDCMTCu4",
		  "error": false
		},
		{
		  "custoemr_id": 123456789,
		  "resource_name": "customers/123456789/conversionActions/1234039749",
		  "conversion_action_id": 1234039749,
		  "conversion_action_name": "Initiate Checkout",
		  "conversion_tag_id": "AW-12345",
		  "conversion_tag_label": "GpK3CMWyvY",
		  "error": false
		},
		{
		  "custoemr_id": 123456789,
		  "resource_name": "customers/123456789/conversionActions/1234039752",
		  "conversion_action_id": 1234039752,
		  "conversion_action_name": "Purchase",
		  "conversion_tag_id": "AW-12345",
		  "conversion_tag_label": "2-L2CMiyvY",
		  "error": false
		},
		{
		  "custoemr_id": 123456789,
		  "resource_name": "customers/123456789/conversionActions/1234039776",
		  "conversion_action_id": 1234039776,
		  "conversion_action_name": "Add To Cart",
		  "conversion_tag_id": "AW-12345",
		  "conversion_tag_label": "MTH_COCyvY",
		  "error": false
		},
		{
		  "custoemr_id": 123456789,
		  "resource_name": "customers/123456789/conversionActions/1234087072",
		  "conversion_action_id": 1234087072,
		  "conversion_action_name": "Page View",
		  "conversion_tag_id": "AW-12345",
		  "conversion_tag_label": "b9MVCKCkwI",
		  "error": false
		}
	  ]`
	fmt.Println(data)
	fmt.Println(reflect.TypeOf(data))

	var maps []string
	err := json.Unmarshal([]byte(data), &maps)
	fmt.Println(err)
	fmt.Println(data)

}