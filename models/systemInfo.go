package models

import "time"

//系统信息

type SystemInfo struct {
	//相关的系统信息字段
	OS            string        //系统
	OSVersion     string        //系统版本
	SystemVersion string        //系统版本
	CPU           string        //CPU型号
	GPU           string        //GPU型号
	User          string        //登录用户
	ReadBytes     float64       //已读字节数
	WriteBytes    float64       //已写字节数
	RunTime       time.Duration //系统已运行时长
}
