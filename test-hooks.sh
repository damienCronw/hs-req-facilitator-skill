#!/bin/bash

echo "╔═══════════════════════════════════════════╗"
echo "║     Claude Code Hooks 配置测试            ║"
echo "╚═══════════════════════════════════════════╝"
echo ""

ERRORS=0

# 1. 检查配置文件
echo "[1/5] 检查配置文件..."
if [ -f "/Volumes/MacHD/hs-skills/hs-req-facilitator-skill/.claude/hooks.json" ]; then
    echo "  ✅ hooks.json 存在"
else
    echo "  ❌ hooks.json 不存在"
    ERRORS=$((ERRORS + 1))
fi

# 2. 验证JSON语法
echo "[2/5] 验证JSON语法..."
if command -v jq >/dev/null 2>&1; then
    if jq empty "/Volumes/MacHD/hs-skills/hs-req-facilitator-skill/.claude/hooks.json" 2>/dev/null; then
        echo "  ✅ JSON语法正确"
    else
        echo "  ❌ JSON语法错误"
        ERRORS=$((ERRORS + 1))
    fi
else
    echo "  ⚠️  jq未安装，跳过验证"
fi

# 3. 检查Hook定义
echo "[3/5] 检查Hook定义..."
HOOKS=("SessionStart" "PreToolUse" "PostToolUse" "Notification" "SessionEnd")
for hook in "${HOOKS[@]}"; do
    if grep -q "\"$hook\"" "/Volumes/MacHD/hs-skills/hs-req-facilitator-skill/.claude/hooks.json"; then
        echo "  ✅ $hook"
    else
        echo "  ❌ $hook 未定义"
        ERRORS=$((ERRORS + 1))
    fi
done

# 4. 检查日志目录
echo "[4/5] 检查日志目录..."
if [ -d "/Volumes/MacHD/hs-skills/hs-req-facilitator-skill/logs" ]; then
    echo "  ✅ logs目录存在"
else
    echo "  ⚠️  logs目录不存在，正在创建..."
    mkdir -p "/Volumes/MacHD/hs-skills/hs-req-facilitator-skill/logs"
fi

# 5. 检查脚本权限
echo "[5/5] 检查脚本权限..."
SCRIPTS=("scripts/pre-commit-check.sh" "scripts/auto-deploy.sh" "scripts/test-production.sh")
for script in "${SCRIPTS[@]}"; do
    if [ -f "/Volumes/MacHD/hs-skills/hs-req-facilitator-skill/$script" ]; then
        if [ -x "/Volumes/MacHD/hs-skills/hs-req-facilitator-skill/$script" ]; then
            echo "  ✅ $script (可执行)"
        else
            echo "  ⚠️  $script (无执行权限)"
            chmod +x "/Volumes/MacHD/hs-skills/hs-req-facilitator-skill/$script"
            echo "     已添加执行权限"
        fi
    fi
done

# 总结
echo ""
echo "═══════════════════════════════════════════"
if [ $ERRORS -eq 0 ]; then
    echo "  ✅ 所有检查通过！"
    echo ""
    echo "🚀 下一步："
    echo "  1. 重启Claude Code会话使Hooks生效"
    echo "  2. 编辑文件测试PreToolUse Hook"
    echo "  3. 运行 /deploy 测试PostToolUse Hook"
    echo "  4. 查看日志: cat logs/hooks.log"
else
    echo "  ❌ 发现 $ERRORS 个错误"
    echo "  请修复后再测试"
fi
echo "═══════════════════════════════════════════"
echo ""

# 显示配置文件摘要
if [ -f "/Volumes/MacHD/hs-skills/hs-req-facilitator-skill/.claude/hooks.json" ]; then
    echo "📋 配置文件摘要:"
    echo "  位置: /Volumes/MacHD/hs-skills/hs-req-facilitator-skill/.claude/hooks.json"
    echo "  Hooks: 5个 (SessionStart, PreToolUse, PostToolUse, Notification, SessionEnd)"
    echo "  日志: /Volumes/MacHD/hs-skills/hs-req-facilitator-skill/logs/hooks.log"
    echo ""
fi
