package controllers

import (
	"HLOps/services"

	"github.com/beego/beego/v2/server/web"
)

type DashboardController struct {
	web.Controller
}

// TO Dashboard
// @router / [get]
func (c *DashboardController) Get() {
	// You can pass dynamic data here if needed
	info := services.GetSystemInfo()
	c.Data["OS"] = info.OS
	c.Data["OVersion"] = info.OSVersion
	c.Data["SystemVersion"] = info.SystemVersion
	c.Data["CPU"] = info.CPU
	c.Data["RunTime"] = info.RunTime
	c.Data["ReadBytes"] = info.ReadBytes
	c.Data["WriteBytes"] = info.WriteBytes
	c.TplName = "dashboard.tpl"
}

// @router /getDiskInfo [get]
func (c *DashboardController) GetDiskInfo() {
	diskInfo := services.GetDiskInfo()
	c.Data["json"] = map[string]float64{
		"ReadBytes":  diskInfo[0],
		"WriteBytes": diskInfo[1],
	}
	c.ServeJSON()
}

// @router /getRAMInfo [get]
func (c *DashboardController) GetRAMInfo() {
	used, total := services.GetRAMInfo()
	c.Data["json"] = map[string]float64{
		"used":  used,
		"total": total,
	}
	c.ServeJSON()
}
