package routers

import (
	"HLOps/controllers"

	beego "github.com/beego/beego/v2/server/web"
)

func init() {
	// 这里可以添加自定义的路由规则
	beego.Router("/", &controllers.DashboardController{})
	beego.Router("/getDiskInfo", &controllers.DashboardController{}, "get:GetDiskInfo")
	beego.Router("/getRAMInfo", &controllers.DashboardController{}, "get:GetRAMInfo")
}
