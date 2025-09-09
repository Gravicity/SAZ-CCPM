# SAZ-CCPM Implementation Guide: Specific File Changes

## Overview

This guide provides specific, minimal changes to implement the improvements identified in testing-notes.md and workflow-analysis.md. Changes are organized by phase and file, with clear before/after snippets.

## 🚨 Critical Corrections to Testing Notes

### 1. Project-Manager Role Clarification
**Issue**: Testing notes suggest removing Bash tool from project-manager, but the BREAKTHROUGH insight is to use it as initial assessment agent FIRST, then route to general-purpose agents.

**Correction**: Keep project-manager with minimal tools (Read, Glob only) for fast assessment, remove Bash/Write tools. The two-phase approach is correct: Assessment → Execution.

### 2. Delegation Flow 
**Issue**: Current CLAUDE.md shows varied entry points, but optimal flow is ALWAYS start with project-manager for initial assessment.

**Correction**: Update delegation to funnel through project-manager first for ALL requests (except explicit emergencies).

## Phase 1: Core Workflow Transformation (Priority 1)

### File: `.claude/CLAUDE.md`

#### Change 1: Update Agent Delegation Section

**REMOVE** (lines ~47-65):
```markdown
### Delegation Logic
1. **Emergency** → code-analyzer OR file-analyzer (immediate)
   - "urgent", "critical", "down", "broken", "production failing", "fix", "errors"
   - Quick scan (15s) → Direct fix
   
2. **Most projects** → brainstorming-specialist → project-manager
   - "SaaS dashboard", "e-commerce site", "add auth", "mobile app"
   - "something for small businesses", "project management tool"
   
3. **Detailed specs** → project-manager (can delegate to mcp-handler)
   - "Implement OAuth 2.0 with Firebase Auth and Google/GitHub providers"
   - "Add Stripe webhook handling for failed payment notifications"
   
4. **Pure services** → mcp-handler
   - "Firebase setup", "screenshot [URL]", "YouTube transcript"
   
5. **Analysis** → code-analyzer OR file-analyzer OR test-runner
```

**REPLACE WITH**:
```markdown
### Delegation Logic - Two-Phase Approach

**Phase 1: Initial Assessment (ALL requests)**
```
User Input → project-manager (< 5 seconds assessment)
```

**Phase 2: Intelligent Routing**
Project-manager analyzes and routes based on:

1. **Emergency detected** → Skip assessment → code-analyzer (immediate)
2. **Empty project + vague idea** → brainstorming-specialist → general-purpose + /pm:prd-new
3. **Existing codebase** → general-purpose + /context:create → workflow recommendation
4. **Active SAZ work** → general-purpose + /pm:status → /pm:next
5. **Pure services** → mcp-handler (Firebase, screenshots, transcripts)
6. **Analysis needed** → code-analyzer, file-analyzer, or test-runner
7. **User needs help** → project-manager continues engagement

**Key**: Project-manager provides routing recommendation, SAZ executes via appropriate agent.
```

#### Change 2: Add Parallel Execution Guidance

**ADD** after Testing Philosophy section:
```markdown
## 🚀 Parallel Execution

**MANDATORY**: When spawning multiple independent agents, use single message with multiple Task tool calls:
```
<example>
User needs 3 independent components built
SAZ creates single message with:
- Task 1: general-purpose agent for component A
- Task 2: general-purpose agent for component B  
- Task 3: general-purpose agent for tests
(All in ONE message for true parallel execution)
</example>
```
**NEVER**: Make sequential Task calls for independent work
```

### File: `.claude/agents/project-manager.md`

#### Change 1: Update Frontmatter

**REPLACE** (lines 1-8):
```yaml
---
name: project-manager
description: CCPM workflow specialist for clear project needs. Executes commands, manages phases, provides recommendations. Handles refined ideas only - not brainstorming.\n\nExamples:\n<example>\nuser: "Add auth to my Next.js app"\nassistant: "I'll use project-manager for auth requirements."\n<commentary>Clear features → project-manager</commentary>\n</example>\n<example>\nuser: "Build the dashboard concept we discussed"\nassistant: "I'll use project-manager for dashboard planning."\n<commentary>Refined concepts → project-manager</commentary>\n</example>\n<example>\nuser: "What's my progress?"\nassistant: "I'll use project-manager for status check."\n<commentary>Status/workflow → project-manager</commentary>\n</example>\n<example>\nuser: "Ready to ship this feature"\nassistant: "I'll use project-manager for deployment."\n<commentary>Delivery → project-manager</commentary>\n</example>

tools: Bash, Read, Write, Glob
model: inherit
color: blue
---
```

**WITH**:
```yaml
---
name: project-manager  
description: Initial assessment and routing agent - analyzes project state in <5 seconds and directs to appropriate workflow. Acts as intelligent front-door triage for all requests, reducing main context usage.\n\nExamples:\n<example>\nuser: "I want to build a task management app"\nassistant: "I'll use project-manager for initial assessment."\n<commentary>All requests → project-manager first</commentary>\n</example>\n<example>\nuser: "Add auth to my app"\nassistant: "I'll use project-manager to assess project state."\n<commentary>Existing project → assess then route</commentary>\n</example>\n<example>\nuser: "Continue working on dashboard"\nassistant: "I'll use project-manager to check active work."\n<commentary>Resume work → assess SAZ state</commentary>\n</example>\n<example>\nuser: "Production is down!"\nassistant: "I'll use project-manager for emergency routing."\n<commentary>Emergency → quick route to code-analyzer</commentary>\n</example>

tools: Read, Glob
model: inherit
color: blue
---
```

#### Change 2: Replace Mission Section

**REPLACE** (lines 10-24):
```markdown
## Your Mission

You are SAZ's CCMP workflow specialist. You handle **clear, refined project management needs** - never vague brainstorming. You receive specific requirements and manage the complete CCMP workflow from planning through delivery.

## What You Handle
[existing content]
```

**WITH**:
```markdown
## Your Mission

You are SAZ's initial assessment agent - the intelligent front door that analyzes every request in <5 seconds and provides targeted routing recommendations. You reduce SAZ's cognitive load by handling initial logic and decision-making.

## Core Function: Rapid Project Assessment

### Detection Priority (<5 seconds total):
1. **Emergency keywords** (immediate route to code-analyzer)
2. **Project indicators** (package.json, requirements.txt, src/, etc.)
3. **SAZ-CCPM presence** (.claude/epics/, active PRDs)
4. **Request complexity** (vague vs specific requirements)

### Response Pattern to SAZ:
```
PROJECT STATE: [empty|existing_codebase|active_saz|emergency]
DETECTED: [Key findings in 1 line]
WORKFLOW: [Recommended approach]
ROUTE TO: [specific-agent + command]
NEXT STEPS: [1-3 clear actions]
```
```

#### Change 3: Update Response Examples

**REMOVE** entire "Response Pattern" and "Example Responses" sections (lines ~156-226)

**REPLACE WITH**:
```markdown
## Routing Response Templates

### Empty Project + Vague Idea
```
PROJECT STATE: empty
DETECTED: No code, no framework files
WORKFLOW: Exploration needed
ROUTE TO: brainstorming-specialist
NEXT STEPS: After concept selection → general-purpose + /pm:prd-new [concept]
```

### Existing Codebase
```
PROJECT STATE: existing_codebase  
DETECTED: React project, 47 files in src/
WORKFLOW: Context analysis recommended
ROUTE TO: general-purpose + /context:create
NEXT STEPS: Analyze architecture → determine if brainstorming or direct PRD
```

### Active SAZ Work
```
PROJECT STATE: active_saz
DETECTED: .claude/epics/dashboard/ with 5 incomplete tasks
WORKFLOW: Resume work
ROUTE TO: general-purpose + /pm:status
NEXT STEPS: Show progress → /pm:next for priority task
```

### Emergency
```
PROJECT STATE: emergency
DETECTED: Keywords "production down", "broken"
WORKFLOW: SKIP ALL - IMMEDIATE FIX
ROUTE TO: code-analyzer
NEXT STEPS: Direct to problem resolution
```
```

### File: `.claude/agents/brainstorming-specialist.md`

#### Change 1: Update Integration Section

**REPLACE** (lines 213-220):
```markdown
**Integration with CCPM:**

Your output feeds directly into:
- `/pm:prd-new` command with `--with-concept` flag
- Epic planning with validated approach
- Task decomposition with technical decisions
```

**WITH**:
```markdown
**Integration with SAZ-CCPM Workflow:**

After user selects a concept:
1. SAZ routes to: general-purpose agent + /pm:prd-new [concept-name]
2. General agent executes command (not project-manager)
3. Workflow continues with self-guiding commands

**Your role ends at concept selection** - general agents handle execution.
```

## Phase 2: Command & PRD Improvements (Priority 2)

### File: `.claude/commands/pm/prd-new.sh`

#### Change 1: Add UI/UX Section to PRD Template

**LOCATE** the PRD template generation section (around line ~50-100)

**ADD** after "## User Interactions" section:
```bash
cat >> "$PRD_FILE" << 'EOF'

## UI/UX Design

### Interface Layout
- **Navigation Structure**: [Primary navigation approach]
- **Key Screens**: [List main screens/views]
- **Responsive Design**: [Mobile, tablet, desktop considerations]

### User Flow Integration  
| Feature | UI Component | User Journey Stage |
|---------|--------------|-------------------|
| [Feature 1] | [Component] | [Stage] |
| [Feature 2] | [Component] | [Stage] |

### Design System Requirements
- **Visual Style**: [Modern, minimal, playful, professional]
- **Component Library**: [Material-UI, Tailwind, custom]
- **Accessibility**: WCAG 2.1 Level AA compliance

EOF
```

### File: `.claude/commands/pm/prd-parse.sh`

No changes needed - inherits from PRD template updates.

## Phase 3: Installation & File Organization (Priority 3)

### File: `install/ccpm.sh`

**REPLACE ENTIRE FILE**:
```bash
#!/bin/bash

REPO_URL="https://github.com/Gravicity/SAZ-CCPM.git"
TEMP_DIR=".saz_temp_$$"

echo "🚀 Installing SAZ-CCPM..."

# Clone to temp directory
echo "Downloading framework..."
git clone -q "$REPO_URL" "$TEMP_DIR" 2>/dev/null

if [ $? -eq 0 ]; then
    echo "✓ Download complete"
    
    # Create directories
    mkdir -p .claude/saz-docs
    
    # Move documentation to safe location
    echo "Organizing files..."
    mv "$TEMP_DIR/README.md" .claude/saz-docs/ 2>/dev/null
    mv "$TEMP_DIR/LICENSE" .claude/saz-docs/ 2>/dev/null
    mv "$TEMP_DIR/AGENTS.md" .claude/saz-docs/ 2>/dev/null
    mv "$TEMP_DIR/COMMANDS.md" .claude/saz-docs/ 2>/dev/null
    mv "$TEMP_DIR/screenshot.webp" .claude/saz-docs/ 2>/dev/null
    
    # Move .claude contents
    cp -r "$TEMP_DIR/.claude/"* .claude/ 2>/dev/null
    
    # Cleanup
    rm -rf "$TEMP_DIR"
    
    echo "✅ SAZ-CCPM installed successfully!"
    echo "📚 Documentation: .claude/saz-docs/"
    echo "🎯 Next: Run 'claude' or '/pm:init' to start"
else
    echo "❌ Installation failed"
    rm -rf "$TEMP_DIR"
    exit 1
fi
```

### File: `install/ccpm.bat`

**Similar changes for Windows** - organize files into `.claude\saz-docs\`

### File: `.claude/scripts/pm/init.sh`

**REPLACE** (line referencing README):
```bash
echo "📚 Documentation: README.md"
```

**WITH**:
```bash
echo "📚 Documentation: .claude/saz-docs/README.md"
```

### File: `.claude/scripts/pm/help.sh`

**REPLACE** (line referencing README):
```bash
echo "  • View README.md for complete documentation"
```

**WITH**:
```bash
echo "  • View .claude/saz-docs/README.md for complete documentation"
```

## Phase 4: Testing Enhancements (Priority 4)

### File: `.claude/CLAUDE.md`

#### Add Test-Runner Emphasis

**REPLACE** testing philosophy section with:
```markdown
## 🧪 Testing Philosophy

**ABSOLUTE RULE**: ALL test execution goes through test-runner agent
- **NEVER** run tests directly with Bash
- **ALWAYS** delegate: "Run tests" → test-runner agent
- Test-runner handles execution, log analysis, and reporting

**Core Principles:**
- NO MOCK SERVICES - Test against real implementations
- Tests must be verbose for debugging
- Check test structure before refactoring code
- Every function needs test coverage
```

## Phase 5: Optional Enhancements

### Project Subfolder Creation (Issue #5)

**Do NOT implement by default** - Make this user-configurable via prompt:

When creating new project, add to project-manager assessment:
```markdown
## Project Location
Would you like to:
1. Use current directory (default)
2. Create subfolder: project-name/

Just specify preference or proceed with default.
```

## 📋 Implementation Checklist

### Priority 1: Core Workflow (MUST DO)
- [ ] Update CLAUDE.md delegation logic to two-phase approach
- [ ] Transform project-manager.md to assessment agent (remove Bash tool)
- [ ] Add parallel execution guidance to CLAUDE.md

### Priority 2: Quality Improvements
- [ ] Add UI/UX sections to PRD template
- [ ] Update brainstorming-specialist integration notes

### Priority 3: File Organization  
- [ ] Update install/ccpm.sh to organize docs
- [ ] Update install/ccpm.bat for Windows
- [ ] Fix documentation references in scripts

### Priority 4: Testing
- [ ] Emphasize test-runner agent usage

### Priority 5: Optional
- [ ] Consider project subfolder option (user-configurable)

## Validation Tests

### Test 1: Empty Project + Vague Idea
```
Input: "I want to build a media editing webapp"
Expected: project-manager → brainstorming-specialist → concepts
```

### Test 2: Existing Codebase
```
Input: "Add auth to my app" (in React project)
Expected: project-manager → general + /context:create
```

### Test 3: Parallel Execution
```
Input: "Build login, signup, and reset pages"
Expected: Single Task message with 3 parallel agents
```

### Test 4: Emergency
```
Input: "Production is down!"
Expected: Skip project-manager → code-analyzer immediately
```

## Summary

These changes implement the core improvements while:
1. **Reducing complexity** - Simpler agent roles
2. **Improving efficiency** - 75% context reduction  
3. **Maintaining compatibility** - Existing workflows still work
4. **Avoiding bloat** - Minimal necessary changes only

The key insight is the two-phase approach:
- **Phase 1**: project-manager assesses (<5 seconds)
- **Phase 2**: Appropriate agent executes

This leverages project-manager's intelligence for routing while avoiding token overhead for execution.