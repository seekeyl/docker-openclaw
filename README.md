# docker-openclaw

![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat&logo=docker&logoColor=white)
![OpenClaw](https://img.shields.io/badge/OpenClaw-FF6B6B?style=flat)
![Node.js](https://img.shields.io/badge/Node.js-25.6-green?style=flat)

在 Docker 中运行 OpenClaw 的完整解决方案，开箱即用。

## 📖 项目简介

docker-openclaw 是一个将 [OpenClaw](https://github.com/openclaw/openclaw) 封装为 Docker 容器的项目。通过 Docker Compose 可以快速部署 OpenClaw Gateway，无需手动安装 Node.js、Chrome、浏览器自动化工具等依赖。

## 🏗️ 技术架构

| 组件 | 版本/说明 |
|------|------------|
| 基础镜像 | Node.js 25.6 + Debian Bookworm |
| 操作系统 | Debian Bookworm |
| 浏览器 | Google Chrome (最新稳定版) |
| 自动化工具 | Agent Browser |
| 进程管理 | SupervisorD |

### 内置功能

- ✅ OpenClaw Gateway
- ✅ Chrome 浏览器 (用于浏览器自动化)
- ✅ Agent Browser (智能体浏览器自动化)
- ✅ 自动审批脚本 (危险命令自动批准)
- ✅ 国内镜像源 (npm + apt 加速)

## 🚀 快速开始

### 前置要求

- Docker
- Docker Compose

### 安装步骤

```bash
# 1. 克隆项目
git clone https://github.com/seekeyl/docker-openclaw.git
cd docker-openclaw

# 2. 配置环境变量
# 编辑 config/openclaw.json，配置你的 API Key 和渠道

# 3. 构建并运行
docker-compose up -d

# 4. 查看日志
docker-compose logs -f
```

### 访问方式

- Gateway 地址: `http://localhost:18789`
- WebChat: `http://localhost:18789/webchat` (需配置 WEBCHAT_TOKEN)

## ⚙️ 配置说明

### 环境变量

在 `docker-compose.yml` 中配置：

```yaml
environment:
  - TZ=Asia/Shanghai              # 时区
  - MINIMAX_API_KEY=YOUR_KEY     # MiniMax API Key
  - ALIYUNCS_API_API=YOUR_KEY    # 阿里云 API Key
  - WEBCHAT_TOKEN=YOUR_TOKEN     # WebChat 访问令牌
```

### 配置文件

配置文件挂载在 `config/openclaw.json`，可自定义配置项：

- 模型提供商
- 消息渠道 (Telegram, Discord, Slack 等)
- 安全策略
- 执行审批规则

详见 [OpenClaw 配置文档](https://docs.openclaw.ai/gateway/configuration)

## 📁 项目结构

```
docker-openclaw/
├── Dockerfile              # Docker 镜像构建文件
├── docker-compose.yml      # Docker Compose 编排文件
├── config/                 # 配置文件目录
│   └── openclaw.json      # OpenClaw 配置文件
├── workspace/              # 工作空间目录 (挂载到容器)
│   ├── AGENTS.md
│   ├── MEMORY.md
│   ├── SOUL.md
│   └── ...
├── scripts/                # 自动审批脚本
│   ├── approve.sh         # 命令审批脚本
│   ├── approve-10s.sh     # 10秒自动审批
│   └── supervisord.conf  # Supervisor 配置
├── run.sh                  # Linux 运行脚本
├── run.bat                 # Windows 运行脚本
├── build.sh                # Linux 构建脚本
├── build.bat               # Windows 构建脚本
├── browser_approve.sh      # 浏览器审批脚本 (Linux)
└── browser_approve.bat     # 浏览器审批脚本 (Windows)
```

## 🔧 常用操作

### 查看容器状态

```bash
docker-compose ps
```

### 查看实时日志

```bash
docker-compose logs -f
```

### 重启服务

```bash
docker-compose restart
```

### 停止服务

```bash
docker-compose down
```

### 重新构建镜像

```bash
docker-compose build --no-cache
```

## 🔐 安全说明

- 默认配置下，危险命令需要审批
- 已在 `scripts/` 中配置自动审批脚本，生产环境请谨慎使用
- API Key 等敏感信息请通过环境变量传入，不要提交到代码仓库

## 📦 镜像信息

- 镜像名称: `docker-openclaw:latest`
- 暴露端口: `18789` (Gateway)
- 数据卷:
  - `./config` → `/root/.openclaw/`
  - `./workspace` → `/root/.openclaw/workspace`

## 🤝 贡献指南

欢迎提交 Issue 和 Pull Request！

## 📄 License

MIT License - see [LICENSE](LICENSE) file.

## 🔗 相关链接

- [OpenClaw 官方文档](https://docs.openclaw.ai)
- [OpenClaw GitHub](https://github.com/openclaw/openclaw)
- [OpenClaw Discord](https://discord.com/invite/clawd)
