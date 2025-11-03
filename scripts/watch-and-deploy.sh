#!/bin/bash

# 文件监控和自动部署脚本
# 监控文件变化并自动部署到生产环境

set -e

# 配置
INTERVAL=${1:-10}  # 默认10秒检查一次
WATCH_DIR="$(git rev-parse --show-toplevel)"
LOG_FILE="$WATCH_DIR/watch-deploy.log"
LAST_HASH=""

# 颜色
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${BLUE}╔═══════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║       Claude Code Skill 监控部署模式     ║${NC}"
echo -e "${BLUE}╚═══════════════════════════════════════════╝${NC}\n"

echo -e "${BLUE}监控目录：$WATCH_DIR${NC}"
echo -e "${BLUE}检查间隔：${INTERVAL}秒${NC}"
echo -e "${BLUE}日志文件：$LOG_FILE${NC}"
echo -e "${YELLOW}按 Ctrl+C 停止监控${NC}\n"

# 获取初始hash
get_dir_hash() {
    find "$WATCH_DIR" -type f -name "*.md" -o -name "*.json" | sort | xargs md5sum | md5sum | awk '{print $1}'
}

# 记录日志
log() {
    echo -e "$1" | tee -a "$LOG_FILE"
}

# 监控循环
while true; do
    CURRENT_HASH=$(get_dir_hash)

    if [ "$LAST_HASH" != "$CURRENT_HASH" ] && [ -n "$LAST_HASH" ]; then
        log "\n${YELLOW}[$(date '+%Y-%m-%d %H:%M:%S')] 检测到文件变化！${NC}"
        log "${BLUE}触发自动部署...${NC}\n"

        # 切换到项目目录并执行部署
        cd "$WATCH_DIR"
        bash auto-deploy.sh

        log "\n${GREEN}✅ 自动部署完成${NC}"
        log "${BLUE}继续监控...${NC}\n"
    fi

    LAST_HASH="$CURRENT_HASH"
    sleep "$INTERVAL"
done
