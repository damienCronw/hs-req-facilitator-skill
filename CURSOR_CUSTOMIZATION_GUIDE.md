# Cursor 中定制 hs-req-facilitator-skill 流程指南

## 📋 概述

`hs-req-facilitator-skill` 是一个 **Claude Code Skill**，它的流程和行为完全由配置文件定义。

### ⚠️ 重要说明：Cursor 和 Claude Code Skill 的关系

- **Cursor 本身不直接支持 skill 系统**
- **Cursor 集成了 Claude Code 扩展**（`anthropic.claude-code`）
- **技能包通过 Claude Code 系统管理**，存放在 `~/.claude/skills/` 或项目内的 `.claude/skills/` 目录
- **在 Cursor 中使用技能**，实际上是通过 Claude Code 扩展来调用的

因此，定制技能的方式与在 Claude Code 中相同，都是通过修改配置文件来实现。

---

## 🔍 技能包结构

技能包的核心文件位于：`.claude/skills/hs-req-facilitator-skill/`

```
.claude/skills/hs-req-facilitator-skill/
├── SKILL.md                           # ⭐ 主配置文件（定义整体流程）
├── ANALYZER.md                        # 需求分析指南
├── QUESTIONS.md                       # 问题生成指南
├── ENHANCER.md                        # 文档增强指南
├── MERGER.md                          # 文档合并指南
├── EMPTY-PROJECT.md                   # 空项目引导指南
└── SPEC-WORKFLOW-INTEGRATION.md      # spec-workflow集成指南
```

---

## 🎯 定制方式

### 方式1：修改主配置文件 `SKILL.md`（推荐）

`SKILL.md` 是技能的主配置文件，定义了技能的：
- 启动流程
- 工作阶段（Stage 0-5）
- 执行顺序
- 工具使用方式

#### 定制启动流程

在 `SKILL.md` 的 "🚀 立即启动（第一步）" 部分，你可以：

1. **修改扫描命令**：
   ```markdown
   ### 步骤1：扫描代码和文档（必需，第一步）

   **必须立即执行以下命令，不能跳过：**

   ```bash
   # 自定义扫描命令
   find . -type f \( -name "requirements.md" -o -name "*.md" \) | grep -v node_modules
   ```
   ```

2. **添加自定义扫描逻辑**：
   ```markdown
   **执行后，统计结果**：
   - 需求文档数量：[X]
   - 代码文件数量：[Y]
   - 自定义指标：[Z]  # 添加你的自定义指标
   ```

#### 定制工作流程阶段

在 `SKILL.md` 的 "🔄 工作流程" 部分，你可以：

1. **添加新的阶段**：
   ```markdown
   ### Stage 6: 自定义阶段

   **触发条件**: [你的触发条件]

   **执行步骤**:
   1. [步骤1]
   2. [步骤2]
   3. [步骤3]
   ```

2. **修改现有阶段的执行顺序**：
   ```markdown
   ### Stage 2: 需求分析

   **必须严格按照以下顺序执行**：
   1. **读取需求文档和代码文件**
   2. **理解项目功能**
   3. **你的自定义步骤**  # 添加自定义步骤
   4. **分析问题和缺失信息**
   5. **列出功能需求清单**
   ```

3. **修改阶段跳转逻辑**：
   ```markdown
   **📋 Stage 1: 根据扫描结果决定流程**

   - **空项目** → Stage 6（你的自定义阶段）
   - **多个需求文档** → Stage 5（需求文档合并）
   - **有需求文档** → Stage 2（需求分析）
   ```

---

### 方式2：修改专用指南文件

#### 定制需求分析流程（`ANALYZER.md`）

1. **修改分析步骤**：
   ```markdown
   ### 步骤4: AI分析需求（基于功能理解）

   **步骤1：分析问题和缺失信息**（必需，必须在列出功能需求清单之前完成）

   [你的自定义分析逻辑]

   **步骤2：列出项目的功能需求清单**（必需，必须在分析完成后列出并展示给用户）

   [你的自定义清单格式]
   ```

2. **修改分析报告格式**：
   ```markdown
   ## 📋 生成分析报告

   **报告必须包含**：
   1. 项目功能概述
   2. 你的自定义章节  # 添加自定义章节
   3. 问题分析
   4. 功能需求清单
   ```

#### 定制问题生成流程（`QUESTIONS.md`）

1. **修改问题生成逻辑**：
   ```markdown
   ### 步骤1: 基于分析结果生成问题

   **生成问题时必须**：
   1. 先理解每个需求的实际功能
   2. 你的自定义逻辑  # 添加自定义逻辑
   3. 针对具体功能问问题
   ```

2. **修改问题格式**：
   ```markdown
   **问题格式**：
   - 问题：[你的自定义格式]
   - 上下文：[你的自定义上下文]
   - 相关功能：[你的自定义关联]
   ```

#### 定制文档增强流程（`ENHANCER.md`）

1. **修改文档生成格式**：
   ```markdown
   ### 步骤2: 生成完善后的需求

   **请生成完善后的需求文档，包括**：
   1. 明确的用户故事
   2. 详细的验收标准
   3. 你的自定义章节  # 添加自定义章节
   4. 明确的业务价值说明
   ```

---

### 方式3：创建自定义指南文件

你可以创建新的指南文件，并在 `SKILL.md` 中引用：

1. **创建自定义指南**：
   ```bash
   # 创建新文件
   .claude/skills/hs-req-facilitator-skill/CUSTOM-GUIDE.md
   ```

2. **在 SKILL.md 中引用**：
   ```markdown
   ## 📚 详细指南

   - **需求分析**: [ANALYZER.md](ANALYZER.md)
   - **你的自定义指南**: [CUSTOM-GUIDE.md](CUSTOM-GUIDE.md)
   ```

3. **在工作流程中使用**：
   ```markdown
   ### Stage 2: 需求分析

   详细指南：参见 [CUSTOM-GUIDE.md](CUSTOM-GUIDE.md)
   ```

---

## 🛠️ 常见定制场景

### 场景1：添加新的扫描文件类型

**位置**：`SKILL.md` → "步骤1：扫描代码和文档"

**修改**：
```markdown
```bash
# 添加新的文件类型
find . -type f \(
  -name "requirements.md"
  -o -name "*requirement*.md"
  -o -name "需求*.md"
  -o -name "*.yaml"          # 添加 YAML 文件
  -o -name "*.json"           # 添加 JSON 文件
\) | grep -v node_modules | grep -v ".git"
```
```

### 场景2：修改交互问题的格式

**位置**：`QUESTIONS.md` → "步骤1: 基于分析结果生成问题"

**修改**：
```markdown
**问题格式**（自定义）：
- **问题类型**: [问题类型]
- **问题内容**: [你的自定义格式]
- **相关需求**: [需求ID]
- **优先级**: [P0/P1/P2]
```

### 场景3：添加新的工作阶段

**位置**：`SKILL.md` → "🔄 工作流程"

**修改**：
```markdown
### Stage 6: 自定义验证阶段

**触发条件**: Stage 4完成后

**执行步骤**:
1. 验证需求文档的完整性
2. 检查需求与代码的一致性
3. 生成验证报告

**使用工具**:
- Read: 读取需求文档和代码
- Write: 生成验证报告
```

### 场景4：修改默认语言或输出格式

**位置**：`SKILL.md` → "重要原则" 或创建新配置

**修改**：
```markdown
## 🌐 语言和格式配置

- **默认语言**: 中文（可修改为英文）
- **输出格式**: Markdown（可修改为其他格式）
- **文档格式**: spec-workflow（可修改为其他格式）
```

---

## 📝 定制示例

### 示例1：简化流程（跳过某些阶段）

修改 `SKILL.md`：

```markdown
### Stage 1: 根据扫描结果决定流程

- **空项目** → Stage 6（直接创建需求文档，跳过引导）
- **多个需求文档** → Stage 5（需求文档合并）
- **有需求文档** → Stage 4（直接完善，跳过分析和交互）  # 简化流程
```

### 示例2：添加自动化测试阶段

创建 `TESTING.md`：

```markdown
# 自动化测试指南

## 步骤1: 生成测试用例

基于完善后的需求文档，生成测试用例...

## 步骤2: 执行测试

运行测试并生成报告...
```

在 `SKILL.md` 中添加：

```markdown
### Stage 7: 自动化测试

**触发条件**: Stage 4完成后

详细指南：参见 [TESTING.md](TESTING.md)
```

### 示例3：集成外部工具

修改 `SKILL.md`：

```markdown
## 🛠️ 使用的工具

- **Read**: 读取需求文档和代码文件
- **Bash**: 查找文件、执行命令
- **AskUserQuestion**: 与用户交互
- **Write**: 更新和完善需求文档
- **spec-workflow MCP**: 访问spec-workflow模板
- **你的自定义工具**: 调用外部API或服务  # 添加自定义工具
```

---

## ⚠️ 定制注意事项

### 1. 保持核心原则

以下原则建议保持不变：
- ✅ **完全AI驱动**：不使用正则表达式
- ✅ **先扫描，后分析**：技能启动时先扫描
- ✅ **交互澄清不可跳过**：Stage 3是必需的
- ✅ **集成到spec-workflow**：统一格式处理

### 2. 测试定制后的流程

定制后，建议：
1. 在测试项目中验证流程
2. 检查所有阶段是否正常执行
3. 确认工具调用是否正确

### 3. 版本控制

建议：
- 使用 Git 管理定制后的配置
- 创建分支进行实验性定制
- 记录定制内容和原因

---

## 🔄 部署定制后的技能

### 方式1：项目内使用（推荐）

直接在项目内修改 `.claude/skills/hs-req-facilitator-skill/` 下的文件。

### 方式2：全局部署

```bash
# 复制到全局技能目录
cp -r .claude/skills/hs-req-facilitator-skill ~/.claude/skills/

# 或创建符号链接
ln -s $(pwd)/.claude/skills/hs-req-facilitator-skill ~/.claude/skills/hs-req-facilitator-skill
```

---

## 📚 参考资源

- **技能主配置**: `.claude/skills/hs-req-facilitator-skill/SKILL.md`
- **需求分析指南**: `.claude/skills/hs-req-facilitator-skill/ANALYZER.md`
- **问题生成指南**: `.claude/skills/hs-req-facilitator-skill/QUESTIONS.md`
- **文档增强指南**: `.claude/skills/hs-req-facilitator-skill/ENHANCER.md`
- **文档合并指南**: `.claude/skills/hs-req-facilitator-skill/MERGER.md`
- **需求文档**: `.spec-workflow/specs/implement-core-business-logic/requirements.md`

---

## 🎯 快速开始

1. **打开技能配置文件**：
   ```bash
   code .claude/skills/hs-req-facilitator-skill/SKILL.md
   ```

2. **找到要定制的部分**：
   - 启动流程：`SKILL.md` 的第8-27行
   - 工作流程：`SKILL.md` 的第73-250行
   - 重要原则：`SKILL.md` 的第235-247行

3. **进行定制**：
   - 修改流程步骤
   - 添加自定义逻辑
   - 调整执行顺序

4. **测试定制后的技能**：
   ```bash
   # 在 Cursor 中调用技能
   # 说："完善需求" 或直接使用技能
   ```

---

## 💡 提示

- **渐进式定制**：建议先小范围修改，测试后再扩大定制范围
- **保持文档同步**：修改流程后，记得更新相关文档
- **记录变更**：在 Git 中记录每次定制的内容和原因
- **参考现有模式**：参考现有阶段的实现方式，保持一致性

---

**定制完成后，记得在 Cursor 中重新加载技能或重启 Cursor 以使更改生效！**
