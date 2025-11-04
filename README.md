<div align="center">

# HS Req Facilitator Skill

**智能需求分析助手 | Intelligent Requirements Facilitator**

[![GitHub](https://img.shields.io/badge/GitHub-Repository-blue)](https://github.com/damienCronw/hs-req-facilitator-skill)
[![Email](https://img.shields.io/badge/Email-limian@norkern.com-red)](mailto:limian@norkern.com)
[![Website](https://img.shields.io/badge/Website-www.norker.com-blue)](https://www.norker.com)
[![License](https://img.shields.io/badge/License-MIT-green)](LICENSE)
[![Version](https://img.shields.io/badge/Version-v2.0.2-orange)](CHANGELOG.md)

**由 [苏州核朔智能科技有限公司](https://www.norker.com) 开源贡献**

---

</div>

> **智能需求分析助手，通过AI分析和交互式澄清完善需求文档**
>
> 🤖 **完全AI驱动** | 🔍 **代码+文档联合分析** | ❓ **强制交互澄清** | 📊 **智能需求分析** | 💬 **代码注释分析** | 🏷️ **需求自动分类** | 👤 **用户画像分析**
>
> 🎯 **企业级AI解决方案** | 💼 **商业支持可用** | 📧 联系: limian@norkern.com

---

## 🚨 重要声明 - 配置驱动实现

**⚠️ 关键说明：本技能包是纯配置驱动实现！**

- ✅ **SKILL.md 是唯一的实现方式** - 所有功能都在 SKILL.md 中定义
- ✅ **无 TypeScript 代码文件** - 这不是一个代码项目，而是配置驱动的技能包
- ✅ **无遗留代码** - 从创建之初就是配置驱动的，不存在"转换为配置"的过程
- ✅ **即开即用** - 只需要 SKILL.md 即可工作

**请勿寻找不存在的代码文件** - 所有实现都在 SKILL.md 中！

---

## 📋 目录

- [功能特性](#-功能特性)
- [工作流程](#-工作流程)
- [快速开始](#-快速开始)
- [用法说明](#-用法说明)
- [文档导航](#-文档导航)
- [故障排除](#-故障排除)
- [重要注意事项](#-重要注意事项)

---

## ✨ 功能特性

### 基础工作流（5个Stage）

- **Stage 0**: 强制工作流检查
- **Stage 1**: 代码和文档扫描（自动）
- **Stage 2**: 需求分析（4步骤流程）
- **Stage 3**: 交互澄清（**强制阶段**）
- **Stage 4**: 需求增强
- **Stage 5**: 需求文档合并（可选）

### 扩展功能（自动执行）

- 💬 **代码注释分析**（扩展2.2.1）
  - **执行时机**: Stage 2.2完成后自动执行
  - **功能**: 扫描代码注释中的TODO、FIXME、业务逻辑，提取隐含需求
  - **支持语言**: TypeScript、JavaScript、Python、Java、Go、Rust、C++、C#
  - **输出**: 隐含需求清单，包含优先级和实现状态

- 🏷️ **需求自动分类**（扩展4.1）
  - **执行时机**: Stage 4中可选执行
  - **功能**: 智能分类需求类型、评估优先级、识别依赖、生成标签
  - **算法**: 多维度优先级评估（P0-P3）
  - **输出**: 分类结果、结构化标签、依赖关系图

- 👤 **用户画像分析**（Stage 8）
  - **执行时机**: Stage 4完成后可选执行，或独立使用
  - **功能**: 提取用户角色、特征、场景、目标和痛点
  - **分析维度**: 人口统计、行为特征、使用场景
  - **输出**: 结构化用户画像，可视化用户旅程

### 核心能力

- 🔍 自动扫描项目文件（需求文档 + 代码文件）
- 📊 智能需求分析（4个子步骤严格顺序执行）
- ❓ **强制交互澄清**（使用 AskUserQuestion 工具）
- 📝 自动生成功能需求清单
- 🔄 支持多文档合并
- 🚀 专为空白项目提供引导

---

## 🔄 工作流程

### 完整工作流（含扩展功能）

```
Stage 0: 强制检查点验证
    ↓
Stage 1: 代码和文档扫描（自动）
    ↓
Stage 2: 需求分析（4步骤）
    ├─ 步骤2.1: 读取需求文档和代码文件
    ├─ 步骤2.2: 理解项目功能
    ├─ 💬 扩展2.2.1: 代码注释分析（自动执行）
    └─ 步骤2.3: 分析问题和缺失信息
        └─ 步骤2.4: 列出功能需求清单
    ↓
Stage 3: 交互澄清（强制）
    ↓
Stage 4: 需求增强
    ├─ 🏷️ 扩展4.1: 需求自动分类（可选）
    └─ 👤 Stage 8: 用户画像分析（可选）
    ↓
Stage 5: 需求文档合并（可选）
```

**⚠️ Stage 3 是强制阶段** - 绝对不能跳过！必须使用 AskUserQuestion 工具与用户交互。

**📝 扩展功能说明**:
- 💬 **代码注释分析**：Stage 2.2完成后自动执行，无需手动触发
- 🏷️ **需求自动分类**：Stage 4中可选执行，通常自动执行
- 👤 **用户画像分析**：Stage 4后可选执行，可独立使用

### 工作流程图

完整的工作流程图请参阅：[SKILL.md](#skillmd-内容概览)

---

## 🚀 快速开始

### 3步开始使用

1. **激活技能**
   - 在 Claude Code 中激活 `hs-req-facilitator-skill`
   - 技能会自动开始执行

2. **查看 Stage 1 扫描结果**
   - 技能会立即扫描项目文件
   - 根据结果决定后续流程

3. **等待 Stage 3 交互**
   - Stage 2 分析完成后必须进入 Stage 3
   - 使用 AskUserQuestion 工具进行交互澄清
   - **必须等待用户回答后再继续**

### 无需求文档的项目

如果项目没有需求文档：
1. 技能会自动检测
2. 使用 AskUserQuestion 询问是否创建需求文档
3. 提供详细的创建指导

### 有多个需求文档的项目

如果项目有多个需求文档：
1. 技能会检测到多个文档
2. 使用 AskUserQuestion 询问是否合并
3. 用户同意后进入 Stage 5（文档合并）

---

## 📖 用法说明

### 激活技能

在 Claude Code 中：
```
激活技能：hs-req-facilitator-skill
```

### 预期执行过程

#### Stage 1：自动扫描（立即执行）

技能激活后会立即执行以下扫描：

```bash
# 扫描需求文档
find . -type f \( -name "requirements.md" -o -name "*requirement*.md" -o -name "需求*.md" \)

# 扫描代码文件
find . -type f \( -name "*.ts" -o -name "*.js" -o -name "*.py" -o -name "*.java" \)
```

#### Stage 2：需求分析（4步骤）

按照严格顺序执行：

1. **读取需求文档和代码文件**（实际读取内容，不只是列出文件名）
2. **理解项目功能**（必须输出功能概述）
3. **分析问题和缺失信息**（识别模糊点、缺失信息、不一致性）
4. **列出功能需求清单**（完整清单并展示给用户）

#### Stage 3：交互澄清（强制）

**关键要求**：
- Stage 2 完成后必须立即进入 Stage 3
- 不能跳过！
- 必须与用户交互

**Claude Code 环境**：
```javascript
AskUserQuestion({
  questions: [{
    header: "需求澄清",
    question: "具体问题...",
    options: [
      {label: "选项1", description: "描述1"},
      {label: "选项2", description: "描述2"}
    ],
    multiSelect: false
  }]
})
```

**Cursor 环境**：
```
❓ 问题：[问题内容]

基于分析，我发现以下需要澄清的问题：
...

请在聊天中回答，等待您回答后再继续。
```

---

## 📚 文档导航

### 核心文档

- **[SKILL.md](SKILL.md)** 📖
  - **主技能包文档**
  - 完整的工作流程定义
  - 所有 5 个阶段的详细说明
  - AskUserQuestion 工具调用示例
  - **必需阅读！**

- **[STAGE3-DEBUG.md](STAGE3-DEBUG.md)** 🔧
  - Stage 3 交互澄清调试指南
  - 常见问题及解决方案
  - AskUserQuestion 格式要求
  - 环境兼容性指南
  - 故障排除检查清单

### 专用指南（规划中）

以下指南文件在某些版本中可能不存在，但会在未来版本中提供：

### 专用指南（规划中）

以下指南文件在某些版本中可能不存在，但会在未来版本中提供：

- **[ANALYZER.md](ANALYZER.md)** - 需求分析详细指南
- **[QUESTIONS.md](QUESTIONS.md)** - 问题生成与设计指南
- **[ENHANCER.md](ENHANCER.md)** - 需求增强指南
- **[MERGER.md](MERGER.md)** - 多文档合并指南
- **[EMPTY-PROJECT.md](EMPTY-PROJECT.md)** - 空白项目引导指南
- **[SPEC-WORKFLOW-INTEGRATION.md](SPEC-WORKFLOW-INTEGRATION.md)** - Spec Workflow 集成指南

---

## 🛠️ 故障排除

### 常见问题

#### 1. Stage 3 没有出现

**症状**：
- Stage 2 分析后直接跳到 Stage 4
- 没有收到交互提示

**解决方案**：
1. 检查是否在Claude Code环境（仅此环境支持AskUserQuestion工具）
2. 参考 [STAGE3-DEBUG.md](STAGE3-DEBUG.md) 中的"问题 1: 交互没有出现"

#### 2. AskUserQuestion 工具不可用

**症状**：
- "AskUserQuestion tool not found" 错误
- 工具调用失败

**解决方案**：
- 确保在Claude Code环境中运行
- 确保AskUserQuestion工具可用
- 参考 [STAGE3-DEBUG.md](STAGE3-DEBUG.md) 中的"问题 2: AskUserQuestion 工具不可用"

#### 3. Stage 2 未完成

**症状**：
- 没有进入 Stage 3
- 流程检查失败

**解决方案**：
- 确保 Stage 2 的 4 个子步骤全部完成
- 验证每步都有实际输出（不只是"已完成"）
- 参考 [STAGE3-DEBUG.md](STAGE3-DEBUG.md) 中的"检查点 1: 验证 Stage 2 完成情况"

### 调试检查清单

在报告问题前，请检查：

- [ ] 确认在Claude Code环境中运行
- [ ] 确认 AskUserQuestion 工具可用性
- [ ] Stage 2 的 4 个子步骤全部完成
- [ ] Stage 3 使用了正确的 AskUserQuestion 格式
- [ ] 等待用户回答后再继续

**详细调试指南**：请参阅 [STAGE3-DEBUG.md](STAGE3-DEBUG.md)

---

## ⚠️ 重要注意事项

### Stage 3 是强制阶段

- ✅ **必须执行** - Stage 3 不能跳过
- ✅ **必须交互** - 必须使用 AskUserQuestion 工具或对话模式
- ✅ **必须等待** - 必须等待用户回答后再继续
- ✅ **环境要求** - 仅Claude Code环境支持

### Stage 2 顺序要求

Stage 2 的 4 个子步骤必须按顺序执行：

1. 步骤2.1：读取需求文档和代码文件
2. 步骤2.2：理解项目功能（输出功能概述）
3. 步骤2.3：分析问题和缺失信息（输出模糊点、缺失信息、不一致性）
4. 步骤2.4：列出功能需求清单（完整清单并展示）

### 环境兼容性

**Claude Code 环境**：
- ✅ 支持 AskUserQuestion 工具
- ✅ 同步工具调用
- ✅ 自动等待用户回答

**不支持Cursor环境**：
- ❌ 不支持 AskUserQuestion 工具
- ❌ 不支持对话交互模式
- ⚠️ 仅支持Claude Code环境

### AskUserQuestion 格式要求

```javascript
// ✅ 正确格式
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

**必需字段**：
- `questions` - 数组（不是单个对象）
- `header` - ≤ 12 字符
- `question` - 具体问题
- `options` - 2-4 个选项
- `multiSelect` - true/false

---

## 📞 获取帮助

### 问题反馈

在报告问题时，请提供：

1. **环境信息**
   - 运行环境（Claude Code / Cursor）
   - 技能包版本（v2.0.2）

2. **错误详情**
   - 完整的错误信息
   - 发生问题的阶段

3. **重现步骤**
   - 详细的操作步骤
   - 预期行为 vs 实际行为

### 相关文档

- **主文档**：[SKILL.md](SKILL.md)
- **调试指南**：[STAGE3-DEBUG.md](STAGE3-DEBUG.md)

---

## 📝 更新日志

| 版本 | 日期 | 更新内容 |
|------|------|---------|
| v2.0.0 | 2025-11-04 | 添加工作流程图，修正 AskUserQuestion 调用格式，完善 Stage 3 强制检查 |
| v1.0.0 | 2025-11-02 | 初始版本，配置驱动实现 |

---

## 📄 许可证

本技能包采用 MIT 许可证。详见 [LICENSE](LICENSE) 文件。

---

## 💬 支持与反馈

### 🐛 报告问题
- **[GitHub Issues](https://github.com/damienCronw/hs-req-facilitator-skill/issues)** - 提交Bug报告或功能请求
- 📧 **[limian@norkern.com](mailto:limian@norkern.com)** - 直接联系技术支持

### 💡 参与讨论
- **[GitHub Discussions](https://github.com/damienCronw/hs-req-facilitator-skill/discussions)** - 社区讨论和Q&A
- 🌐 **[www.norker.com](https://www.norker.com)** - 访问公司官网了解更多

### 🤝 贡献代码
- **[CONTRIBUTING.md](CONTRIBUTING.md)** - 查看贡献指南
- 欢迎提交 Pull Request 和 Issue

### 💼 企业服务咨询
- **定制开发**: 根据业务需求定制功能
- **私有化部署**: 支持内网环境部署
- **技术咨询**: AI驱动软件开发咨询服务
- 📧 **[limian@norkern.com](mailto:limian@norkern.com)** - 咨询商业合作

### 📖 相关文档
- [贡献指南](CONTRIBUTING.md)
- [故障排查](TROUBLESHOOTING.md)
- [安装指南](SETUP.md)

---

## 📌 重要提醒

**重要提醒**：

✅ 本技能包是纯配置驱动实现，所有功能在 SKILL.md 中
✅ Stage 3 是强制阶段，不能跳过
✅ AskUserQuestion 调用格式必须正确
✅ 必须等待用户回答后再继续

**快速链接**：
- [SKILL.md](SKILL.md) - 主技能包文档（必需阅读）
- [STAGE3-DEBUG.md](STAGE3-DEBUG.md) - 调试指南
- [工作流程图](#-工作流程) - 本 README 中的流程图
