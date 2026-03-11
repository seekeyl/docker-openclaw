# 基础镜像：Node.js 25.6 + Debian Bookworm
FROM node:25.6-bookworm

# 配置国内源
RUN npm config set registry https://registry.npmmirror.com/ \
    && sed -i 's/deb.debian.org/mirrors.tuna.tsinghua.edu.cn/g' /etc/apt/sources.list.d/debian.sources

# 安装系统依赖（包括 Chrome 所需库）
RUN apt update && apt upgrade -y 
RUN apt install -y \
       python3 python3-pip vim net-tools jq wget supervisor xvfb chromium \
       libnss3 libnspr4 libatk1.0-0 libatk-bridge2.0-0 libcups2 libdrm2 \
       libxkbcommon0 libxcomposite1 libxdamage1 libxfixes3 \
       libxrandr2 libgbm1 libpango-1.0-0 libcairo2 libasound2

# 安装 OpenClaw
RUN npm i -g openclaw
# 安装 智能体浏览器
RUN npm install -g agent-browser && agent-browser install

# 非交互式初始化配置
RUN yes "" | openclaw setup

# 飞书插件
RUN openclaw plugins install @openclaw/feishu
# 删除重复文件
RUN rm -rf /root/.openclaw/extensions/feishu

# 企微插件
RUN openclaw plugins install @wecom/wecom-openclaw-plugin

# 复制自动审批文件
RUN mkdir -p /opt/scripts/
ADD ./scripts/* /opt/scripts/
RUN mv /opt/scripts/supervisord.conf /etc/supervisor/conf.d/

# 暴露端口（仅 gateway 端口）
EXPOSE 18789

# 启动命令：gateway 同时运行
CMD ["supervisord", "-c", "/etc/supervisor/supervisord.conf"]