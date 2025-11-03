#!/bin/bash

# Claude Code Pre-Commit 检查脚本
# 验证项目配置和代码质量

set -e

SCRIPT_DIR="$(git rev-parse --show-toplevel)"
SKILL_FILE="$SCRIPT_DIR/SKILL.md"

# 颜色
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

echo -e "\n${BLUE}=== Claude Code Pre-Commit 检查 ===${NC}\n"

ERRORS=0
WARNINGS=0

# 1. 检查Claude Code配置
echo -e "${CYAN}[1/6] 检查Claude Code配置...${NC}"

if [ ! -d "$SCRIPT_DIR/.claude" ]; then
    echo -e "  ${RED}❌ 错误：.claude目录不存在${NC}"
    ERRORS=$((ERRORS + 1))
else
    echo -e "  ${GREEN}✅ .claude目录存在${NC}"
fi

if [ ! -f "$SCRIPT_DIR/.claude/config.json" ]; then
    echo -e "  ${RED}❌ 错误：.claude/config.json不存在${NC}"
    ERRORS=$((ERRORS + 1))
else
    echo -e "  ${GREEN}✅ config.json存在${NC}"
fi

if [ ! -f "$SCRIPT_DIR/CLAUDE.md" ]; then
    echo -e "  ${YELLOW}⚠️  警告：CLAUDE.md不存在（建议添加）${NC}"
    WARNINGS=$((WARNINGS + 1))
else
    echo -e "  ${GREEN}✅ CLAUDE.md存在${NC}"
fi

# 2. 检查JSON配置格式
echo -e "\n${CYAN}[2/6] 验证JSON配置格式...${NC}"

if command -v jq >/dev/null 2>&1; then
    if [ -f "$SCRIPT_DIR/.claude/config.json" ]; then
        if jq empty "$SCRIPT_DIR/.claude/config.json" 2>/dev/null; then
            echo -e "  ${GREEN}✅ config.json格式正确${NC}"
        else
            echo -e "  ${RED}❌ 错误：config.json格式无效${NC}"
            ERRORS=$((ERRORS + 1))
        fi
    fi

    if [ -f "$SCRIPT_DIR/.claude/settings.json" ]; then
        if jq empty "$SCRIPT_DIR/.claude/settings.json" 2>/dev/null; then
            echo -e "  ${GREEN}✅ settings.json格式正确${NC}"
        else
            echo -e "  ${RED}❌ 错误：settings.json格式无效${NC}"
            ERRORS=$((ERRORS + 1))
        fi
    fi
else
    echo -e "  ${YELLOW}⚠️  警告：jq未安装，跳过JSON验证${NC}"
    WARNINGS=$((WARNINGS + 1))
fi

# 3. 检查SKILL.md和AskUserQuestion格式
echo -e "\n${CYAN}[3/6] 检查SKILL.md和AskUserQuestion格式...${NC}"

if [ ! -f "$SKILL_FILE" ]; then
    echo -e "  ${RED}❌ 错误：SKILL.md不存在${NC}"
    ERRORS=$((ERRORS + 1))
else
    echo -e "  ${GREEN}✅ SKILL.md存在${NC}"

    # 检查AskUserQuestion调用
    if grep -q "AskUserQuestion({" "$SKILL_FILE"; then
        echo -e "  ${GREEN}✅ 发现AskUserQuestion调用${NC}"

        # 检查格式 - 查找包含 questions: 的 AskUserQuestion 调用
        if grep -B 2 "questions:" "$SKILL_FILE" | grep -q "AskUserQuestion"; then
            echo -e "  ${GREEN}✅ AskUserQuestion使用正确格式（questions数组）${NC}"
        else
            echo -e "  ${RED}❌ 错误：AskUserQuestion格式可能不正确${NC}"
            echo -e "  ${YELLOW}💡 应使用：questions: [...] 而不是 question: ...${NC}"
            ERRORS=$((ERRORS + 1))
        fi

        # 检查是否缺少header（在questions数组内的对象中）
        if grep -A 5 "questions: \[" "$SKILL_FILE" | grep -q "header:"; then
            echo -e "  ${GREEN}✅ header字段存在${NC}"
        else
            echo -e "  ${YELLOW}⚠️  警告：AskUserQuestion可能缺少header字段${NC}"
            WARNINGS=$((WARNINGS + 1))
        fi
    else
        echo -e "  ${YELLOW}⚠️  警告：未找到AskUserQuestion调用${NC}"
        WARNINGS=$((WARNINGS + 1))
    fi
fi

# 4. 检查Markdown格式
echo -e "\n${CYAN}[4/6] 检查Markdown格式...${NC}"

if [ -f "$SKILL_FILE" ]; then
    # 检查主标题
    if grep -q "^# " "$SKILL_FILE"; then
        echo -e "  ${GREEN}✅ 主标题存在${NC}"
    else
        echo -e "  ${RED}❌ 错误：缺少主标题${NC}"
        ERRORS=$((ERRORS + 1))
    fi

    # 检查工作流程描述
    if grep -q -i "workflow\|工作流程\|stage.*[0-9]" "$SKILL_FILE"; then
        echo -e "  ${GREEN}✅ 包含工作流程描述${NC}"
    else
        echo -e "  ${YELLOW}⚠️  警告：未找到工作流程描述${NC}"
        WARNINGS=$((WARNINGS + 1))
    fi
fi

# 5. 检查文件大小
echo -e "\n${CYAN}[5/6] 检查文件大小...${NC}"

if [ -f "$SKILL_FILE" ]; then
    SKILL_SIZE=$(wc -c < "$SKILL_FILE")
    if [ $SKILL_SIZE -gt 10000 ]; then
        echo -e "  ${GREEN}✅ SKILL.md大小正常 (${SKILL_SIZE} 字节)${NC}"
    else
        echo -e "  ${YELLOW}⚠️  警告：SKILL.md可能过小 (${SKILL_SIZE} 字节)${NC}"
        WARNINGS=$((WARNINGS + 1))
    fi
fi

if [ -f "$SCRIPT_DIR/README.md" ]; then
    README_SIZE=$(wc -c < "$SCRIPT_DIR/README.md")
    if [ $README_SIZE -gt 5000 ]; then
        echo -e "  ${GREEN}✅ README.md大小正常 (${README_SIZE} 字节)${NC}"
    else
        echo -e "  ${YELLOW}⚠️  警告：README.md可能过小 (${README_SIZE} 字节)${NC}"
        WARNINGS=$((WARNINGS + 1))
    fi
fi

# 6. 检查必需脚本
echo -e "\n${CYAN}[6/6] 检查自动化脚本...${NC}"

REQUIRED_SCRIPTS=("scripts/auto-deploy.sh" "scripts/test-production.sh")
for script in "${REQUIRED_SCRIPTS[@]}"; do
    if [ -f "$SCRIPT_DIR/$script" ]; then
        echo -e "  ${GREEN}✅ $script存在${NC}"
    else
        echo -e "  ${RED}❌ 错误：$script不存在${NC}"
        ERRORS=$((ERRORS + 1))
    fi
done

# 总结
echo -e "\n${BLUE}=== Pre-Commit检查总结 ===${NC}"
echo -e "错误：$ERRORS"
echo -e "警告：$WARNINGS"

if [ $ERRORS -eq 0 ]; then
    echo -e "\n${GREEN}✅ 所有检查通过，可以提交${NC}"
    echo -e "${YELLOW}提示：提交后将自动部署到生产环境${NC}\n"
    exit 0
else
    echo -e "\n${RED}❌ 发现 $ERRORS 个错误，请修复后再提交${NC}\n"
    exit 1
fi
