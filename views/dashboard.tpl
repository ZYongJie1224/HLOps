<!DOCTYPE html>
<html lang="zh-CN">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>系统部署工具</title>
    <link rel="stylesheet" href="/static/css/style.css" />
  </head>
  <body>
    <div class="app-container">
      <!-- Sidebar (侧边栏) -->
      <div class="sidebar">
        <div class="logo-box">
          <div class="logo-circle">L</div>
          <h2>LOGO</h2>
        </div>
        <ul class="menu">
          <!-- 侧边栏菜单 -->
          <li class="menu-item active" onclick="showTab('system-info', this)">
            <span>系统信息</span>
          </li>
          <li class="menu-item" onclick="showTab('installed-apps', this)">
            <span>已安装应用</span>
          </li>
          <li class="menu-item" onclick="showTab('driver-deploy', this)">
            <span>驱动部署</span>
          </li>
          <li class="menu-item" onclick="showTab('app-deploy', this)">
            <span>应用部署</span>
          </li>
          <li class="menu-item" onclick="showTab('about', this)">
            <span>关于</span>
          </li>
        </ul>
      </div>

      <!-- Main Content (主内容区) -->
      <div class="main-content">
        <!-- Header (顶部标题) -->
        <div class="header-section">
          <h1 class="os-title">
            {{.OS}}<span class="version-tag">{{.OSversion}}</span>
          </h1>
          <div class="header-line"></div>
        </div>

        <!-- Panel 1: System Info (系统信息 - 含实时监控) -->
        <div id="system-info" class="content-panel active">
          <!-- 上半部分：静态系统概览 -->
          <div class="card info-card mb-20">
            <h3 class="card-title">系统概览</h3>
            <div class="info-grid">
              <div class="info-item">
                <div class="info-label">处理器 (CPU)</div>
                <div class="info-value">{{.CPU}}</div>
              </div>
              <div class="info-item">
                <div class="info-label">系统版本</div>
                <div class="info-value">{{.SystemVersion}}</div>
              </div>
              <div class="info-item">
                <div class="info-label">当前用户</div>
                <div class="info-value">{{.User}}</div>
              </div>

              <div class="info-item">
                <div class="info-label">运行时间</div>
                <div class="info-value">{{.RunTime}}</div>
              </div>
            </div>
          </div>

          <!-- 下半部分：实时性能监控 -->
          <h4 class="section-subtitle">实时性能监控</h4>
          <div class="perf-grid">
            <!-- 内存卡片 -->
            <div class="card perf-card">
              <div class="perf-header">
                <span class="perf-title">内存使用率</span>
                <span class="perf-icon">RAM</span>
              </div>
              <div class="perf-main-stat">
                <span id="mem-percent">0</span><span class="unit">%</span>
              </div>
              <div class="progress-bg">
                <div
                  class="progress-fill"
                  id="mem-bar"
                  style="width: 45%"
                ></div>
              </div>
              <div class="perf-sub-stat">
                已用: <span id="mem-used">0</span> GB / 总计: <span id="mem-total">0</span> GB
              </div>
            </div>

            <!-- 硬盘卡片 -->
            <div class="card perf-card">
              <div class="perf-header">
                <span class="perf-title">硬盘读写</span>
                <span class="perf-icon">DISK</span>
              </div>
              <div class="dual-stat-row">
                <div class="stat-box">
                  <span class="stat-label">读取</span>
                  <div class="stat-num">
                    <span id="disk-read">0</span> <small>MB/s</small>
                  </div>
                </div>
                <div class="divider-v"></div>
                <div class="stat-box">
                  <span class="stat-label">写入</span>
                  <div class="stat-num">
                    <span id="disk-write">0</span> <small>MB/s</small>
                  </div>
                </div>
              </div>
              <div class="activity-indicator">
                <div class="dot" id="disk-dot"></div>
                磁盘活动中
              </div>
            </div>

            <!-- 网络卡片 -->
            <div class="card perf-card">
              <div class="perf-header">
                <span class="perf-title">网络速率</span>
                <span class="perf-icon">NET</span>
              </div>
              <div class="dual-stat-row">
                <div class="stat-box">
                  <span class="stat-label">上传</span>
                  <div class="stat-num">
                    <span id="net-up">256</span> <small>KB/s</small>
                  </div>
                </div>
                <div class="divider-v"></div>
                <div class="stat-box">
                  <span class="stat-label">下载</span>
                  <div class="stat-num color-blue">
                    <span id="net-down">2.1</span> <small>MB/s</small>
                  </div>
                </div>
              </div>
              <div class="perf-sub-stat text-right">IP: 192.168.1.102</div>
            </div>
          </div>
        </div>

        <!-- Panel 2: Installed Apps (已安装应用) -->
        <div id="installed-apps" class="content-panel">
          <div class="filter-bar">
            <label class="custom-checkbox">
              <input type="checkbox" id="pre-apps" checked />
              Windows 预装软件
            </label>
          </div>
          <div class="card list-card">
            <ul class="app-list">
              <li>
                <div class="app-row">
                  <div class="app-info">
                    <span class="app-name">Google Chrome</span>
                    <span class="app-meta">240MB • 2023/10/01</span>
                  </div>
                  <input type="checkbox" class="row-checkbox" />
                </div>
              </li>
              <li>
                <div class="app-row">
                  <div class="app-info">
                    <span class="app-name">Microsoft Office 365</span>
                    <span class="app-meta">1.2GB • 2023/09/15</span>
                  </div>
                  <input type="checkbox" class="row-checkbox" />
                </div>
              </li>
              <li>
                <div class="app-row">
                  <div class="app-info">
                    <span class="app-name">Adobe Photoshop</span>
                    <span class="app-meta">800MB • 2023/08/20</span>
                  </div>
                  <input type="checkbox" class="row-checkbox" />
                </div>
              </li>
              <li>
                <div class="app-row">
                  <div class="app-info">
                    <span class="app-name">Visual Studio Code</span>
                    <span class="app-meta">120MB • 2023/11/02</span>
                  </div>
                  <input type="checkbox" class="row-checkbox" />
                </div>
              </li>
            </ul>
          </div>
        </div>

        <!-- Panel 3: Driver Deploy (驱动部署) -->
        <div id="driver-deploy" class="content-panel">
          <div class="card placeholder-card">
            <div class="placeholder-content">
              <div class="icon-placeholder">SDI</div>
              <h2>调用 SDI-RUS 驱动包</h2>
              <p>请确保外部驱动程序已连接</p>
            </div>
          </div>
        </div>

        <!-- Panel 4: App Deploy (应用部署) -->
        <div id="app-deploy" class="content-panel">
          <div class="card list-card with-action">
            <ul class="app-list striped">
              <li>
                <label class="deploy-item">
                  <input type="checkbox" class="row-checkbox" />
                  <span>常用运行库集合 (VC++ 2005-2022)</span>
                </label>
              </li>
              <li>
                <label class="deploy-item">
                  <input type="checkbox" class="row-checkbox" />
                  <span>解压缩软件 (7-Zip / Bandizip)</span>
                </label>
              </li>
              <li>
                <label class="deploy-item">
                  <input type="checkbox" class="row-checkbox" />
                  <span>输入法 (搜狗 / 微软拼音优化)</span>
                </label>
              </li>
              <li>
                <label class="deploy-item">
                  <input type="checkbox" class="row-checkbox" />
                  <span>远程工具 (ToDesk / TeamViewer)</span>
                </label>
              </li>
            </ul>
            <div class="action-area">
              <button class="btn-primary">开始部署</button>
            </div>
          </div>
        </div>

        <!-- Panel 5: About (关于) -->
        <div id="about" class="content-panel">
          <div class="card info-card">
            <h3 class="card-title">关于本工具</h3>
            <p class="card-desc">版本: v0.1.0</p>
            <p class="card-desc">开发部门: 技术部</p>
            <p class="card-desc">
              本工具旨在简化系统部署流程，集成信息查询、软件安装及驱动管理功能。
            </p>
          </div>
        </div>
      </div>
    </div>

    <script>
      fetchDiskInfo();
      fetchDiskInfo();
      // 选项卡切换逻辑
      function showTab(tabId, element) {
        // 隐藏所有面板
        var panels = document.getElementsByClassName("content-panel");
        for (var i = 0; i < panels.length; i++) {
          panels[i].classList.remove("active");
          panels[i].style.opacity = 0;
        }

        // 显示目标面板
        var activePanel = document.getElementById(tabId);
        activePanel.classList.add("active");
        // 简单的淡入效果
        setTimeout(() => {
          activePanel.style.opacity = 1;
        }, 50);

        // 更新侧边栏状态
        var items = document.getElementsByClassName("menu-item");
        for (var i = 0; i < items.length; i++) {
          items[i].classList.remove("active");
        }
        element.classList.add("active");
      }

      // // 模拟实时监控数据更新 (每2秒刷新一次)
      // setInterval(function () {
      //   // 1. 更新内存 (随机 30% - 80%)
      //   let mem = Math.floor(Math.random() * (80 - 30) + 30);
      //   document.getElementById("mem-percent").innerText = mem;
      //   document.getElementById("mem-bar").style.width = mem + "%";
      //   document.getElementById("mem-used").innerText = (
      //     (16 * mem) /
      //     100
      //   ).toFixed(1);



      //   // 3. 更新网络
      //   let up = Math.floor(Math.random() * 500);
      //   let down = (Math.random() * 10).toFixed(1);
      //   document.getElementById("net-up").innerText = up;
      //   document.getElementById("net-down").innerText = down;
      // }, 2000);
      // 1. 更新硬盘读写
      function fetchDiskInfo() {
        fetch('/getDiskInfo')
          .then(response => response.json())
          .then(data => {
            document.getElementById('disk-read').innerText = data.ReadBytes;
            document.getElementById('disk-write').innerText = data.WriteBytes;
          })
          .catch(error => console.error('Error fetching disk info:', error));
          console.log("Fetching disk info...");
      }

      // 2. 更新内存使用
      function fetchRAMInfo() {
        fetch('/getRAMInfo')
          .then(response => response.json())
          .then(data => {
            const used = data.used;
            const total = data.total;
            const percent = total > 0 ? Math.round((used / total) * 100) : 0;
            document.getElementById('mem-percent').innerText = percent;
            document.getElementById('mem-bar').style.width = percent + '%';
            document.getElementById('mem-used').innerText = used.toFixed(1);
            document.getElementById('mem-total').innerText = total.toFixed(1);
          })
          .catch(error => console.error('Error fetching RAM info:', error));
      }
      setInterval(fetchDiskInfo, 2000);
      setInterval(fetchRAMInfo, 2000);  

    </script>
  </body>
</html>
