#!/bin/bash

echo "Initializing..."
echo ""
echo ""

echo "███████╗ █████╗ ███████╗       ██████╗ ██████╗██████╗ ███╗   ███╗"
echo "██╔════╝██╔══██╗╚══███╔╝      ██╔════╝██╔════╝██╔══██╗████╗ ████║"
echo "███████╗███████║  ███╔╝ █████╗██║     ██║     ██████╔╝██╔████╔██║"
echo "╚════██║██╔══██║ ███╔╝  ╚════╝██║     ██║     ██╔═══╝ ██║╚██╔╝██║"
echo "███████║██║  ██║███████╗      ╚██████╗╚██████╗██║     ██║ ╚═╝ ██║"
echo "╚══════╝╚═╝  ╚═╝╚══════╝       ╚═════╝ ╚═════╝╚═╝     ╚═╝     ╚═╝"

echo "┌──────────────────────────────────────────┐"
echo "│ SAZ-Enhanced Claude Code PM              │"
echo "│ Natural Intelligence for Production Work │"
echo "└──────────────────────────────────────────┘"
echo "https://github.com/Gravicity/SAZ-CCPM"
echo ""
echo ""

echo "🚀 Initializing SAZ-CCPM System"
echo "======================================"
echo ""

# Check for required tools
echo "🔍 Checking dependencies..."

# Check gh CLI
if command -v gh &> /dev/null; then
  echo "  ✅ GitHub CLI (gh) installed"
else
  echo "  ❌ GitHub CLI (gh) not found"
  echo ""
  echo "  Installing gh..."
  if command -v brew &> /dev/null; then
    brew install gh
  elif command -v apt-get &> /dev/null; then
    sudo apt-get update && sudo apt-get install gh
  else
    echo "  Please install GitHub CLI manually: https://cli.github.com/"
    exit 1
  fi
fi

# Check gh auth status
echo ""
echo "🔐 Checking GitHub authentication..."
if gh auth status &> /dev/null; then
  echo "  ✅ GitHub authenticated"
else
  echo "  ⚠️ GitHub not authenticated"
  echo "  Running: gh auth login"
  gh auth login
fi

# Check for gh-sub-issue extension
echo ""
echo "📦 Checking gh extensions..."
if gh extension list | grep -q "yahsan2/gh-sub-issue"; then
  echo "  ✅ gh-sub-issue extension installed"
else
  echo "  📥 Installing gh-sub-issue extension..."
  gh extension install yahsan2/gh-sub-issue
fi

# Create directory structure
echo ""
echo "📁 Creating directory structure..."
mkdir -p .claude/prds
mkdir -p .claude/epics
mkdir -p .claude/rules
mkdir -p .claude/agents
mkdir -p .claude/scripts/pm
mkdir -p .claude/context
echo "  ✅ Directories created"

# Create or update project state file
echo ""
echo "📄 Initializing project state..."
state_file=".claude/context/project-state.md"
current_time=$(date '+%Y-%m-%d %H:%M:%S')
session_id="init_$(date '+%Y%m%d_%H%M%S')"

# Check current state
gh_auth_status="false"
if gh auth status &> /dev/null; then
  gh_auth_status="true"
fi

# Update state file
cat > "$state_file" << EOF
# Project State Persistence

This file tracks the persistent state of the SAZ-CCPM project to prevent redundant initialization checks.

## Initialization Status

- **PM_SYSTEM_INITIALIZED**: true
- **LAST_INIT_CHECK**: $current_time
- **GH_CLI_AUTHENTICATED**: $gh_auth_status
- **DIRECTORIES_CREATED**: true
- **PROJECT_TYPE**: unknown
- **LAST_ASSESSMENT**: never

## Project Analysis Cache

- **CODEBASE_TYPE**: unknown
- **HAS_PACKAGE_JSON**: false
- **HAS_SRC_DIR**: false
- **HAS_CLAUDE_EPICS**: true
- **HAS_CLAUDE_PRDS**: true
- **ACTIVE_EPICS**: []
- **LAST_FILE_SCAN**: never

## Session Tracking

- **CURRENT_SESSION_ID**: $session_id
- **LAST_SESSION_DATE**: $current_time
- **INITIALIZATION_COMPLETED_SESSIONS**: [$session_id]

---

## State Update Instructions

This file should be updated by:
1. \`project-manager.md\` during assessment phases
2. \`.claude/scripts/pm/init.sh\` during initialization
3. Other agents when making structural changes

Format for updates:
- Use key-value pairs with consistent naming
- Include timestamps for time-sensitive data
- Keep boolean values as true/false
- Use "unknown"/"never" for uninitialized values
EOF

echo "  ✅ Project state initialized"

# Copy scripts if in main repo
if [ -d "scripts/pm" ] && [ ! "$(pwd)" = *"/.claude"* ]; then
  echo ""
  echo "📝 Copying PM scripts..."
  cp -r scripts/pm/* .claude/scripts/pm/
  chmod +x .claude/scripts/pm/*.sh
  echo "  ✅ Scripts copied and made executable"
fi

# Check for git
echo ""
echo "🔗 Checking Git configuration..."
if git rev-parse --git-dir > /dev/null 2>&1; then
  echo "  ✅ Git repository detected"

  # Check remote
  if git remote -v | grep -q origin; then
    remote_url=$(git remote get-url origin)
    echo "  ✅ Remote configured: $remote_url"
    
    # Check if remote is the CCPM/SAZ-CCPM template repository
    if [[ "$remote_url" == *"Gravicity/SAZ-CCPM"* ]] || [[ "$remote_url" == *"Gravicity/SAZ-CCPM.git"* ]]; then
      echo ""
      echo "  ⚠️ WARNING: Your remote origin points to the SAZ-CCPM template repository!"
      echo "  This means any issues you create will go to the template repo, not your project."
      echo ""
      echo "  To fix this:"
      echo "  1. Fork the repository or create your own on GitHub"
      echo "  2. Update your remote:"
      echo "     git remote set-url origin https://github.com/YOUR_USERNAME/YOUR_REPO.git"
      echo ""
    fi
  else
    echo "  ⚠️ No remote configured"
    echo "  Add with: git remote add origin <url>"
  fi
else
  echo "  ⚠️ Not a git repository"
  echo "  Initialize with: git init"
fi

# Create CLAUDE.md if it doesn't exist
if [ ! -f "CLAUDE.md" ]; then
  echo ""
  echo "📄 Creating CLAUDE.md..."
  cat > CLAUDE.md << 'EOF'
# CLAUDE.md

> Think carefully and implement the most concise solution that changes as little code as possible.

## Project-Specific Instructions

Add your project-specific instructions here.

## Testing

Always run tests before committing:
- `npm test` or equivalent for your stack

## Code Style

Follow existing patterns in the codebase.
EOF
  echo "  ✅ CLAUDE.md created"
fi

# Summary
echo ""
# Final state update
echo ""
echo "🔄 Finalizing project state..."
if [ -f "$state_file" ]; then
  # Update PM_SYSTEM_INITIALIZED to true since init completed successfully
  sed -i'' -e "s/PM_SYSTEM_INITIALIZED.*/PM_SYSTEM_INITIALIZED**: true/g" "$state_file"
  sed -i'' -e "s/GH_CLI_AUTHENTICATED.*/GH_CLI_AUTHENTICATED**: $gh_auth_status/g" "$state_file"
  echo "  ✅ State file updated with initialization results"
fi

echo ""
echo "✅ Initialization Complete!"
echo "=========================="
echo ""
echo "📊 System Status:"
gh --version | head -1
echo "  Extensions: $(gh extension list | wc -l) installed"
echo "  Auth: $(gh auth status 2>&1 | grep -o 'Logged in to [^ ]*' || echo 'Not authenticated')"
echo "  State: Persistent context enabled"
echo ""
echo "🎯 Next Steps:"
echo "  1. Create your first PRD: /pm:prd-new <feature-name>"
echo "  2. View help: /pm:help"
echo "  3. Check status: /pm:status"
echo ""
echo "📚 Documentation: .claude/saz-docs/README.md"

echo ""
echo "🧠 Context Persistence Active: Future project-manager calls will be faster!"
exit 0
