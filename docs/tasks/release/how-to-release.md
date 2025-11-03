# How to Release hs-req-facilitator-skill

This guide provides step-by-step instructions for releasing hs-req-facilitator-skill.

**Author**: 苏州核朔智能科技有限公司 | **Email**: limian@norkern.com | **Website**: [www.norker.com](https://www.norker.com)

## Prerequisites

- Git installed and configured
- GitHub account with repository access
- All tests passing
- Documentation updated
- Version bumped in VERSION file

## Release Process

### Step 1: Pre-Release Checklist

Before releasing, ensure:

- [ ] All code is committed to main branch
- [ ] All tests pass (see `docs/tasks/tests/how-to-test-skill.md`)
- [ ] VERSION file updated to new version
- [ ] CHANGELOG.md updated with changes
- [ ] README.md reflects current state
- [ ] SKILL.md is up-to-date
- [ ] No debug or development artifacts in code
- [ ] .gitignore properly configured
- [ ] LICENSE is present and correct

### Step 2: Update Version

Edit VERSION file:
```bash
# Current: 2.0.0
# New: 2.0.1 (for patch) or 2.1.0 (for minor) or 3.0.0 (for major)

echo "2.0.1" > VERSION
git add VERSION
git commit -m "chore: bump version to 2.0.1"
```

### Step 3: Update CHANGELOG.md

Add new entry to CHANGELOG.md:

```markdown
## [2.0.1] - 2025-11-04

### Added
- Enhanced YAML frontmatter compliance
- Complete documentation structure
- Example requirements template

### Changed
- Updated .gitignore to standard format
- Improved SKILL.md structure

### Fixed
- Minor documentation issues

### Removed
- N/A
```

### Step 4: Commit Changes

```bash
git add .
git commit -m "feat: release v2.0.1

- Add comprehensive documentation structure
- Include examples and templates
- Improve skill compliance to 95%+
- Add testing guide
- Add release guide

Closes #XX"
```

### Step 5: Push to GitHub

```bash
git push origin main
```

### Step 6: Create Release on GitHub

#### Option A: Using GitHub CLI (Recommended)

```bash
# Install gh CLI if not installed
# https://cli.github.com/

# Create release
gh release create v2.0.1 \
  --title "hs-req-facilitator-skill v2.0.1" \
  --notes-file CHANGELOG.md

# The GitHub Actions workflow will automatically:
# 1. Build the skill package
# 2. Create a zip file
# 3. Attach it to the release
```

#### Option B: Using GitHub Web Interface

1. Go to repository on GitHub
2. Click "Releases" → "Create a new release"
3. Tag version: `v2.0.1`
4. Release title: `hs-req-facilitator-skill v2.0.1`
5. Description: Copy from CHANGELOG.md
6. Click "Publish release"

### Step 7: Verify Release

After release is published:

- [ ] Release appears on GitHub releases page
- [ ] Zip file attached automatically
- [ ] Download works correctly
- [ ] README.md displays correctly
- [ ] Skill structure is valid

### Step 8: Test Release

Create a test directory and verify the release:

```bash
# Create test directory
mkdir test-release
cd test-release

# Download and extract release
wget https://github.com/[user]/hs-req-facilitator-skill/archive/v2.0.1.zip
unzip v2.0.1.zip
mv hs-req-facilitator-skill-2.0.1 hs-req-facilitator-skill

# Install to Claude Code
cp -r hs-req-facilitator-skill ~/.claude/skills/

# Test skill
claude "Use hs-req-facilitator-skill to analyze requirements"
```

## Automated Release (GitHub Actions)

This repository includes `.github/workflows/release-skill.yml` for automated releases.

### Setup GitHub Actions

1. Repository must have GitHub Actions enabled
2. Workflow file is already included
3. On creating a release tag, workflow triggers automatically

### Workflow Steps

1. **Checkout** - Downloads repository code
2. **Setup Node.js** - Prepares Node.js environment
3. **Install Dependencies** - Installs required packages
4. **Validate Skill** - Checks skill structure
5. **Build Skill Package** - Creates zip file
6. **Upload Release Asset** - Attaches zip to release

### Manual Trigger

You can also trigger workflow manually:

```bash
# Via GitHub CLI
gh workflow run release-skill.yml
```

## Distribution

### Method 1: GitHub Releases (Recommended)

1. Releases are versioned and downloadable
2. Zip file contains complete skill package
3. Users can: `cp -r hs-req-facilitator-skill-2.0.1 ~/.claude/skills/`

### Method 2: Direct Clone

```bash
git clone https://github.com/[user]/hs-req-facilitator-skill.git
cp -r hs-req-facilitator-skill ~/.claude/skills/
```

### Method 3: Archive Download

1. Go to repository
2. Click "Code" → "Download ZIP"
3. Extract and copy to skills directory

## Version Numbering

We follow [Semantic Versioning](https://semver.org/):

- **MAJOR.MINOR.PATCH** (e.g., 2.0.1)
- **MAJOR**: Breaking changes
- **MINOR**: New features, backward compatible
- **PATCH**: Bug fixes, backward compatible

Examples:
- `2.0.0` → `2.1.0`: New feature added
- `2.0.0` → `2.0.1`: Bug fix
- `2.0.0` → `3.0.0`: Breaking changes

## Release Checklist Template

```
Pre-Release:
□ Version bumped in VERSION file
□ CHANGELOG.md updated
□ All tests passing
□ Documentation complete
□ Code committed
□ No debug artifacts

Release:
□ Git tag created
□ GitHub release published
□ Release notes generated
□ Zip file attached
□ Distribution method ready

Post-Release:
□ Release tested
□ Users notified (if applicable)
□ Documentation website updated (if applicable)
□ Success metrics tracked
```

## Common Issues

### Issue: GitHub Actions Fails

**Possible Causes**:
- Workflow file syntax error
- Missing permissions
- Node.js version issue

**Solutions**:
1. Check Actions tab for error details
2. Verify workflow file syntax
3. Ensure repository has Actions enabled
4. Check required permissions are granted

### Issue: Zip File Not Created

**Possible Causes**:
- Workflow not triggered
- Build script error
- File structure issue

**Solutions**:
1. Verify workflow ran
2. Check build script logs
3. Ensure all required files present
4. Try manual trigger

### Issue: Release Notes Not Generated

**Solutions**:
1. Ensure CHANGELOG.md exists
2. Check format matches conventional commits
3. Use `--notes-file` flag with gh CLI
4. Manually write release notes

## Rollback Procedure

If a release has critical issues:

1. **Patch Release**:
   ```bash
   echo "2.0.2" > VERSION
   git commit -m "fix: rollback issue from v2.0.1"
   git tag v2.0.2
   gh release create v2.0.1 --notes "PATCH RELEASE: Critical bug fix"
   ```

2. **Add Warning**:
   - Update release description
   - Pin to repository README
   - Notify users if needed

3. **Fix in Next Release**:
   - Address underlying issues
   - Thorough testing
   - Gradual rollout

## Security Considerations

- **No Secrets in Code**: Ensure no API keys or passwords in repository
- **Code Review**: All releases should be reviewed before merging
- **Dependency Scanning**: Enable GitHub dependency alerts
- **License Compliance**: Ensure all dependencies are compatible with MIT

## Post-Release

### Monitor

- Watch for issues reported by users
- Monitor GitHub Discussions
- Track metrics (downloads, stars, forks)

### Iterate

- Collect user feedback
- Plan next release
- Update roadmap
- Improve documentation

## Contact

For release-related questions:
- GitHub Issues: [Repository URL]/issues
- GitHub Discussions: [Repository URL]/discussions
- Email: [Maintainer Email]

## References

- [Semantic Versioning](https://semver.org/)
- [GitHub Releases](https://docs.github.com/en/repositories/releasing-projects-on-github)
- [GitHub Actions](https://docs.github.com/en/actions)
- [GitHub CLI](https://cli.github.com/)
