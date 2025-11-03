#!/bin/bash

# Claude Code Skill 自动部署脚本
# 功能：自动提交Git变更并部署到生产环境

set -e  # 遇到错误立即退出

# 配置变量
PROJECT_NAME="hs-req-facilitator-skill"
SKILL_DIR="$HOME/.claude/skills/$PROJECT_NAME"
BACKUP_SUFFIX="-backup-$(date +%Y%m%d-%H%M%S)"
GIT_MESSAGE=""

# 颜色输出
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}=== Claude Code Skill 自动部署脚本 ===${NC}\n"

# 1. 检查Git状态
echo -e "${BLUE}[1/4] 检查Git状态...${NC}"
if [ -z "$(git status --porcelain)" ]; then
    echo -e "${GREEN}✅ 工作区干净，没有变更需要提交${NC}"
    echo -e "${YELLOW}⚠️  仍然会进行部署检查${NC}"
else
    echo -e "${YELLOW}📝 发现未提交的变更：${NC}"
    git status --short
    echo ""
fi

# 2. 获取提交信息
echo -e "${BLUE}[2/4] 准备提交变更...${NC}"
if [ ! -z "$(git status --porcelain)" ]; then
    if [ -z "$GIT_MESSAGE" ]; then
        echo "请输入提交信息（留空将自动生成）："
        read -r GIT_MESSAGE
    fi

    if [ -z "$GIT_MESSAGE" ]; then
        # 自动生成提交信息
        CHANGED_FILES=$(git diff --name-only --staged | wc -l)
        GIT_MESSAGE="chore: auto-update $(date '+%Y-%m-%d %H:%M') - $CHANGED_FILES file(s)"
        echo -e "${YELLOW}使用自动生成的提交信息：${GIT_MESSAGE}${NC}"
    fi

    # 提交变更
    git add .
    git commit -m "$GIT_MESSAGE"
    echo -e "${GREEN}✅ Git提交完成${NC}"

    # 显示最新提交
    echo -e "${YELLOW}最新提交：${NC}"
    git log -1 --oneline
fi

# 3. 部署到生产环境
echo -e "\n${BLUE}[3/4] 部署到生产环境...${NC}"

# 检查目标目录是否存在
if [ ! -d "$SKILL_DIR" ]; then
    echo -e "${YELLOW}📁 创建生产环境目录...${NC}"
    mkdir -p "$SKILL_DIR"
fi

# 备份现有文件
if [ -n "$(ls -A $SKILL_DIR 2>/dev/null)" ]; then
    echo -e "${YELLOW}💾 备份现有生产环境文件...${NC}"
    BACKUP_DIR="$SKILL_DIR$BACKUP_SUFFIX"
    cp -r "$SKILL_DIR" "$BACKUP_DIR"
    echo -e "${GREEN}✅ 备份完成：$BACKUP_DIR${NC}"
fi

# 部署核心文件
echo -e "${YELLOW}📦 部署核心文件...${NC}"
CORE_FILES=("SKILL.md" "README.md" "STAGE3-DEBUG.md")
for file in "${CORE_FILES[@]}"; do
    if [ -f "$file" ]; then
        cp "$file" "$SKILL_DIR/"
        echo -e "  ✅ $file"
    fi
done

# 部署指南文件（如果存在）
echo -e "${YELLOW}📚 部署指南文件...${NC}"
GUIDE_FILES=("ANALYZER.md" "QUESTIONS.md" "ENHANCER.md" "MERGER.md" "EMPTY-PROJECT.md" "SPEC-WORKFLOW-INTEGRATION.md")
for file in "${GUIDE_FILES[@]}"; do
    if [ -f "$file" ]; then
        cp "$file" "$SKILL_DIR/"
        echo -e "  ✅ $file"
    fi
done

# 保留备份中的重要文件（如果新版本没有）
if [ -d "$BACKUP_DIR" ]; then
    echo -e "${YELLOW}🔄 保留旧版本重要文件...${NC}"
    BACKUP_GUIDES=("CURSOR_CUSTOMIZATION_GUIDE.md" "CURSOR_NATIVE_IMPLEMENTATION.md")
    for file in "${BACKUP_GUIDES[@]}"; do
        if [ -f "$BACKUP_DIR/$file" ] && [ ! -f "$SKILL_DIR/$file" ]; then
            cp "$BACKUP_DIR/$file" "$SKILL_DIR/"
            echo -e "  ✅ $file (从备份恢复)"
        fi
    done
fi

echo -e "${GREEN}✅ 部署完成！${NC}"

# 4. 运行测试
echo -e "\n${BLUE}[4/4] 运行部署测试...${NC}"

# 检查文件是否正确部署
echo -e "${YELLOW}🔍 验证部署文件...${NC}"
if [ ! -f "$SKILL_DIR/SKILL.md" ]; then
    echo -e "${RED}❌ 错误：SKILL.md 未部署${NC}"
    exit 1
fi

if [ ! -f "$SKILL_DIR/README.md" ]; then
    echo -e "${RED}❌ 错误：README.md 未部署${NC}"
    exit 1
fi

# 检查AskUserQuestion格式
echo -e "${YELLOW}🔧 检查AskUserQuestion格式...${NC}"
if grep -q "AskUserQuestion({" "$SKILL_DIR/SKILL.md"; then
    echo -e "${GREEN}✅ AskUserQuestion 调用存在${NC}"
else
    echo -e "${RED}❌ 错误：未找到AskUserQuestion 调用${NC}"
    exit 1
fi

# 检查AskUserQuestion格式是否正确
if grep -q "questions: \[" "$SKILL_DIR/SKILL.md"; then
    echo -e "${GREEN}✅ AskUserQuestion 格式正确${NC}"
else
    echo -e "${RED}❌ 错误：AskUserQuestion 格式可能不正确${NC}"
    exit 1
fi

# 统计部署文件
FILE_COUNT=$(ls -1 "$SKILL_DIR" | wc -l)
echo -e "${GREEN}✅ 部署验证完成，共 $FILE_COUNT 个文件${NC}"

# 显示部署总结
echo -e "\n${GREEN}=== 部署总结 ===${NC}"
echo -e "项目：$PROJECT_NAME"
echo -e "生产环境：$SKILL_DIR"
echo -e "部署文件数：$FILE_COUNT"
echo -e "Git提交ID：$(git rev-parse --short HEAD)"
echo -e "提交信息：$(git log -1 --pretty=format:%s)"
echo -e "时间：$(date '+%Y-%m-%d %H:%M:%S')"

if [ -n "$BACKUP_DIR" ]; then
    echo -e "备份目录：$BACKUP_DIR"
fi

echo -e "\n${GREEN}✅ 自动化部署流程完成！${NC}"
echo -e "\n${YELLOW}提示：如需恢复备份，运行：${NC}"
echo -e "${YELLOW}  rm -rf $SKILL_DIR && mv $BACKUP_DIR $SKILL_DIR${NC}"
