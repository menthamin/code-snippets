package models

/*
>> go env | grep GOROOT
GOROOT="/opt/homebrew/Cellar/go/1.18.1/libexec"

File Path: {GOROOT}/src/models/google_ads_vendor_conversion_tags.go
*/

import "time"

// Model
type GoogleAdsVendorConversionTags struct {
	ID        				int64      	`orm:"column(id);auto" json:"id"`
	GoogleAdsVendorLinkId		string		`orm:"column(google_ads_vendor_link_id);" json:"google_ads_vendor_link_id,omitempty"`
	CustomerID					int64		`orm:"column(customer_id);" json:"customer_id,omitempty"`
	ResourceName				string		`orm:"column(resource_name);" json:"resource_name,omitempty"`
	ConversionActionTypeId		string		`orm:"column(conversion_action_typeid);" json:"conversion_action_typeid,omitempty"`
	ConversionActionName		string		`orm:"column(conversion_action_name);" json:"conversion_action_name,omitempty"`
	ConversionTagId				string		`orm:"column(conversion_tag_id);" json:"conversion_tag_id,omitempty"`
	ConversionTagLabel			string		`orm:"column(conversion_tag_label);" json:"conversion_tag_label,omitempty"`
	CreatedAt 				*time.Time 	`orm:"column(created_at);type(timestamp);auto_now_add;null" json:"createdAt,omitempty"`
	UpdatedAt 				*time.Time 	`orm:"column(updated_at);type(timestamp);auto_now;null" json:"updatedAt,omitempty"`
	DeleteAt  				*time.Time 	`orm:"column(deleted_at);type(timestamp);null" json:"deleteAt,omitempty"`
}


// TableName -
func (t *GoogleAdsVendorConversionTags) TableName() string {
	return "`tokotalk`.`google_ads_vendor_conversion_tags`"
}