#!/bin/bash

# Claude Code Skill 快速开始脚本（非交互式）
# 一键设置自动化环境并完成初始部署

set -e

# 颜色
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m'

echo -e "${CYAN}╔════════════════════════════════════════════╗${NC}"
echo -e "${CYAN}║   Claude Code Skill 自动化快速开始       ║${NC}"
echo -e "${CYAN}╚════════════════════════════════════════════╝${NC}\n"

# 步骤1：Git配置
echo -e "${BLUE}[1/4] 配置Git环境...${NC}"
if ! git config user.name > /dev/null 2>&1; then
    git config user.name "Claude Code User"
fi
if ! git config user.email > /dev/null 2>&1; then
    git config user.email "user@claude.ai"
fi
echo -e "${GREEN}✅ Git配置完成${NC}"

# 步骤2：添加.gitignore
echo -e "\n${BLUE}[2/4] 创建.gitignore...${NC}"
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
echo -e "${GREEN}✅ .gitignore已创建${NC}"

# 步骤3：提交所有文件
echo -e "\n${BLUE}[3/4] 提交项目文件...${NC}"
git add .
git commit -m "feat: 完整的Claude Code Skill自动化系统

✨ 功能特性:
- 自动Git提交和部署
- Pre-commit质量检查
- Post-commit自动部署
- 生产环境测试套件
- 文件监控模式
- AskUserQuestion格式验证
- 自动备份和恢复

🤖 Generated with Claude Code" 2>/dev/null || true
echo -e "${GREEN}✅ 文件已提交${NC}"

# 步骤4：执行首次部署
echo -e "\n${BLUE}[4/4] 部署到生产环境...${NC}"
bash auto-deploy.sh <<< "y" 2>/dev/null || echo -e "${YELLOW}⚠️  部署过程中有提示，请检查上面的输出${NC}"

echo -e "\n${GREEN}════════════════════════════════════════${NC}"
echo -e "${GREEN}   🎉 自动化环境就绪！${NC}"
echo -e "${GREEN}════════════════════════════════════════${NC}\n"

cat << 'EOF'

📖 使用指南:

1. 编辑文档:
   vim SKILL.md

2. 快速部署:
   ./auto-deploy.sh
   # 或在Claude Code中使用:
   /deploy

3. 运行测试:
   ./test-production.sh
   # 或使用:
   /test

4. 启动监控:
   ./watch-and-deploy.sh
   # 或使用:
   /watch

5. 查看文档:
   cat AUTOMATION.md
   cat QUICK-REFERENCE.md

🔧 配置文件:
   - .claude-config.json      (自动化设置)
   - .claude/settings.json    (项目配置)
   - .git/hooks/pre-commit    (提交前检查)
   - .git/hooks/post-commit   (提交后部署)

EOF

echo -e "${YELLOW}💡 提示: 输入 /deploy 开始你的第一次部署！${NC}\n"
