# 自定义命令: /hs-req

## 🚀 使用方法

### 基本语法
```
/hs-req [项目路径]
```

### 示例

#### 1. 分析当前项目
```
/hs-req
```

#### 2. 分析指定项目
```
/hs-req /path/to/your/project
```

#### 3. 分析当前目录
```
/hs-req .
```

---

## 📋 参数说明

| 参数 | 类型 | 必需 | 默认值 | 说明 |
|------|------|------|--------|------|
| 项目路径 | string | 否 | . | 要分析的项目目录路径 |

---

## 🎯 实际使用场景

### 场景1: 分析当前工作目录
```
/hs-req
```
**效果**: 分析当前工作目录中的项目需求

### 场景2: 分析其他项目
```
/hs-req ~/Projects/my-app
```
**效果**: 分析指定路径的项目需求

### 场景3: 在项目目录内直接调用
```
cd /path/to/project
# 然后在Claude Code中输入:
/hs-req
```

---

## 🔧 安装步骤

### 步骤1: 复制技能包
```bash
cp -r hs-req-facilitator-skill ~/.claude/skills/
```

### 步骤2: 创建自定义命令
```bash
# 创建commands目录（如果不存在）
mkdir -p ~/.claude/commands

# 复制命令配置
# 将以下内容保存到 ~/.claude/commands/hs-req.json
{
  "name": "hs-req",
  "description": "智能需求分析助手 - 自动分析项目需求文档",
  "usage": "/hs-req [项目路径]",
  "parameters": {
    "project_path": {
      "type": "string",
      "description": "要分析的项目路径（可选，默认当前目录）",
      "required": false,
      "default": "."
    }
  },
  "skill_name": "hs-req-facilitator-skill",
  "activation_message": "使用hs-req-facilitator-skill分析需求"
}
```

### 步骤3: 重启Claude Code
关闭并重新打开Claude Code，自定义命令即可生效。

---

## 💡 命令配置详解

```json
{
  "name": "hs-req",              // 命令名称（不含/）
  "description": "...",          // 命令描述
  "usage": "/hs-req [项目路径]",  // 使用语法
  "parameters": {                // 参数定义
    "project_path": {
      "type": "string",          // 参数类型
      "description": "...",      // 参数说明
      "required": false,         // 是否必需
      "default": "."             // 默认值
    }
  },
  "skill_name": "hs-req-facilitator-skill",  // 调用的技能名称
  "activation_message": "使用hs-req-facilitator-skill分析需求"  // 激活消息
}
```

---

## 📝 注意事项

1. **路径格式**: 使用绝对路径或相对路径
2. **权限**: 确保有权限访问指定目录
3. **项目结构**: 建议在包含项目文件的目录中调用命令
4. **技能依赖**: 确保hs-req-facilitator-skill已正确安装

---

## 🔗 相关资源

- [README.md](README.md) - 技能完整说明
- [COMMANDS.md](COMMANDS.md) - 所有调用方式
- [SKILL.md](SKILL.md) - 详细工作流程
- [.claude-config.json](.claude-config.json) - 技能配置

---

## ❓ 故障排除

### Q: 命令不显示？
**A**: 重启Claude Code，确保命令配置文件正确

### Q: 提示"技能未找到"？
**A**: 检查技能包是否正确安装到 `~/.claude/skills/`

### Q: 无法访问项目目录？
**A**: 检查路径是否正确，确保有读取权限

---

**享受高效的需求分析！** 🚀
