# Cursor 原生方式实现 hs-req-facilitator-skill 流程

## 📋 概述

本文档说明如何在 **Cursor 编辑器**中通过原生方式（不使用 Claude Code 扩展）实现 `hs-req-facilitator-skill` 的需求分析和完善流程。

---

## 🎯 实现方式

### 方式1：使用 `.cursorrules` 文件（推荐）

`.cursorrules` 是 Cursor 的原生配置文件，用于定义 AI 助手的行为和规则。

#### 创建 `.cursorrules` 文件

在项目根目录创建 `.cursorrules` 文件：

```markdown
# HS Req Facilitator Skill - Cursor 原生实现

## 技能说明
智能需求分析助手，通过AI分析和交互式澄清完善需求文档。

## 核心原则
1. 完全AI驱动，不使用正则表达式
2. 先扫描，后分析
3. 先分析，后交互
4. 交互澄清不可跳过
5. 集成到spec-workflow格式

## 工作流程

### Stage 0: 扫描代码和文档（必需，第一步）

当用户说"完善需求"、"分析需求文档"或类似内容时，必须立即执行：

1. **扫描需求文档**：
   ```bash
   find . -type f \( -name "requirements.md" -o -name "*requirement*.md" -o -name "需求*.md" \) | grep -v node_modules | grep -v ".git"
   ```

2. **扫描代码文件**：
   ```bash
   find . -type f \( -name "*.ts" -o -name "*.js" -o -name "*.py" -o -name "*.java" -o -name "*.go" -o -name "*.rs" \) | grep -v node_modules | grep -v ".git" | head -50
   ```

3. **统计结果**：
   - 需求文档数量：[X]
   - 代码文件数量：[Y]

### Stage 1: 根据扫描结果决定流程

根据扫描结果，决定执行哪个流程：

- **空项目（没有需求文档）**：
  - 询问用户是否要创建需求文档
  - 如果同意，引导用户创建初始需求文档

- **多个需求文档**：
  - 询问用户是否要合并需求文档
  - 如果同意，进入文档合并流程

- **有需求文档（常规流程）**：
  - 直接进入 Stage 2（需求分析）

### Stage 2: 需求分析（必须在交互澄清之前完成）

必须严格按照以下顺序执行：

1. **读取需求文档和代码文件**
   - 读取项目中的需求文档（`.spec-workflow/specs/*/requirements.md` 或根目录的 `requirements.md`）
   - 读取代码文件，理解已实现的功能

2. **理解项目功能**
   - 项目是什么？核心功能是什么？
   - 每个需求对应的实际功能是什么？
   - 代码中实现了哪些功能？
   - 对比代码和需求，理解功能一致性

3. **分析问题和缺失信息**（必需，必须在列出功能需求清单之前完成）
   - 识别不明确/缺失/不一致的需求
   - 评估信息完整性
   - 判断是否为误报（代码是否已解释）
   - 明确说明：缺失什么、为什么是问题、是否为误报、如何修复

4. **列出功能需求清单**（必需，必须在分析完成后列出并展示给用户）
   - 基于代码和文档分析结果，列出所有功能需求
   - 每个需求包括：功能名称、功能描述、功能行为、输入输出、代码实现状态、需求文档位置
   - 分类为 P0/P1/P2
   - **必须展示给用户**

⚠️ **关键检查点**：完成 Stage 2 后，必须进入 Stage 3（交互澄清），不能跳过！

### Stage 3: 交互澄清（必需，不能跳过）

⚠️ **必需阶段，不能跳过！**

**必须与用户交互**（通过对话，不能只是输出文本）：

- **如果有问题**：
  - 基于功能需求清单和问题分析结果，生成澄清问题
  - 针对具体功能问问题，不是通用的检查清单
  - 逐个询问缺失的信息，补充需求
  - 问题格式：基于实际功能，说明问题背景，询问具体信息

- **如果没有问题**：
  - 告知用户"没有发现问题需要澄清"
  - 然后询问："是否要添加新需求？或直接进入下一步？"

⚠️ **无论是否有问题，都必须至少进行一次交互！**

⚠️ **关键检查点**：只有完成 Stage 3 的所有交互后，才能进入 Stage 4（需求完善）！

### Stage 4: 需求完善

1. **整合信息**：
   - 原始需求文档
   - 用户澄清的回答
   - 代码分析结果
   - 功能需求清单

2. **生成完善后的需求**：
   - 按照 spec-workflow 格式生成需求文档（无论项目是否使用 spec-workflow）
   - 生成用户故事（格式：As a [role], I want [feature], so that [benefit]）
   - 生成验收标准（EARS格式：WHEN [condition] THEN [system] SHALL [response]）
   - 保留原始内容（追加模式）

3. **检测和处理 spec-workflow 集成**：
   - 如果项目使用 spec-workflow：更新 `.spec-workflow/specs/*/requirements.md`
   - 如果项目未使用 spec-workflow：生成 spec-workflow 格式，询问是否创建 spec-workflow 结构

### Stage 5: 需求文档合并（多个需求文档时）

**触发条件**：在 Stage 1，如果检测到多个需求文档，进入此阶段。

1. 识别需要合并的文档
2. AI 分析：重复、冲突、互补
3. 生成合并方案
4. 询问用户确认合并方案和处理冲突
5. 执行合并
6. **按照 spec-workflow 格式生成合并后的文档**
7. **使用 AskUserQuestion 确认要删除的文档列表**（删除前必须确认）
8. 删除所有已合并的需求文档（用户确认后）
9. 只保留合并后的文档

## 使用的工具

- **Read**: 读取需求文档和代码文件
- **Bash**: 查找文件、执行命令
- **对话交互**: 与用户交互，澄清需求（必需）
- **Write**: 更新和完善需求文档
- **MCP (如可用)**: 访问spec-workflow模板和上下文

## 执行检查清单

每次执行时，检查：
- ✅ Stage 0 已完成（扫描代码和文档）
- ✅ Stage 2 已完成（需求分析）
- ✅ Stage 3 已完成（至少一次交互）
- ✅ Stage 4 已完成（需求完善）
- ✅ 输出格式符合 spec-workflow

## 重要原则

1. **严格按照顺序执行**：不能跳过 Stage 0、Stage 2 或 Stage 3
2. **先分析，后交互**：Stage 2 必须完成，然后才能进入 Stage 3
3. **交互澄清不可跳过**：Stage 3 是必需的，必须至少进行一次交互
4. **集成到spec-workflow**：无论项目是否使用 spec-workflow，都按照 spec-workflow 格式处理
5. **完全AI驱动**：不使用正则表达式，完全依赖 AI 理解能力
```

---

### 方式2：创建 Cursor 命令文件

在 `.cursor/commands/` 目录下创建命令文件。

#### 创建命令文件

```bash
mkdir -p .cursor/commands
```

创建 `.cursor/commands/req-facilitator.md`：

```markdown
# 需求完善助手

## 触发词
- "完善需求"
- "分析需求文档"
- "澄清需求"
- "合并需求文档"

## 执行流程

请按照以下流程执行：

### 步骤1：扫描代码和文档

执行以下命令扫描项目：

```bash
# 扫描需求文档
find . -type f \( -name "requirements.md" -o -name "*requirement*.md" -o -name "需求*.md" \) | grep -v node_modules | grep -v ".git"

# 扫描代码文件
find . -type f \( -name "*.ts" -o -name "*.js" -o -name "*.py" \) | grep -v node_modules | grep -v ".git" | head -50
```

### 步骤2：根据扫描结果决定流程

- 如果发现多个需求文档 → 询问是否合并
- 如果没有需求文档 → 询问是否创建
- 如果有需求文档 → 进入需求分析

### 步骤3：需求分析

1. 读取需求文档和代码
2. 理解项目功能
3. 分析问题和缺失信息
4. 列出功能需求清单（必须展示给用户）

### 步骤4：交互澄清

- 如果有问题：逐个询问缺失的信息
- 如果没有问题：询问是否添加新需求

### 步骤5：需求完善

1. 整合信息
2. 生成完善后的需求（spec-workflow格式）
3. 更新或创建需求文档

## 输出格式

所有输出必须符合 spec-workflow 格式。
```

---

### 方式3：创建 MCP 服务器（高级）

如果你想创建一个独立的 MCP 服务器来实现这个流程：

#### 创建 MCP 服务器结构

```bash
mkdir -p cursor-req-facilitator-mcp
cd cursor-req-facilitator-mcp
npm init -y
```

#### 安装依赖

```bash
npm install @modelcontextprotocol/sdk
```

#### 创建服务器代码

`src/index.ts`:

```typescript
import { Server } from "@modelcontextprotocol/sdk/server/index.js";
import { StdioServerTransport } from "@modelcontextprotocol/sdk/server/stdio.js";
import {
  CallToolRequestSchema,
  ListToolsRequestSchema,
} from "@modelcontextprotocol/sdk/types.js";

const server = new Server(
  {
    name: "hs-req-facilitator-mcp",
    version: "1.0.0",
  },
  {
    capabilities: {
      tools: {},
    },
  }
);

// 注册工具
server.setRequestHandler(ListToolsRequestSchema, async () => ({
  tools: [
    {
      name: "scan_requirements",
      description: "扫描项目中的需求文档",
      inputSchema: {
        type: "object",
        properties: {
          projectPath: {
            type: "string",
            description: "项目路径",
          },
        },
      },
    },
    {
      name: "analyze_requirements",
      description: "分析需求文档和代码",
      inputSchema: {
        type: "object",
        properties: {
          requirementsPath: {
            type: "string",
            description: "需求文档路径",
          },
          codePaths: {
            type: "array",
            items: { type: "string" },
            description: "代码文件路径列表",
          },
        },
      },
    },
    {
      name: "enhance_requirements",
      description: "完善需求文档",
      inputSchema: {
        type: "object",
        properties: {
          requirementsPath: {
            type: "string",
            description: "需求文档路径",
          },
          clarifications: {
            type: "object",
            description: "用户澄清的回答",
          },
        },
      },
    },
  ],
}));

// 处理工具调用
server.setRequestHandler(CallToolRequestSchema, async (request) => {
  const { name, arguments: args } = request.params;

  switch (name) {
    case "scan_requirements":
      // 实现扫描逻辑
      return {
        content: [
          {
            type: "text",
            text: "扫描完成：发现 2 个需求文档",
          },
        ],
      };

    case "analyze_requirements":
      // 实现分析逻辑
      return {
        content: [
          {
            type: "text",
            text: "分析完成：发现 5 个问题需要澄清",
          },
        ],
      };

    case "enhance_requirements":
      // 实现完善逻辑
      return {
        content: [
          {
            type: "text",
            text: "需求文档已完善",
          },
        ],
      };

    default:
      throw new Error(`Unknown tool: ${name}`);
  }
});

// 启动服务器
async function main() {
  const transport = new StdioServerTransport();
  await server.connect(transport);
  console.error("HS Req Facilitator MCP 服务器已启动");
}

main().catch(console.error);
```

#### 配置 MCP 服务器

在 `~/.cursor/mcp.json` 中添加：

```json
{
  "mcpServers": {
    "hs-req-facilitator": {
      "command": "node",
      "args": ["/path/to/cursor-req-facilitator-mcp/dist/index.js"],
      "env": {}
    }
  }
}
```

---

## 🎯 推荐方案对比

| 方案 | 优点 | 缺点 | 适用场景 |
|------|------|------|---------|
| **`.cursorrules`** | ✅ 简单易用<br>✅ 项目内配置<br>✅ 无需额外工具 | ❌ 功能有限<br>❌ 依赖 Cursor AI | 快速实现，简单流程 |
| **命令文件** | ✅ 结构化<br>✅ 可复用<br>✅ 易于维护 | ❌ 需要手动调用 | 中等复杂度，需要自定义触发 |
| **MCP 服务器** | ✅ 功能强大<br>✅ 可扩展<br>✅ 独立部署 | ❌ 需要开发<br>❌ 需要维护 | 复杂流程，需要独立服务 |

---

## 🚀 快速开始（推荐：`.cursorrules`）

### 步骤1：创建 `.cursorrules` 文件

在项目根目录创建 `.cursorrules` 文件，复制上面的内容。

### 步骤2：测试流程

在 Cursor 中：
1. 打开项目
2. 对 AI 说："完善需求" 或 "分析需求文档"
3. AI 应该按照 `.cursorrules` 中定义的流程执行

### 步骤3：定制流程

根据需要修改 `.cursorrules` 文件中的：
- 扫描命令
- 分析步骤
- 交互方式
- 输出格式

---

## 📝 示例：在 Cursor 中使用

### 示例1：完善需求

```
你: 完善需求

AI: [按照 .cursorrules 中的流程执行]
   1. 扫描代码和文档...
   2. 发现需求文档：requirements.md
   3. 开始需求分析...
   4. 列出功能需求清单...
   5. 发现问题需要澄清，询问用户...
```

### 示例2：合并需求文档

```
你: 合并需求文档

AI: [按照 .cursorrules 中的流程执行]
   1. 扫描代码和文档...
   2. 发现多个需求文档
   3. 询问是否合并...
   4. 执行合并流程...
```

---

## ⚠️ 注意事项

### 1. Cursor AI 的限制

- Cursor 的 AI 是对话式的，没有 `AskUserQuestion` 工具
- 需要通过对话来实现交互
- 某些复杂的工具调用可能需要手动执行

### 2. 与 Claude Code Skill 的区别

| 特性 | Claude Code Skill | Cursor 原生方式 |
|------|------------------|----------------|
| **工具支持** | AskUserQuestion, Read, Write 等 | 对话交互、文件操作 |
| **流程控制** | 严格的阶段控制 | 依赖 AI 理解 |
| **配置方式** | SKILL.md 等配置文件 | .cursorrules 或命令文件 |
| **部署方式** | ~/.claude/skills/ | 项目内 .cursorrules |

### 3. 最佳实践

- **保持流程清晰**：在 `.cursorrules` 中明确说明每个阶段
- **提供示例**：在规则中提供执行示例
- **测试验证**：每次修改后测试流程是否正常
- **版本控制**：将 `.cursorrules` 纳入 Git 管理

---

## 🔄 迁移指南

如果你已经有 Claude Code Skill 版本，迁移到 Cursor 原生方式：

### 1. 提取核心流程

从 `SKILL.md` 中提取：
- 工作流程（Stage 0-5）
- 重要原则
- 执行顺序

### 2. 转换为 Cursor 格式

- 将 `AskUserQuestion` 转换为对话交互
- 将工具调用转换为命令或文件操作
- 将阶段控制转换为流程说明

### 3. 测试和调整

- 在 Cursor 中测试流程
- 根据实际执行情况调整规则
- 优化交互方式

---

## 📚 参考资源

- **Cursor Rules 文档**: [Cursor 官方文档](https://docs.cursor.com)
- **MCP 协议**: [Model Context Protocol](https://modelcontextprotocol.io)
- **原始技能配置**: `.claude/skills/hs-req-facilitator-skill/SKILL.md`

---

## 💡 提示

- **简化流程**：Cursor 原生方式可以适当简化流程，聚焦核心功能
- **灵活调整**：根据 Cursor AI 的实际表现调整规则
- **逐步优化**：先实现基本流程，再逐步完善

---

**现在你可以在 Cursor 中通过原生方式使用需求完善功能了！**
