# Setup Guide for hs-req-facilitator-skill

This guide provides detailed setup instructions for installing, configuring, and using hs-req-facilitator-skill.

## Table of Contents

- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Verification](#verification)
- [Configuration](#configuration)
- [Usage](#usage)
- [Troubleshooting](#troubleshooting)
- [Uninstallation](#uninstallation)

## Prerequisites

### Required

- **Claude Code**: Claude Code installed and configured
  - [Download Claude Code](https://claude.ai/download)
  - Version: Latest recommended

- **Project**: A software project with requirements documents (optional)
  - Can be used with any technology stack
  - Support for Markdown-based requirements files

### Optional

- **Spec-Workflow**: For enhanced requirements integration
- **Git**: For version control and updates
- **GitHub Account**: For downloading releases

## Installation

### Method 1: Direct Clone (Development)

For development or contributing:

```bash
# Clone repository
git clone https://github.com/[username]/hs-req-facilitator-skill.git
cd hs-req-facilitator-skill

# Copy to Claude Code skills directory
# macOS/Linux
cp -r . ~/.claude/skills/hs-req-facilitator-skill

# Windows (PowerShell)
Copy-Item -Recurse -Force . "$env:USERPROFILE\.claude\skills\hs-req-facilitator-skill"

# Verify installation
ls ~/.claude/skills/hs-req-facilitator-skill
```

### Method 2: GitHub Release (Recommended)

For production use:

```bash
# Create skills directory if not exists
mkdir -p ~/.claude/skills

# Download latest release (replace with actual URL)
wget https://github.com/[username]/hs-req-facilitator-skill/archive/v2.0.0.zip

# Extract
unzip v2.0.0.zip
mv hs-req-facilitator-skill-2.0.0 hs-req-facilitator-skill

# Copy to Claude Code
cp -r hs-req-facilitator-skill ~/.claude/skills/

# Cleanup
rm -rf hs-req-facilitator-skill-2.0.0 v2.0.0.zip
```

### Method 3: Using GitHub CLI

If you have GitHub CLI installed:

```bash
# Clone directly to skills directory
git clone https://github.com/[username]/hs-req-facilitator-skill.git \
  ~/.claude/skills/hs-req-facilitator-skill
```

## Verification

### 1. Check File Structure

```bash
# Verify skill files exist
ls -la ~/.claude/skills/hs-req-facilitator-skill/

# Expected output:
# README.md
# SKILL.md
# VERSION
# LICENSE
# .gitignore
# references/
# assets/
# examples/
# docs/
```

### 2. Verify YAML Frontmatter

```bash
# Check SKILL.md has valid YAML
head -10 ~/.claude/skills/hs-req-facilitator-skill/SKILL.md

# Expected:
# ---
# name: hs-req-facilitator-skill
# description: Use this skill when users want to analyze...
```

### 3. Test Skill Activation

1. **Start Claude Code**:
   ```bash
   claude
   ```

2. **Test activation with trigger phrase**:
   ```
   Help me analyze requirements for my project
   ```

3. **Verify response**:
   - Skill should activate
   - Should follow 5-stage workflow
   - Should mention Stage 1 scanning

## Configuration

### Basic Configuration

No additional configuration required for basic use. The skill works with defaults.

### Optional: Spec-Workflow Integration

If your project uses spec-workflow:

```bash
# Ensure .spec-workflow directory exists in your project
mkdir -p .spec-workflow/specs

# The skill will automatically detect and integrate
```

### Optional: Environment Variables

No environment variables required. The skill is fully self-contained.

### Optional: Custom Settings

Create a `.claude/settings.json` in your project (optional):

```json
{
  "skills": {
    "hs-req-facilitator-skill": {
      "enabled": true,
      "autoActivate": true
    }
  }
}
```

## Usage

### Quick Start

1. **Navigate to your project**:
   ```bash
   cd /path/to/your/project
   ```

2. **Activate Claude Code**:
   ```bash
   claude
   ```

3. **Use the skill**:
   ```
   Analyze the requirements in this project
   ```

### Common Use Cases

#### Use Case 1: Analyze Existing Requirements

```
User: "Analyze my requirements document"
Skill: Follows 5-stage workflow:
  - Stage 0: Workflow check
  - Stage 1: Scan files
  - Stage 2: Analyze requirements
  - Stage 3: Interactive clarification
  - Stage 4: Generate improved requirements
```

#### Use Case 2: Consolidate Multiple Documents

```
User: "I have multiple requirements files that need consolidation"
Skill:
  - Detects multiple files
  - Prompts for confirmation
  - Merges into single document
  - Removes duplicates
```

#### Use Case 3: Create Initial Requirements

```
User: "My project has no requirements document"
Skill:
  - Detects empty project
  - Prompts to create requirements
  - Provides guidance and templates
  - Creates initial requirements.md
```

### Trigger Keywords

The skill activates when you mention:

- "analyze requirements"
- "clarify requirements"
- "improve requirements"
- "consolidate requirements"
- "specifications"
- "needs analysis"
- "requirements document"

### Example Workflow

```
You: "Help me improve these requirements"

Claude Code (using hs-req-facilitator-skill):

🔍 Stage 1: Scanning project files...
✅ Found: requirements.md (1 file)

📋 Stage 2: Analyzing requirements...
✅ Identified: 5 functional requirements
⚠️  Found: 2 missing acceptance criteria

❓ Stage 3: Interactive clarification...
Would you like to add acceptance criteria for:
  1. User authentication (missing error handling)
  2. Data export (missing format specification)

You: "Yes, add them"

✅ Stage 4: Generating improved requirements...
📝 Created: improved-requirements.md
```

## Advanced Usage

### Custom Prompts

You can provide specific instructions:

```
Analyze requirements and focus on security aspects
```

```
Clarify requirements and identify missing test scenarios
```

```
Consolidate requirements and remove duplicate features
```

### Integration with Other Tools

The skill works well with:

- **Spec-Workflow**: Automatic integration
- **Git**: Commit improved requirements
- **Documentation Tools**: Generate API docs from requirements

### Best Practices

1. **Keep Requirements Updated**:
   - Run skill periodically
   - Update as project evolves

2. **Collaborative Review**:
   - Use Stage 3 interaction actively
   - Engage team members in clarification

3. **Version Control**:
   - Commit improved requirements
   - Track changes over time

4. **Template Usage**:
   - Use `assets/requirements-template.md`
   - Reference `examples/requirements-example.md`

## Troubleshooting

### Issue: Skill Not Activating

**Symptoms**:
- Claude Code doesn't use the skill
- No response to trigger keywords

**Solutions**:

1. **Verify Installation**:
   ```bash
   ls ~/.claude/skills/hs-req-facilitator-skill/SKILL.md
   ```

2. **Check YAML Syntax**:
   ```bash
   python3 -c "import yaml; yaml.safe_load(open('~/.claude/skills/hs-req-facilitator-skill/SKILL.md'))"
   ```

3. **Restart Claude Code**:
   - Close Claude Code completely
   - Reopen and test again

4. **Explicit Activation**:
   ```
   Use hs-req-facilitator-skill to analyze my requirements
   ```

### Issue: Stage 3 Not Executing

**Symptoms**:
- Skill skips interactive clarification
- Goes directly to Stage 4

**Solutions**:

1. **Check Stage 2 Completion**:
   - Ensure Stage 2 outputs are present
   - Verify all 4 sub-steps completed

2. **Environment Check**:
   - Claude Code: AskUserQuestion tool available
   - Cursor: Uses conversation mode

3. **Review SKILL.md**:
   - Check Stage 3 configuration
   - Verify mandatory execution logic

### Issue: Files Not Created

**Symptoms**:
- Skill runs but no output files
- Missing improved requirements

**Solutions**:

1. **Check Permissions**:
   ```bash
   # Verify write permissions
   touch ~/.claude/skills/hs-req-facilitator-skill/test.txt
   ```

2. **Check Paths**:
   - Verify output directory exists
   - Check for absolute vs relative paths

3. **Review Logs**:
   - Look for error messages in output
   - Check file system for created files

### Issue: Poor Analysis Results

**Symptoms**:
- Vague or incorrect analysis
- Missing important details

**Solutions**:

1. **Improve Input Quality**:
   - Provide clear, detailed requirements
   - Include context and examples

2. **Use Stage 3 Interaction**:
   - Answer clarification questions
   - Provide additional details

3. **Iterative Improvement**:
   - Run skill multiple times
   - Refine based on feedback

### Issue: Multi-Document Consolidation Fails

**Symptoms**:
- Cannot merge multiple files
- Errors during consolidation

**Solutions**:

1. **Verify File Formats**:
   - Ensure all files are Markdown
   - Check for encoding issues

2. **Check File Permissions**:
   - Ensure all files are readable
   - Verify directory permissions

3. **Manual Backup**:
   - Backup original files before consolidation
   - Review merge results carefully

## Uninstallation

### Complete Removal

```bash
# Remove skill directory
rm -rf ~/.claude/skills/hs-req-facilitator-skill

# Remove any generated files in your projects
find /path/to/your/project -name "*requirements-improved*" -delete

# Restart Claude Code
```

### Disable Without Removal

```bash
# Rename skill directory (temporarily disable)
mv ~/.claude/skills/hs-req-facilitator-skill \
   ~/.claude/skills/hs-req-facilitator-skill.disabled

# Restart Claude Code
```

### Update Skill

```bash
# Remove old version
rm -rf ~/.claude/skills/hs-req-facilitator-skill

# Install new version (see Installation section)
```

## Getting Help

### Documentation

- **README.md**: Overview and quick start
- **SKILL.md**: Complete skill documentation
- **docs/tasks/tests/how-to-test-skill.md**: Testing guide
- **docs/tasks/release/how-to-release.md**: Release guide

### Resources

- **GitHub Issues**: Report bugs or request features
- **GitHub Discussions**: Ask questions and share experiences
- **Examples Directory**: See `examples/` for sample usage

### Support Channels

1. **GitHub Issues**: For bugs and feature requests
2. **GitHub Discussions**: For questions and community support
3. **Email**: [Maintainer email if available]

## Performance Tips

### Optimize for Large Projects

1. **Use .gitignore**: Exclude unnecessary files
   ```bash
   echo "node_modules/" >> .gitignore
   echo "dist/" >> .gitignore
   ```

2. **Limit Scan Depth**: Specify directories
   ```
   Analyze requirements in src/ directory only
   ```

3. **Incremental Analysis**: Focus on changed files
   ```
   Analyze only recently modified requirements
   ```

### Speed Up Workflow

1. **Prepare Questions**: Think about clarifications beforehand
2. **Batch Operations**: Analyze multiple files together
3. **Use Templates**: Start with `assets/requirements-template.md`

## Best Practices

1. **Regular Reviews**: Run skill monthly
2. **Team Collaboration**: Use Stage 3 actively
3. **Version Control**: Commit improved requirements
4. **Documentation**: Keep requirements synchronized with code
5. **Templates**: Use provided templates for consistency

## Next Steps

After setup:

1. Review `examples/requirements-example.md`
2. Read `SKILL.md` for complete documentation
3. Try test scenarios from `docs/tasks/tests/`
4. Join community discussions
5. Contribute improvements

---

**Setup Complete!** 🎉

You're ready to use hs-req-facilitator-skill for intelligent requirements analysis and improvement.
