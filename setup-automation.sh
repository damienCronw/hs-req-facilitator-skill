#!/bin/bash

# Claude Code Skill 自动化配置初始化脚本
# 一键设置完整的自动化部署环境

set -e

# 颜色
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

echo -e "${CYAN}╔══════════════════════════════════════════════════════════╗${NC}"
echo -e "${CYAN}║        Claude Code Skill 自动化环境初始化向导           ║${NC}"
echo -e "${CYAN}╚══════════════════════════════════════════════════════════╝${NC}\n"

# 检查是否在正确的项目目录
if [ ! -f "SKILL.md" ]; then
    echo -e "${RED}❌ 错误：未找到SKILL.md文件${NC}"
    echo -e "${YELLOW}请在项目根目录运行此脚本${NC}\n"
    exit 1
fi

echo -e "${BLUE}项目目录：$(pwd)${NC}\n"

# 步骤1：检查Git状态
echo -e "${CYAN}━━━ 步骤 1/6: 检查Git环境 ━━━${NC}\n"

if [ ! -d ".git" ]; then
    echo -e "${YELLOW}⚠️  未发现Git仓库，正在初始化...${NC}"
    git init
    echo -e "${GREEN}✅ Git仓库初始化完成${NC}"
else
    echo -e "${GREEN}✅ Git仓库已存在${NC}"
fi

# 检查Git用户配置
if ! git config user.name > /dev/null 2>&1; then
    echo -e "\n${YELLOW}⚠️  Git用户信息未配置${NC}"
    echo "请输入您的姓名："
    read -r GIT_USER_NAME
    git config user.name "$GIT_USER_NAME"
fi

if ! git config user.email > /dev/null 2>&1; then
    echo "请输入您的邮箱："
    read -r GIT_USER_EMAIL
    git config user.email "$GIT_USER_EMAIL"
fi

echo -e "${GREEN}✅ Git配置完成${NC}"

# 步骤2：设置脚本权限
echo -e "\n${CYAN}━━━ 步骤 2/6: 设置脚本权限 ━━━${NC}\n"

SCRIPTS=("auto-deploy.sh" "test-production.sh" "watch-and-deploy.sh")
for script in "${SCRIPTS[@]}"; do
    if [ -f "$script" ]; then
        chmod +x "$script"
        echo -e "  ${GREEN}✅ $script${NC}"
    else
        echo -e "  ${YELLOW}⚠️  $script 不存在${NC}"
    fi
done

# 设置Git hooks权限
if [ -f ".git/hooks/pre-commit" ]; then
    chmod +x .git/hooks/pre-commit
    echo -e "  ${GREEN}✅ pre-commit hook${NC}"
fi

if [ -f ".git/hooks/post-commit" ]; then
    chmod +x .git/hooks/post-commit
    echo -e "  ${GREEN}✅ post-commit hook${NC}"
fi

# 步骤3：创建必要的目录
echo -e "\n${CYAN}━━━ 步骤 3/6: 创建配置目录 ━━━${NC}\n"

mkdir -p .claude/commands .claude/logs
echo -e "  ${GREEN}✅ .claude/commands${NC}"
echo -e "  ${GREEN}✅ .claude/logs${NC}"

# 步骤4：生成初始Git提交
echo -e "\n${CYAN}━━━ 步骤 4/6: 初始化Git仓库 ━━━${NC}\n"

if [ -z "$(git status --porcelain)" ]; then
    echo -e "${YELLOW}工作区干净，创建初始提交...${NC}"

    # 添加.gitignore
    cat > .gitignore << 'EOF'
# 敏感信息
.env
.env.*
*.pem
*.key

# 依赖和构建
node_modules/
dist/
build/

# IDE
.vscode/
.idea/
*.swp
*.swo

# 临时文件
*.log
*.tmp
.DS_Store
Thumbs.db

# 自动化日志
.claude/logs/*.log
watch-deploy.log

# 备份目录
*-backup-*
EOF

    git add .
    git commit -m "feat: 初始化Claude Code Skill项目自动化环境

- 添加自动化部署脚本
- 配置Git hooks
- 设置生产环境测试
- 启用文件监控模式
- 配置AskUserQuestion自动验证

🤖 Generated with Claude Code"

    echo -e "${GREEN}✅ 初始提交完成${NC}"
else
    echo -e "${YELLOW}工作区有未提交的变更${NC}"
    echo "是否现在提交？(y/N)"
    read -r COMMIT_CHOICE
    if [[ "$COMMIT_CHOICE" =~ ^[Yy]$ ]]; then
        git add .
        git commit -m "chore: 初始化自动化环境"
        echo -e "${GREEN}✅ 提交完成${NC}"
    fi
fi

# 步骤5：测试自动化脚本
echo -e "\n${CYAN}━━━ 步骤 5/6: 验证脚本功能 ━━━${NC}\n"

echo -e "${YELLOW}正在运行快速功能测试...${NC}\n"

# 测试auto-deploy.sh语法
if bash -n auto-deploy.sh; then
    echo -e "  ${GREEN}✅ auto-deploy.sh 语法检查通过${NC}"
else
    echo -e "  ${RED}❌ auto-deploy.sh 语法错误${NC}"
fi

# 测试test-production.sh语法
if bash -n test-production.sh; then
    echo -e "  ${GREEN}✅ test-production.sh 语法检查通过${NC}"
else
    echo -e "  ${RED}❌ test-production.sh 语法错误${NC}"
fi

# 检查配置文件
CONFIG_FILES=(".claude-config.json" ".claude/settings.json" ".claude/commands/deploy.json")
for file in "${CONFIG_FILES[@]}"; do
    if [ -f "$file" ]; then
        echo -e "  ${GREEN}✅ $file${NC}"
    else
        echo -e "  ${YELLOW}⚠️  $file 不存在${NC}"
    fi
done

# 步骤6：显示使用说明
echo -e "\n${CYAN}━━━ 步骤 6/6: 显示使用说明 ━━━${NC}\n"

cat << 'EOF'

╔══════════════════════════════════════════════════════════╗
║                    🎉 初始化完成！                       ║
╠══════════════════════════════════════════════════════════╣
║                                                          ║
║  📚 自动化文档:                                          ║
║     → AUTOMATION.md                                     ║
║                                                          ║
║  🚀 快速开始:                                            ║
║     ./auto-deploy.sh              # 手动部署             ║
║     /deploy                       # 使用Claude Code命令  ║
║                                                          ║
║  🧪 测试命令:                                            ║
║     ./test-production.sh          # 运行测试             ║
║     /test                         # 使用Claude Code命令  ║
║                                                          ║
║  👁️ 监控模式:                                            ║
║     ./watch-and-deploy.sh         # 启动监控             ║
║     /watch                        # 使用Claude Code命令  ║
║                                                          ║
║  ⚙️ 配置文件:                                            ║
║     → .claude-config.json         # 自动化配置           ║
║     → .claude/settings.json       # 项目设置             ║
║                                                          ║
╚══════════════════════════════════════════════════════════╝

EOF

# 创建快速参考卡片
cat > QUICK-REFERENCE.md << 'EOF'
# 快速参考卡

## 🚀 常用命令

| 操作 | 命令 | 说明 |
|------|------|------|
| 部署 | `/deploy` | 部署到生产环境 |
| 测试 | `/test` | 运行生产环境测试 |
| 监控 | `/watch` | 启动文件监控模式 |

## 📝 Git集成

Git hooks已启用：
- **Pre-commit**: 自动检查AskUserQuestion格式
- **Post-commit**: 询问是否自动部署

## 🔧 手动脚本

```bash
./auto-deploy.sh              # 自动部署
./auto-deploy.sh "提交信息"    # 自定义提交信息
./test-production.sh          # 完整测试
./test-production.sh quick    # 快速测试
./watch-and-deploy.sh         # 启动监控
./watch-and-deploy.sh 5       # 5秒间隔监控
```

## 📊 查看状态

```bash
git log --oneline -5          # 查看提交历史
ls -la ~/.claude/skills/      # 查看生产环境
```

## 🆘 故障排除

**部署失败？**
```bash
# 检查权限
ls -la ~/.claude/skills/hs-req-facilitator-skill
# 手动复制文件
cp *.md ~/.claude/skills/hs-req-facilitator-skill/
```

**测试失败？**
```bash
# 查看测试日志
cat test-results.log
# 重新运行测试
./test-production.sh verbose
```

**AskUserQuestion格式错误？**
```bash
# 检查格式
grep -A 10 "AskUserQuestion" SKILL.md
# 应该使用 questions: [...] 格式
```

EOF

echo -e "${GREEN}✅ 快速参考卡已生成: QUICK-REFERENCE.md${NC}"

echo -e "\n${GREEN}════════════════════════════════════════${NC}"
echo -e "${GREEN}   🎉 自动化环境配置完成！${NC}"
echo -e "${GREEN}════════════════════════════════════════${NC}\n"

echo -e "${YELLOW}提示：运行以下命令开始使用：${NC}"
echo -e "${CYAN}  1. 编辑文档: vim SKILL.md${NC}"
echo -e "${CYAN}  2. 自动部署: /deploy${NC}"
echo -e "${CYAN}  3. 查看日志: cat AUTOMATION.md${NC}\n"
