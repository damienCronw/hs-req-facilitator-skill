# HS Req Facilitator Skill

**智能需求分析助手** | 5-stage AI-driven requirements analysis

[![Version](https://img.shields.io/badge/Version-v2.0.4-orange)](VERSION)
[![License](https://img.shields.io/badge/License-MIT-green)](LICENSE)

**作者**: 苏州核朔智能科技有限公司 | [www.norkern.com](https://www.norkern.com)

---

## 🚀 快速开始

### 安装

1. 复制技能包到Claude Code：
```bash
cp -r hs-req-facilitator-skill ~/.claude/skills/
```

2. 重启Claude Code，技能自动加载

### 使用

在Claude Code中直接使用：
```
使用hs-req-facilitator-skill分析需求
```

---

## ✨ 核心功能

- **5-stage工作流**: 系统化需求分析流程
- **AI驱动分析**: 识别模糊点、缺失信息、不一致性
- **交互澄清**: 通过AskUserQuestion补充需求
- **Spec-Workflow集成**: 生成标准化需求文档
- **多文档合并**: 智能合并多个需求文档

---

## 📁 项目结构

```
hs-req-facilitator-skill/
├── SKILL.md                          # 核心配置文件
├── README.md                         # 项目说明
├── .claude-config.json              # 技能配置
├── LICENSE                           # MIT许可证
├── VERSION                          # 版本号
├── .spec-workflow/                  # 需求文档
│   ├── requirements.md              # 原始需求
│   └── requirements-enhanced.md     # 增强需求
├── assets/                          # 模板资源
│   └── requirements-template.md     # 需求模板
└── examples/                        # 使用示例
    └── requirements-example.md      # 示例文档
```

---

## 📖 文档

- **SKILL.md** - 完整工作流程和使用指南
- **requirements.md** - 技能功能需求定义
- **requirements-enhanced.md** - 增强需求文档（包含自我分析结果）

---

## 🤖 工作流程

1. **Stage 0**: 工作流检查
2. **Stage 1**: 扫描代码和文档
3. **Stage 2**: 需求分析（4子步骤）
4. **Stage 3**: 交互澄清（强制）
5. **Stage 4**: 需求完善

详细说明请查看 [SKILL.md](SKILL.md)

---

## 📄 许可证

MIT License - 详见 [LICENSE](LICENSE)

---

## 📞 联系方式

**苏州核朔智能科技有限公司**
邮箱: limian@norkern.com
网站: [www.norkern.com](https://www.norkern.com)
GitHub: [damienCronw/hs-req-facilitator-skill](https://github.com/damienCronw/hs-req-facilitator-skill)
