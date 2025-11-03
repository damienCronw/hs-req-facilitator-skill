# 🚀 开始使用 - Claude Code Skill 自动化系统

> 你的自动化系统已经完全配置好！只需3步即可开始使用。

---

## ⚡ 快速开始（3步）

### 第1步：编辑文档

```bash
# 使用任意编辑器修改SKILL.md或README.md
vim SKILL.md
```

### 第2步：部署更改

```bash
/deploy
# 或
./auto-deploy.sh
```

### 第3步：查看结果

```bash
git log --oneline -1
```

**就是这样！** 🎉 整个流程都是自动的！

---

## 🎯 核心命令

| 命令 | 功能 | 场景 |
|------|------|------|
| **`/deploy`** | 自动部署到生产环境 | 日常开发 |
| **`/test`** | 运行25项测试 | 验证质量 |
| **`/watch`** | 启动监控模式 | 长时间编辑 |

---

## 📖 需要帮助？

```bash
# 查看使用演示
cat DEMO.md

# 查看快速参考
cat QUICK-REFERENCE.md

# 查看完整文档
cat AUTOMATION.md
```

---

## ✅ 系统状态

- ✅ 自动化脚本：5个
- ✅ Git Hooks：2个（Pre/Post commit）
- ✅ 生产环境：已部署
- ✅ 测试状态：25/25 通过
- ✅ AskUserQuestion格式：正确

---

## 🎓 典型使用场景

### 场景1：更新SKILL.md

```bash
vim SKILL.md
/deploy "docs: 更新Stage 3描述"
```

### 场景2：批量更新

```bash
vim SKILL.md README.md STAGE3-DEBUG.md
/deploy "docs: 批量更新"
```

### 场景3：监控模式开发

```bash
/watch 5  # 启动5秒间隔监控
# 编辑文件会自动部署
# 按 Ctrl+C 停止
```

---

## 🔍 故障排除

### Q: AskUserQuestion格式错误？

```bash
# 确保格式正确：
AskUserQuestion({
  questions: [{
    header: "问题",
    question: "内容",
    options: [{label: "选项", description: "描述"}],
    multiSelect: false
  }]
})
```

### Q: 部署失败？

```bash
# 检查权限
chmod -R 755 ~/.claude/skills/hs-req-facilitator-skill

# 重新部署
/deploy
```

### Q: 测试失败？

```bash
# 查看详细测试
./test-production.sh verbose

# 手动验证文件
ls -la ~/.claude/skills/hs-req-facilitator-skill/
```

---

## 📊 项目信息

- **版本**：v2.0.0
- **状态**：✅ 生产就绪
- **最后更新**：2025-11-04
- **文档位置**：
  - `DEMO.md` - 演示和示例
  - `AUTOMATION.md` - 完整指南
  - `QUICK-REFERENCE.md` - 快速参考

---

## 🎉 现在就开始！

```bash
# 编辑你的第一个文件
vim SKILL.md

# 部署更改
/deploy

# 查看部署结果
git log --oneline -1
```

**祝你使用愉快！** 🚀

---

*Generated with Claude Code*
