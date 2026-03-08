# 基础镜像：Node.js 25.6 + Debian Bookworm
FROM node:25.6-bookworm

# 配置国内源
RUN npm config set registry https://registry.npmmirror.com/ \
    && sed -i 's/deb.debian.org/mirrors.tuna.tsinghua.edu.cn/g' /etc/apt/sources.list.d/debian.sources

# 安装系统依赖（包括 Chrome 所需库）
RUN apt update \
    && apt upgrade -y \
    && apt install -y \
       python3 python3-pip \
       vim net-tools jq \
       wget supervisor \
       xvfb 

# 安装 Chrome
RUN wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
RUN apt install -y ./google-chrome-stable_current_amd64.deb 
RUN rm -rf google-chrome-stable_current_amd64.deb

# 安装 OpenClaw
RUN npm install -g openclaw@latest
# 安装 智能体浏览器
RUN npm install -g agent-browser && agent-browser install

# 非交互式初始化配置
RUN yes "" | openclaw setup

# 复制自动审批文件
RUN mkdir -p /opt/scripts/
ADD ./scripts/* /opt/scripts/
RUN mv /opt/scripts/supervisord.conf /etc/supervisor/conf.d/

# 暴露端口（仅 gateway 端口）
EXPOSE 18789

# 启动命令：gateway 同时运行
CMD ["supervisord", "-c", "/etc/supervisor/supervisord.conf"]