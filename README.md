# SAZ-CCPM: Natural Intelligence for Production Workflows

[![SAZ-CCPM](https://img.shields.io/badge/SAZ--CCPM-v2.0-4b3baf)](https://github.com/VeriVoxAI/saz-ccpm)
[![Claude Code](https://img.shields.io/badge/Works%20with-Claude%20Code-d97757)](https://claude.ai/code)
[![GitHub Issues](https://img.shields.io/badge/Powered%20by-GitHub%20Issues-1f2328)](https://docs.github.com/en/issues)
[![MIT License](https://img.shields.io/badge/License-MIT-28a745)](https://github.com/VeriVoxAI/saz-ccpm/blob/main/LICENSE)

> **Natural conversation, professional execution.** From "I want to build something" to deployed code in production.

SAZ-CCPM combines conversational AI intelligence with battle-tested project management workflows and intelligent service integration. Start with a vague idea, end with production code. No complex commands, no learning curve - just natural conversation that scales from prototype to enterprise.

## 🚀 Quick Start (< 2 minutes)

### 1. Install SAZ-CCPM

```bash
# Navigate to your project
cd /path/to/your/project

# Install (Unix/Linux/macOS)
curl -sSL https://raw.githubusercontent.com/VeriVoxAI/saz-ccpm/main/install/ccpm.sh | bash

# Or Windows (PowerShell)
iwr -useb https://raw.githubusercontent.com/VeriVoxAI/saz-ccpm/main/install/ccpm.bat | iex
```

### 2. Start Building

First, initialize the project management system (one-time setup):
```bash
/pm:init

# This command:
# - Installs GitHub CLI for issue tracking (if needed)
# - Sets up GitHub authentication
# - Creates .claude/ directory structure
# - Installs gh-sub-issue extension for task hierarchies
# - Prepares your project for professional development workflow
```

#### For New Projects (Most Common - Brainstorming-First):
```bash
# After /pm:init, just talk naturally!
"I want to build something with AI for small businesses"

# SAZ-CCPM will:
# - Route to brainstorming-specialist (explores different AI business concepts)
# - Generate 3-5 concepts: AI CRM assistant, inventory optimizer, etc.
# - User selects preferred concept
# - Route to project-manager (PRD → checkpoint for review → tasks)
```

#### For Highly Detailed Requirements (Skip Brainstorming):
```bash
"Implement OAuth 2.0 authentication using Firebase Auth with Google and GitHub 
providers, including JWT token refresh, role-based access control with admin/user 
roles, and session management with 24-hour expiry"

# SAZ-CCPM will:
# - Detect highly detailed spec → route directly to project-manager
# - Create technical PRD, delegate Firebase setup to mcp-handler
# - Create technical PRD → checkpoint for user review → break into tasks
```

#### For Existing Projects (Enhancing/Fixing):
```bash
# After /pm:init, analyze your existing code (optional but recommended)
/context:create

# Then just talk naturally!
"I need user authentication but not sure which approach"

# SAZ-CCPM will:
# - Route to brainstorming-specialist (explores auth approaches)
# - Consider: OAuth providers, magic links, traditional login, etc.
# - User selects approach → project-manager creates implementation plan
```

**Note:** After `/pm:init`, everything else is natural language - just describe what you want!

## 🎯 How It Works

### Natural Language First
Just describe what you want to build. No commands necessary:

```
You: "I need a multi-tenant SaaS with Stripe payments"
SAZ: 💡 Let me explore some concepts for your SaaS platform...
     [Generates 3-5 detailed concepts with competitive analysis]
     [You choose one]
     [Automatically creates PRD and implementation plan]
     [Begins building with specialized agents]
```

### Intelligent Workflow Modes

SAZ-CCPM automatically detects your intent and switches modes:

| Intent Pattern | Triggers | Routing |
|----------------|----------|----------|
| 🚨 **Emergency** | "urgent", "critical", "down", "broken", "production failing" | → code-analyzer OR file-analyzer (immediate) |
| 💡 **Most Projects** | "SaaS dashboard", "e-commerce site", "add auth", "mobile app" | → brainstorming-specialist → project-manager |
| 🎯 **Detailed Specs** | "Implement OAuth 2.0 with Firebase Auth and Google/GitHub providers" | → project-manager (can delegate to mcp-handler) |
| 🔌 **Pure Services** | "Firebase setup", "screenshot [URL]", "YouTube transcript" | → mcp-handler |
| 🔍 **Analysis** | "bug", "error", "trace logic", "code review" | → code-analyzer OR file-analyzer OR test-runner |


## 🎯 When to Brainstorm vs. Skip to Implementation

**Brainstorming triggers** (vague/exploratory):
- "I want to build something with AI"
- "Add authentication but not sure which approach"  
- "Create a dashboard for my users"
- "Build a SaaS for small businesses"

**Skip to implementation** (detailed specs):
- "Implement OAuth 2.0 with Firebase Auth using Google/GitHub providers, JWT refresh tokens, and role-based access control"
- "Add Stripe webhook handling for failed payment notifications with retry logic and email alerts"
- "Create REST API endpoints for user CRUD operations with pagination, filtering, and caching"

**The threshold**: If your request includes specific technologies, implementation details, or technical constraints, it bypasses brainstorming.

## 💡 The Brainstorming-First Approach

### From Vague to Concrete
```
Vague Idea → Brainstorming → Multiple Concepts → Feasibility Analysis → 
Competitive Research → Starting Templates → Choose One → PRD → 
Implementation → Deployed Code
```

### What You Get from Brainstorming:
- **3-5 Concrete Concepts** with technical approaches
- **Competitive Analysis** of existing solutions
- **GitHub Templates** to accelerate development
- **Feasibility Scores** for each option
- **Clear Next Steps** to begin building

Example output:
```markdown
💡 CONCEPT 1: AI-Powered Analytics Dashboard
- Target: Small business owners
- Competitive Advantage: No-code AI insights
- Starting Template: github.com/vercel/analytics-starter
- Feasibility: 85% (2-3 weeks)
- Similar to: Mixpanel but simpler

💡 CONCEPT 2: Team Collaboration Hub
- Target: Remote development teams  
- Competitive Advantage: Built-in AI assistant
- Starting Template: github.com/supabase/team-hub
- Feasibility: 70% (3-4 weeks)
- Similar to: Slack + Jira integrated
```

## 🛠️ Core Capabilities

### Project Management Evolution

| Traditional Dev | Basic AI Coding | SAZ-CCPM |
|-----------------|-----------------|-----------|
| Lost context between sessions | Some memory | **Persistent project state** |
| Serial task execution | Single thread | **10+ parallel agents** |
| Vibe coding from memory | Basic specs | **Brainstorm → Spec → Build** |
| Hidden progress | Chat logs | **GitHub audit trail** |
| Complex commands | Some automation | **90% natural language** |
| Manual service setup | Basic integrations | **Smart MCP gateway** |

## 🔌 MCP Ecosystem Integration

### Context-Efficient Service Operations

Traditional MCP implementations load all services simultaneously, consuming excessive context:
- **Standard approach**: ~5 MCPs loaded = ~10,000 tokens (20% of available context)
- **SAZ-CCPM approach**: Load only required MCP = ~2,000 tokens per operation

**Smart MCP Gateway Benefits:**
- **Intelligent routing**: Automatically detects which service you need
- **Per-request isolation**: Loads only the specific MCP required
- **Auto-discovery**: Finds and configures missing MCPs from community repositories
- **Service orchestration**: Integrates external services within project workflows

### Supported Integrations
- **Authentication**: Firebase Auth, Supabase, Auth0
- **Databases**: Firestore, PostgreSQL, Supabase
- **Deployment**: Vercel, Netlify, Firebase Hosting
- **Media**: Screenshots (Playwright), YouTube transcripts
- **Data**: Web scraping, API integrations, content extraction
- **Communication**: Slack, GitHub, webhook automation

### The Power of Parallel Execution + Service Integration

One "implement authentication" task becomes:
- **Agent 1**: Database schema and migrations
- **Agent 2**: API endpoints and middleware  
- **Agent 3**: Frontend components and forms
- **Agent 4**: Test suites and validation
- **Agent 5**: Documentation and examples
- **MCP Gateway**: Auto-configures Firebase Auth, handles deployment

All running **simultaneously** with **intelligent service orchestration**. A 5-day task completes in 1 day.

### GitHub as the Backbone

Why GitHub Issues?
- **Team Visibility**: Everyone sees AI progress in real-time
- **Human-AI Handoffs**: Seamless collaboration between humans and agents
- **Existing Tools**: Works with your current GitHub workflow
- **Audit Trail**: Complete history from idea to deployment

## 📁 Project Structure

```
your-project/
├── CLAUDE.md            # Project instructions (auto-created)
└── .claude/
    ├── agents/          # Specialized AI agents
    │   ├── brainstorming-specialist.md
    │   ├── project-manager.md      # Workflow orchestrator
    │   ├── mcp-handler.md          # Service integration gateway
    │   ├── file-analyzer.md
    │   ├── code-analyzer.md
    │   ├── test-runner.md
    │   └── [more specialists as needed]
    ├── mcp-config/      # MCP service isolation
    │   ├── firebase.json           # Firebase integration
    │   ├── playwright.json         # Screenshot automation
    │   ├── youtube.json            # Transcript extraction
    │   └── [service-specific configs]
    ├── commands/        # Available commands
    │   ├── pm/          # Project management commands
    │   └── context/     # Context management
    ├── context/         # Project understanding
    │   ├── project-overview.md
    │   ├── tech-context.md
    │   └── [auto-generated context files]
    ├── epics/           # Active development (in .gitignore)
    │   └── [epic-name]/ # Epic workspace
    │       ├── epic.md  # Technical plan
    │       └── [#].md   # Task files
    ├── prds/            # Product requirements
    │   └── [feature].md # Enhanced PRD documents
    ├── rules/           # Workflow automation
    │   ├── workflow-modes.md
    │   ├── complexity-scaling.md
    │   └── saz-*.md     # Natural language rules
    └── scripts/         # Automation scripts
        └── pm/          # PM shell scripts
```

## 📋 Essential Commands

While SAZ-CCPM works primarily through natural language, these commands give you precise control:

### Most Used (Daily)
```bash
/pm:init                 # First-time setup
/pm:status               # Project dashboard
/pm:next                 # What to work on next
/pm:standup              # Daily progress report
```

### Creating Features
```bash
# Natural language (recommended)
"I want to build [your idea]"

# The system automatically:
# - If vague: Runs brainstorming-specialist first
# - If clear: Goes directly to PRD creation
# - Then: /pm:prd-parse to create technical plan

# Or explicit commands:
/pm:prd-new feature           # Create PRD (clear requirements)
/pm:prd-new feature --from-concept path  # Create PRD from brainstormed concept
/pm:prd-new-enhanced feature  # Force comprehensive planning (complex projects)
/pm:prd-parse feature         # Convert PRD to technical plan
/pm:epic-oneshot feature      # Skip PRD for simple tasks
```

### During Development
```bash
/pm:issue-start 123      # Begin work on task
/pm:issue-sync 123       # Update GitHub
/pm:issue-close 123      # Mark complete
/pm:blocked              # Show blockers
```

### Advanced Operations
```bash
/pm:issue-analyze 123         # Find parallel work streams
/pm:epic-start-worktree epic  # Create isolated branch for complex parallel work
/pm:sync                      # Full GitHub synchronization
```

[Full command reference →](#complete-command-reference)

## 🎮 Real-World Examples

### Starting from Scratch
```
You: "I want to build something with AI but not sure what"

SAZ: 💡 Let me explore AI application concepts for you...

Generates:
1. AI Writing Assistant - Like Grammarly but for technical docs
2. AI Code Reviewer - Automated PR analysis  
3. AI Data Pipeline - Smart ETL with anomaly detection

You: "I like the code reviewer idea but simpler"

SAZ: Refining the code reviewer concept for simplicity...
     [Updates concept with MVP approach]
     Ready to create the PRD and start building!
```

### Existing Project Enhancement
```
You: "My React app is slow, help me optimize it"

SAZ: 📂 Let me analyze your React application first...
     [code-analyzer examines performance patterns]
     
     Found issues:
     - Large bundle size (2.4MB)
     - Unnecessary re-renders in Dashboard
     - Missing code splitting
     
     I'll create optimization requirements and implementation plan.
     [project-manager creates PRD with performance improvements]
     
     ✅ Performance optimization PRD created!
     
     **Checkpoint**: Please review the PRD requirements before proceeding:
     - Bundle size optimization strategy
     - React rendering improvements 
     - Code splitting implementation plan
     
     Say "looks good, break into tasks" to continue, or request changes.
```

### Emergency Production Fix
```
You: "URGENT: Payment processing is down in production!"

SAZ: 🚨 Emergency mode - Quick context scan...
     [Detects Node.js project with Stripe integration]
     [Checks recent commits - sees config changes 2 hours ago]
     [file-analyzer examines logs and configs]
     
     Found issue: Stripe API key misconfigured in .env
     
     Fix applied:
     ✅ Updated environment configuration
     ✅ Verified API connectivity 
     ✅ Payment processing restored
     
     Emergency resolved in 3 minutes vs typical 15+ minute investigation.
```

## 🏆 Expected Benefits

SAZ-CCPM is designed to deliver:
- **Minimized context overhead** - Smart MCP gateway + agent delegation
- **Faster delivery** - Parallel execution + automated service integration
- **Enhanced user experience** - Natural conversation with checkpoint workflows
- **Professional workflows** - From brainstorming to production deployment
- **Complete audit trail** - Every decision tracked in GitHub

## 🤝 Working with Teams

SAZ-CCPM scales from solo developers to enterprise teams:

### Solo Developer
- Natural conversation interface
- Automated project management
- No overhead, pure productivity

### Small Teams (2-10)
- Shared GitHub visibility
- Parallel development streams
- Automatic conflict resolution

### Large Teams (10+)
- Multiple Claude instances cooperating
- Department-level epic coordination
- Enterprise GitHub integration

## 🧠 Advanced Features

### Intelligent Mode Detection & Context Management
SAZ-CCPM detects your intent and applies the right workflow:
- **Emergency keywords** → code-analyzer/file-analyzer → immediate fix
- **Vague ideas** → brainstorming-specialist → concept generation
- **Clear requirements** → project-manager → full CCPM workflow
- **External services** → mcp-handler → service integration
- **Existing code** → code-analyzer → analysis and improvements

Context optimization through specialized agents:
- `brainstorming-specialist` for concept generation and exploration
- `project-manager` for workflow orchestration and CCPM commands
- `mcp-handler` for external service integration (context-efficient)
- `code-analyzer` for debugging and code analysis
- `file-analyzer` for logs, configs, and large files
- `test-runner` for test execution and validation
- `parallel-worker` for concurrent task execution
- Smart MCP gateway loads only required services (context-efficient)


### Context Persistence
The system maintains project context across sessions:
- Preserves architectural decisions in `.claude/context/`
- Tracks proven patterns in `.claude/epics/`
- Documents technical choices in PRDs
- Maintains GitHub issue history for audit trail

## 🔧 Configuration

### Customize Workflows
Edit `.claude/rules/workflow-modes.md` to adjust:
- Mode detection keywords
- Agent selection logic
- Parallel execution limits

### Add Custom Agents
Create specialized agents in `.claude/agents/`:
```markdown
---
name: your-custom-agent
tools: Read, Write, Bash
---

You are a specialist in...
```

### Project-Specific Rules
Add instructions to `CLAUDE.md`:
- Coding standards
- Architecture preferences  
- Testing requirements
- Deployment procedures

## 📚 Complete Command Reference

<details>
<summary>Click to expand full command list</summary>

### Setup & Configuration
- `/pm:init` - First-time installation and setup
- `/pm:validate` - Check system integrity
- `/pm:help` - Show command summary

### Product Planning
- `/pm:prd-new [name]` - Create PRD through brainstorming
- `/pm:prd-new-enhanced [name]` - Enhanced PRD with analysis
- `/pm:prd-parse [name]` - Convert PRD to technical epic
- `/pm:prd-list` - List all PRDs
- `/pm:prd-edit [name]` - Modify existing PRD
- `/pm:prd-status [name]` - Implementation status

### Epic Management
- `/pm:epic-decompose [name]` - Break into tasks
- `/pm:epic-sync [name]` - Push to GitHub
- `/pm:epic-oneshot [name]` - Decompose + sync
- `/pm:epic-start [name]` - Launch development
- `/pm:epic-start-worktree [name]` - Create separate branch for parallel agent work
- `/pm:epic-list` - Show all epics
- `/pm:epic-show [name]` - Display details
- `/pm:epic-status [name]` - Progress tracking
- `/pm:epic-close [name]` - Mark complete
- `/pm:epic-merge [name]` - Integrate changes
- `/pm:epic-refresh [name]` - Update from tasks

### Issue Operations
- `/pm:issue-show [id]` - Display issue
- `/pm:issue-start [id]` - Begin work
- `/pm:issue-status [id]` - Check progress
- `/pm:issue-sync [id]` - Update GitHub
- `/pm:issue-close [id]` - Complete task
- `/pm:issue-reopen [id]` - Reactivate
- `/pm:issue-edit [id]` - Modify details
- `/pm:issue-analyze [id]` - Find parallel work

### Workflow Management
- `/pm:next` - Next priority task
- `/pm:status` - Overall dashboard
- `/pm:standup` - Daily report
- `/pm:blocked` - Show blockers
- `/pm:in-progress` - Active work
- `/pm:search [term]` - Find content

### Synchronization
- `/pm:sync` - Full GitHub sync
- `/pm:import` - Import GitHub issues
- `/pm:clean` - Archive completed

### Context Management
- `/context:create` - Analyze project
- `/context:update` - Refresh understanding
- `/context:prime` - Load into memory

</details>

## 🆘 Troubleshooting

### Common Issues

**"Command not found"**
- Run `/pm:init` first
- Check `.claude/commands/` exists

**"Agent not available"**  
- Restart Claude Code: `Ctrl+C` twice, then `claude --resume`
- Check `.claude/agents/` for agent files

**"GitHub sync failed"**
- Verify `gh` CLI is authenticated: `gh auth status`
- Check repository permissions

**"Context overflow"**
- Use parallel agents to distribute work
- Run `/pm:clean` to archive completed tasks

**"Lost context after restart"**
- Run `/context:prime` to reload project understanding
- Then `/pm:status` to see current work
- Continue where you left off

## 🌟 Contributing

SAZ-CCPM is open source and welcomes contributions:

1. Fork the repository
2. Create a feature branch
3. Test your changes thoroughly
4. Submit a pull request

Areas we'd love help with:
- Additional specialized agents
- Language-specific workflows
- Integration templates
- Documentation improvements

## 📄 License

MIT License - see [LICENSE](LICENSE) file

## 🙏 Acknowledgments

SAZ-CCPM builds on:
- [CCPM](https://github.com/automazeio/ccpm) - Original project management system
- [SuperAgent Zero](https://github.com/VeriVoxAI/SuperAgent-Zero) - Conversational AI concepts
- [Claude Code](https://claude.ai/code) - The AI development platform
- GitHub Issues API - Our persistent backend

---

**Ready to ship faster?** [Get started now](#-quick-start--2-minutes) or [explore examples](#-real-world-examples)

*Maintained by [VeriVox AI](https://github.com/VeriVoxAI) | [Report issues](https://github.com/VeriVoxAI/saz-ccpm/issues) | [Star on GitHub](https://github.com/VeriVoxAI/saz-ccpm)*