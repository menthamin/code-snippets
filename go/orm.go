package main

import (
	"fmt"
	"github.com/astaxie/beego/orm"
	_ "github.com/go-sql-driver/mysql"
	// "model/model"
)

//create database orm_test;
//create table user ( id integer primary key, name varchar(255), profile_id integer );
type User struct {
	Id      int    	`orm:"column(id)`
	Name    string 	`orm:"size(100)"`
	// Profile     *Profile   `orm:"rel(one)"` // OneToOne relation
}


func init() {
	orm.RegisterDriver("mysql", orm.DRMySQL)
	orm.RegisterModel(new(User))
	orm.RegisterDataBase("default", "mysql", "root:1111@tcp(localhost:3306)/mysql?charset=utf8")
	orm.RegisterDataBase("orm_test", "mysql", "root:1111@tcp(localhost:3306)/orm_test?charset=utf8")
}

func main() {
	o := orm.NewOrm()
	o.Using("orm_test") // Using default, you can use other database
	user := new(User)
	// user.Profile = profile
	user.Name = "jeon"
	user.Id = 2
	fmt.Println(user)

	// var order_maps []orm.Params
	// o.Raw("select * from `other-database`.orders limit 100").Values(&order_maps)
	// fmt.Println(order_maps[0])

	// var maps []Params
	// fmt.Println(o.Raw("SELECT id FROM user WHERE name = ?", "slene"))

	var user_maps []orm.Params
	fmt.Println(o.Raw("SELECT * FROM user WHERE name = ?", "jeon").Values(&user_maps))
	fmt.Println(user_maps[0])

	// fmt.Println(o.Insert(profile))
	fmt.Println(o.Insert(user))
}