package services

import (
	"HLOps/models"
	"fmt"
	"math"
	"time"

	"github.com/shirou/gopsutil/v3/cpu"
	"github.com/shirou/gopsutil/v3/disk"
	"github.com/shirou/gopsutil/v3/host"
	"github.com/shirou/gopsutil/v3/mem"
)

// TODO 获取系统相信信息（硬件、开机时长、登录用户等）
func GetSystemInfo() models.SystemInfo {
	//需要的信息：

	/*
		OS            string        //系统
		OSVersion     string        //系统版本
		SystemVersion string        //系统版本
		RunTime       time.Duration //系统已运行时长
	*/
	hostInfo, _ := host.Info()
	fmt.Println(hostInfo)

	cpuInfo, _ := cpu.Info()
	fmt.Println(cpuInfo)
	cpuName := ""
	if len(cpuInfo) > 0 {
		cpuName = cpuInfo[0].ModelName
	}
	fmt.Println(cpuName)

	return models.SystemInfo{
		OS:            hostInfo.Platform,
		OSVersion:     hostInfo.PlatformVersion,
		SystemVersion: hostInfo.KernelVersion,
		RunTime:       time.Duration(hostInfo.Uptime) * time.Second,
		// ReadBytes:     math.Round(float64(rb)/(1024*1024)*10) / 10,
		// WriteBytes:    math.Round(float64(wb)/(1024*1024)*10) / 10,
		CPU: cpuName,
	}
}
func GetDiskInfo() []float64 {
	ioStatA, err := disk.IOCounters()
	time.Sleep(1 * time.Second)
	if err != nil {
		fmt.Println("获取磁盘IO信息失败:", err)
	}
	ioStatB, err := disk.IOCounters()
	if err != nil {
		fmt.Println("获取磁盘IO信息失败:", err)
	}
	rb := ioStatB["C:"].ReadBytes - ioStatA["C:"].ReadBytes
	wb := ioStatB["C:"].WriteBytes - ioStatA["C:"].WriteBytes
	return []float64{math.Round(float64(rb)/(1024*1024)*10) / 10, math.Round(float64(wb)/(1024*1024)*10) / 10}
}
func GetRAMInfo() (float64, float64) {
	// TODO 获取内存使用信息

	meminfo, err := mem.VirtualMemory()
	if err == nil {
		used := math.Round(float64(meminfo.Used)/(1024*1024*1024)*10) / 10
		total := math.Round(float64(meminfo.Total)/(1024*1024*1024)*10) / 10
		return used, total
	}
	return 0, 0
}
