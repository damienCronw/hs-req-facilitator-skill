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

### 使用前检查

- ✅ Claude Code 已安装并配置
- ✅ 技能文件（SKILL.md）完整存在
- ✅ 项目中有可读的需求文档
- ✅ 有读取和写入权限

### 3步开始

1. **激活技能**
   在 Claude Code 中激活技能，使用关键词如：
   - "分析需求文档"
   - "澄清需求"
   - "完善需求"

2. **查看扫描结果**
   - 技能会自动扫描项目中的需求文档和代码文件
   - 根据扫描结果决定后续流程

3. **完成交互澄清**
   - Stage 2 分析完成后进入 Stage 3
   - **Stage 3 是强制阶段，不能跳过**
   - 使用 AskUserQuestion 工具进行交互澄清
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
- **[TROUBLESHOOTING.md](TROUBLESHOOTING.md)** - 故障排查指南

---

## ⚠️ 重要注意事项

### Stage 3 是强制阶段

- ✅ **必须执行** - Stage 3 不能跳过
- ✅ **必须在Stage 2完成后才能进入此阶段**
- ✅ **不能在Stage 2之后直接进入Stage 4**
- ✅ **必须使用 AskUserQuestion 工具与用户交互**
- ✅ **必须至少进行一次 AskUserQuestion 交互**
- ✅ **必须等待用户回答后再继续**

### Stage 2 顺序要求

Stage 2 的 4 个子步骤必须按顺序执行：

1. **步骤2.1**：读取需求文档和代码文件
2. **步骤2.2**：理解项目功能（必须输出功能概述）
3. **步骤2.3**：分析问题和缺失信息（模糊点、缺失信息、不一致性）
4. **步骤2.4**：列出功能需求清单（完整清单并展示给用户）

**⚠️ 每步必须有实际输出**：不能只是说"已完成"，必须输出具体分析结果。

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

#### Stage 3 交互未出现

**症状**：跳过交互澄清，直接进入 Stage 4

**解决方案**：
1. 确认已完成 Stage 2 的所有4个子步骤
2. 检查 AskUserQuestion 工具是否可用
3. 查看是否有错误消息

#### 文件扫描失败

**症状**：提示"未找到需求文档"

**解决方案**：
1. 确认文档格式为 `.md`
2. 检查文档命名：`requirements.md`、`*requirement*.md` 或 `.spec-workflow/specs/*/requirements.md`
3. 确认文件有读取权限

#### 生成文档失败

**症状**：技能运行但未生成改进文档

**解决方案**：
1. 检查工作目录写入权限
2. 确认 Stage 3 交互已正常完成
3. 查看错误日志

#### 分析结果不准确

**症状**：分析模糊或不完整

**解决方案**：
1. 在 Stage 3 中积极回答澄清问题
2. 提供更多上下文信息
3. 检查需求文档格式是否清晰

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

### 🐛 问题反馈

在 [GitHub Issues](https://github.com/damienCronw/hs-req-facilitator-skill/issues) 提交问题时，请提供：

1. **环境信息**：Claude Code 版本、操作系统
2. **问题描述**：详细说明问题现象
3. **重现步骤**：如何触发问题
4. **错误日志**：完整的错误信息

### 📖 相关文档

- **[SKILL.md](SKILL.md)** - 主技能包文档（必需阅读）
- **[TROUBLESHOOTING.md](TROUBLESHOOTING.md)** - 故障排查指南
- **[CONTRIBUTING.md](CONTRIBUTING.md)** - 贡献指南
- **[SETUP.md](SETUP.md)** - 安装指南

---

## 📝 更新日志

| 版本 | 日期 | 更新内容 |
|------|------|---------|
| v2.0.0 | 2025-11-04 | 添加工作流程图，修正 AskUserQuestion 调用格式，完善 Stage 3 强制检查 |
| v1.0.0 | 2025-11-02 | 初始版本，配置驱动实现 |
