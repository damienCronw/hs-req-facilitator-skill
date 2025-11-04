# HS Req Facilitator Skill

**智能需求分析助手 | Intelligent Requirements Facilitator**

[![License](https://img.shields.io/badge/License-MIT-green)](LICENSE)
[![Version](https://img.shields.io/badge/Version-v2.0.2-orange)](CHANGELOG.md)

---

## 📦 简介

智能需求分析助手，通过AI分析和交互式澄清完善需求文档。

**特性**:
- 🤖 完全AI驱动
- 🔍 代码+文档联合分析
- ❓ 强制交互澄清
- 📊 智能需求分析
- 💬 代码注释分析
- 🏷️ 需求自动分类

---

## 🚀 快速开始

### 3步开始

1. **激活技能**
   ```bash
   激活技能：hs-req-facilitator-skill
   ```

2. **查看扫描结果**
   - 技能会自动扫描项目文件
   - 根据结果决定后续流程

3. **完成交互澄清**
   - Stage 2 分析完成后进入 Stage 3
   - 使用 AskUserQuestion 工具进行交互
   - **必须等待用户回答后再继续**

### 特殊场景

**无需求文档的项目**:
1. 技能自动检测并询问是否创建
2. 提供详细创建指导

**多个需求文档的项目**:
1. 技能检测多个文档并询问是否合并
2. 用户同意后进入文档合并流程

---

## 🔄 工作流程

```
Stage 0: 强制检查点验证
    ↓
Stage 1: 代码和文档扫描（自动）
    ↓
Stage 2: 需求分析（4步骤）
    ├─ 步骤2.1: 读取需求文档和代码文件
    ├─ 步骤2.2: 理解项目功能
    ├─ 💬 代码注释分析（自动执行）
    └─ 步骤2.3: 分析问题和缺失信息
        └─ 步骤2.4: 列出功能需求清单
    ↓
Stage 3: 交互澄清（强制）
    ↓
Stage 4: 需求增强
    ├─ 🏷️ 需求自动分类（可选）
    └─ 👤 用户画像分析（可选）
    ↓
Stage 5: 需求文档合并（可选）
```

**⚠️ Stage 3 是强制阶段** - 不能跳过！必须使用 AskUserQuestion 工具与用户交互。

---

## 📚 核心文档

- **[SKILL.md](SKILL.md)** - 主技能包文档，完整的工作流程定义（**必需阅读**）
- **[STAGE3-DEBUG.md](STAGE3-DEBUG.md)** - Stage 3 交互澄清调试指南

---

## ⚠️ 重要注意事项

### Stage 3 是强制阶段

- ✅ **必须执行** - Stage 3 不能跳过
- ✅ **必须交互** - 必须使用 AskUserQuestion 工具
- ✅ **必须等待** - 必须等待用户回答后再继续

### Stage 2 顺序要求

Stage 2 的 4 个子步骤必须按顺序执行：

1. 步骤2.1：读取需求文档和代码文件
2. 步骤2.2：理解项目功能（输出功能概述）
3. 步骤2.3：分析问题和缺失信息
4. 步骤2.4：列出功能需求清单

### AskUserQuestion 格式要求

```javascript
AskUserQuestion({
  questions: [{
    header: "标题（≤12字符）",
    question: "具体问题",
    options: [
      {label: "选项1", description: "描述1"},
      {label: "选项2", description: "描述2"}
    ],
    multiSelect: false
  }]
})
```

---

## 🛠️ 故障排除

### 常见问题

#### Stage 3 没有出现

**解决方案**：
1. 检查是否在 Claude Code 环境
2. 参考 [STAGE3-DEBUG.md](STAGE3-DEBUG.md)

#### AskUserQuestion 工具不可用

**解决方案**：
- 确保在 Claude Code 环境中运行
- 参考 [STAGE3-DEBUG.md](STAGE3-DEBUG.md)

### 调试检查清单

- [ ] 确认在 Claude Code 环境中运行
- [ ] 确认 AskUserQuestion 工具可用性
- [ ] Stage 2 的 4 个子步骤全部完成
- [ ] Stage 3 使用了正确的 AskUserQuestion 格式
- [ ] 等待用户回答后再继续

---

## 📄 许可证

本技能包采用 MIT 许可证。详见 [LICENSE](LICENSE) 文件。

---

## 💬 支持与反馈

- **问题反馈**: [GitHub Issues](https://github.com/damienCronw/hs-req-facilitator-skill/issues)
- **贡献指南**: [CONTRIBUTING.md](CONTRIBUTING.md)
- **故障排查**: [TROUBLESHOOTING.md](TROUBLESHOOTING.md)

---

## 📝 更新日志

| 版本 | 日期 | 更新内容 |
|------|------|---------|
| v2.0.0 | 2025-11-04 | 添加工作流程图，修正 AskUserQuestion 调用格式，完善 Stage 3 强制检查 |
| v1.0.0 | 2025-11-02 | 初始版本，配置驱动实现 |
