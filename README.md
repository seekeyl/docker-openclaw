# docker-openclaw

![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat&logo=docker&logoColor=white)
![OpenClaw](https://img.shields.io/badge/OpenClaw-FF6B6B?style=flat)
![Node.js](https://img.shields.io/badge/Node.js-25.6-green?style=flat)
![License](https://img.shields.io/badge/License-MIT-green?style=flat)

在 Docker 中运行 OpenClaw 的完整解决方案，开箱即用。

## 📖 项目简介

docker-openclaw 是一个将 [OpenClaw](https://github.com/openclaw/openclaw) 封装为 Docker 容器的项目。通过 Docker Compose 可以快速部署 OpenClaw Gateway，无需手动安装 Node.js、Chrome、浏览器自动化工具等依赖。

### 主要特性

- 🚀 **一键部署** - Docker Compose 快速启动
- 🔒 **安全优先** - 内置审批机制，可配置自动批准
- 🌏 **国内优化** - npm + apt 镜像源加速
- 📱 **多渠道支持** - 飞书、企业微信、Telegram 等
- 🔧 **可扩展** - 支持自定义配置和工作空间
- 🌐 **远程访问** - 支持 LAN 模式远程访问

## 🏗️ 技术架构

| 组件       | 版本/说明                          |
| ---------- | ---------------------------------- |
| 基础镜像   | Node.js 25.6 + Debian Bookworm     |
| 操作系统   | Debian Bookworm                    |
| 浏览器支持 | Chromium + Agent Browser           |
| 进程管理   | SupervisorD (预留)                 |
| 虚拟显示   | Xvfb (无头浏览器支持)              |

### 内置功能

- ✅ OpenClaw Gateway (端口 18789)
- ✅ Agent Browser (智能体浏览器自动化)
- ✅ 自动审批脚本 (可选启用)
- ✅ 国内镜像源 (npm + apt 加速)
- ✅ 飞书插件集成
- ✅ 企业微信插件集成

## 🚀 快速开始

### 前置要求

- Docker Engine 20.10+
- Docker Compose V2

### 安装步骤

```bash
# 1. 进入项目目录
cd docker-openclaw

# 2. 配置环境变量
# 编辑 docker-compose.yml 中的环境变量，或创建 .env 文件

# 3. 构建并运行
docker-compose up -d

# 4. 查看日志
docker-compose logs -f
```

### 首次访问

| 服务    | 地址                           | 说明 |
| ------- | ------------------------------ | ---- |
| Gateway | http://localhost:18789         |      |
| WebChat | http://localhost:18789/webchat | 需要配置 WEBCHAT_TOKEN |

> **注意**: 首次运行需要配置 API Key 等环境变量才能正常使用

## ⚙️ 配置说明

### 环境变量

在 `docker-compose.yml` 中配置：

| 变量名                | 必填 | 默认值                 | 说明                      |
| --------------------- | ---- | ---------------------- | ------------------------- |
| `TZ`                | 否   | Asia/Shanghai          | 时区                      |
| `MINIMAX_API_KEY`   | 是   | -                      | MiniMax API Key           |
| `ALIYUNCS_API_KEY`  | 否   | -                      | 阿里云 API Key (备用模型)  |
| `PRIMARY_MODEL`     | 否   | aliyuncs/qwen3.5-plus  | 主用模型                  |
| `PRIMARY_VL_MODEL`  | 否   | aliyuncs/qwen3-vl-plus | 视觉模型 (支持图片理解)   |
| `WEBCHAT_TOKEN`     | 否   | -                      | WebChat 访问令牌          |
| `FEISHU_APP_ID`     | 否   | -                      | 飞书应用 ID               |
| `FEISHU_APP_SECRET` | 否   | -                      | 飞书应用密钥              |
| `QYWECHAT_BOT_ID`   | 否   | -                      | 企业微信 Bot ID           |
| `QYWECHAT_SECRET`   | 否   | -                      | 企业微信 Secret           |

### 内置模型

项目已预配置以下模型：

| 模型 | 类型 | 说明 |
|------|------|------|
| `minimax/MiniMax-M2.5` | 文本+视觉 | MiniMax M2.5 (需配置 MINIMAX_API_KEY) |
| `aliyuncs/qwen3.5-plus` | 文本 | 阿里云 Qwen3.5 Plus |
| `aliyuncs/qwen3-vl-plus` | 文本+视觉 | 阿里云 Qwen3-VL-Plus |

### 配置文件

配置文件 `config/openclaw.json` 采用模板形式，挂载到容器后会自动读取环境变量：

```json
{
  "models": {
    "providers": {
      "minimax": {
        "apiKey": "${MINIMAX_API_KEY}"
      }
    }
  },
  "channels": {
    "feishu": {
      "enabled": true,
      "accounts": {
        "default": {
          "appId": "${FEISHU_APP_ID}",
          "appSecret": "${FEISHU_APP_SECRET}"
        }
      }
    }
  }
}
```

### 切换模型

```bash
# 使用 MiniMax 作为主模型
PRIMARY_MODEL=minimax/MiniMax-M2.5 docker-compose up -d

# 使用阿里云 Qwen 作为主模型
PRIMARY_MODEL=aliyuncs/qwen3.5-plus docker-compose up -d
```

## 📁 项目结构

```
docker-openclaw/
├── Dockerfile              # Docker 镜像构建文件
├── docker-compose.yml      # Docker Compose 编排文件
├── config/                 # 配置文件目录
│   └── openclaw.json      # OpenClaw 配置文件模板
├── workspace/              # 工作空间目录 (持久化)
├── scripts/                # 自动审批脚本
│   ├── approve.sh         # 审批脚本
│   ├── approve-10s.sh     # 10秒自动审批循环
│   └── supervisord.conf  # Supervisor 配置
├── run.sh                  # Linux 运行脚本
├── run.bat                 # Windows 运行脚本
├── build.sh                # Linux 构建脚本
├── build.bat               # Windows 构建脚本
├── browser_approve.sh      # 浏览器审批脚本 (Linux)
├── browser_approve.bat     # 浏览器审批脚本 (Windows)
└── LICENSE                 # MIT 许可证
```

### 数据卷挂载

| 宿主机路径 | 容器路径 | 说明 |
| ---------- | -------- | ---- |
| `./config/openclaw.json` | `/root/.openclaw/openclaw.json` | 配置文件 |
| `./workspace` | `/root/.openclaw/workspace` | 工作空间 |
| `./agents` | `/root/.openclaw/agents` | Agent 配置 |
| `./cron` | `/root/.openclaw/cron` | 定时任务 |
| `./wecom` | `/root/.openclaw/wecom` | 企业微信配置 |
| `./feishu` | `/root/.openclaw/feishu` | 飞书配置 |

## 🔧 常用操作

### 容器管理

```bash
# 构建镜像
docker-compose build

# 后台启动
docker-compose up -d

# 查看状态
docker-compose ps

# 查看实时日志
docker-compose logs -f

# 查看实时日志 (仅 OpenClaw)
docker-compose logs -f openclaw

# 重启服务
docker-compose restart

# 停止服务
docker-compose down

# 停止并删除卷
docker-compose down -v
```

### 进入容器调试

```bash
# 进入容器 Shell
docker exec -it docker-openclaw /bin/bash

# 查看 OpenClaw 状态
docker exec -it docker-openclaw openclaw status

# 查看待审批请求
docker exec -it docker-openclaw openclaw devices list
```

### 审批管理

```bash
# 手动审批所有待定请求
docker exec -it docker-openclaw openclaw devices approve --all

# 启用自动审批 (在容器内)
docker exec -d docker-openclaw sh /opt/scripts/approve-10s.sh

# 查看审批日志
docker exec -it docker-openclaw tail -f /tmp/openclaw-approve.log
```

### 插件管理

```bash
# 安装飞书插件
docker exec -it docker-openclaw openclaw plugins install @openclaw/feishu

# 安装企业微信插件
docker exec -it docker-openclaw openclaw plugins install @wecom/wecom-openclaw-plugin

# 查看已安装插件
docker exec -it docker-openclaw openclaw plugins list
```

## 🔐 安全说明

### 默认安全策略

- 默认配置下，危险命令需要审批
- 本地网络请求自动批准
- 远程请求需要手动审批
- WebChat 需要 Token 认证

### 生产环境建议

1. **API Key 管理** - 使用 .env 文件或 Docker secrets
2. **网络隔离** - 配置防火墙规则
3. **Token 安全** - 使用强 Token，启用 rate limiting
4. **定期更新** - 关注 OpenClaw 最新版本
5. **关闭自动审批** - 生产环境建议手动审批

### 安全配置示例

```yaml
# docker-compose.yml
services:
  openclaw:
    environment:
      - WEBCHAT_TOKEN=${WEBCHAT_TOKEN}  # 使用 .env 文件
    # 限制容器能力
    security_opt:
      - no-new-privileges:true
```

## 📦 镜像信息

| 项目     | 值                                       |
| -------- | ---------------------------------------- |
| 镜像名称 | docker-openclaw:latest                   |
| 暴露端口 | 18789 (Gateway)                          |
| 数据卷   | ./config → /root/.openclaw/             |
| 数据卷   | ./workspace → /root/.openclaw/workspace |

## 🤝 常见问题

### Q: 容器启动失败怎么办？

```bash
# 查看详细日志
docker-compose logs

# 检查端口是否被占用
netstat -tlnp | grep 18789

# 检查容器是否正常运行
docker ps -a
```

### Q: 如何更新 OpenClaw 版本？

```bash
# 重新构建镜像
docker-compose build

# 拉取最新镜像
docker-compose pull

# 重启服务
docker-compose restart
```

### Q: 飞书/企业微信消息收不到？

1. 检查环境变量是否正确配置
2. 确认应用/机器人已启用
3. 查看日志：`docker-compose logs | grep -E 'feishu|wecom'`

### Q: 如何持久化数据？

所有数据通过 docker-compose.yml 中定义的数据卷持久化：
- `workspace/` - 对话历史、文件等
- `config/openclaw.json` - 配置文件

### Q: 如何使用 WebChat？

1. 在 docker-compose.yml 中设置 `WEBCHAT_TOKEN`
2. 访问 http://localhost:18789/webchat
3. 输入 Token 登录

## 🔗 相关链接

- [OpenClaw 官方文档](https://docs.openclaw.ai)
- [OpenClaw GitHub](https://github.com/openclaw/openclaw)
- [ClawHub - Skills 市场](https://clawhub.ai)
- [MiniMax API](https://platform.minimaxi.com)
- [阿里云 DashScope](https://dashscope.aliyuncs.com)

## 📄 License

MIT License - see [LICENSE](LICENSE) file.

---

<p align="center">
  Made with ❤️ by Seekey
</p>
