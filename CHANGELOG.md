# Changelog

## [2.2.1] - 2025-09-10

### Repository Cleanup & Documentation Update

- Removed all legacy "automazeio/ccpm" repository references
- Simplified repository checks to only reference current Gravicity/SAZ-CCPM
- Archived deprecated framework-architect agent (replaced by /saz:evolve command)
- Updated README to v2.2 with current capabilities
- Created private /saz:evolve command for framework evolution workflow
- **Removed prd-new-enhanced command** - Simplified to single adaptive /pm:prd-new command

### Files Modified

- `.claude/scripts/pm/init.sh` - Simplified remote check to only Gravicity/SAZ-CCPM
- `.claude/rules/github-operations.md` - Updated template repo reference  
- `.claude/commands/pm/issue-sync.md` - Updated template repo error message
- `.claude/commands/pm/epic-sync.md` - Updated repository protection check
- `.claude/commands/saz/evolve.md` - Created new framework evolution command
- `.claude/commands/pm/prd-new-enhanced.md` - **Deleted** (functionality merged into prd-new)
- `.claude/agents/brainstorming-specialist.md` - Updated workflow recommendations
- `.claude/rules/workflow-modes.md` - Removed enhanced command references
- `.claude/rules/complexity-scaling.md` - Updated complex/enterprise workflows
- `README.md` - Updated to v2.2, removed obsolete flags and commands
- `.gitignore` - Added znotes/ and .claude/commands/saz/ to private files

## [Unreleased]

### Phase 2: Temporal Awareness ✅
- Updated brainstorming-specialist to search GitHub with current year
- Added package version research to prd-new command 
- Enhanced epic-decompose with latest version checking
- Framework now uses `$(date +%Y)` for current year awareness
- Prevents outdated package recommendations from AI training cutoffs

### Phase 3: Workflow Return Paths ✅
- Added workflow milestones section to CLAUDE.md
- Updated brainstorming-specialist to instruct SAZ (not user) on next commands
- Enhanced code-analyzer with PM return after emergency resolution
- Established clear handoff points for issue management and context updates
- PM now handles edits dynamically (prd/epic/issue) based on user changes

### Phase 4: Adaptive Brainstorming Output ✅
- Brainstorming now scales concept count based on input specificity (1-10 concepts)
- Added format flexibility - template is reference, not requirement
- Output adapts to idea type (technical tool vs consumer app vs API)
- Quality standards updated to reflect adaptive approach
- Removed rigid "minimum 3 concepts" rule

### Phase 5: Research-First Planning with Compatibility Checks ✅
- Added compatibility verification to PRD creation using npm-check-updates
- PRD now requires checking peer dependencies before committing to tech stack
- Added npmpeer.dev as resource for version compatibility checking
- Brainstorming stays focused on ideation (not overburdened with checks)
- WebSearch integration for finding compatibility issues between packages

### Phase 6: File Path Reinforcement ✅
- Emphasized relative paths (./{project-name}/) in epic-decompose
- Added explicit warning against using home directory paths (~/)
- Clarified projects should be created in current workspace
- Updated task template to show proper relative path usage

### Bonus: Simplified Brainstorming → PRD Flow ✅
- Removed complex --from-concept flag requirement
- PRD-new now auto-detects recent concepts by name
- Simplified brainstorming output with clear command examples
- Users can customize during PRD creation (templates, tech stack)

## [v2.2] - In Progress

### Added
- CHANGELOG.md for tracking improvements
- TodoWrite tool to project-manager for workflow setup
- Project assessment logic using `ls` command

### Phase 1: Context Persistence System ✅
- Added persistent state tracking in `.claude/context/project-state.md`
- Enhanced project-manager to check cached state before expensive operations
- Updated init.sh to create and maintain project state file
- Prevents redundant initialization checks across sessions
- Added STATE_CACHED flag to project-manager response pattern
- Session tracking with unique IDs and timestamps

### Feature Improvements
- project-manager now checks PM initialization status:
  - Verifies GitHub CLI installation and authentication
  - Checks for required .claude directories
  - Adds /pm:init to todos if system not initialized
  - Prevents workflow issues before they occur

### Documentation
- Updated README.md to reflect all v2.1 improvements:
  - Two-phase delegation workflow explanation
  - Project subfolder organization
  - PM initialization check feature
  - Testing workflow improvements
  - Updated troubleshooting section

### Changed
- ✅ All requests now route through project-manager first (two-phase approach)
- ✅ project-manager: workflow specialist → initial assessment agent
- ✅ project-manager tools: removed Write, added Grep, LS, TodoWrite
- ✅ Simplified delegation logic in CLAUDE.md
- ✅ Parallel execution references `/pm:epic-start` command

### Phase 2: PRD Improvements ✅
- Added UI/UX Design section to PRD template with:
  - Interface concept and key screens
  - Feature-to-UI mapping table
  - Design references for user-provided screenshots
  - ASCII wireframe examples
- Updated discovery to ask for visual references
- Added Visual Reference Mode to brainstorming-specialist
- Updated quality checks to include UI/UX validation

### Phase 3: File Organization ✅
- Updated install scripts (ccpm.sh and ccpm.bat) to move docs to .claude/saz-docs/
- Added CHANGELOG.md to files moved during installation
- Updated script references (init.sh, help.sh) to new doc location
- Prevents conflicts with user's README.md and LICENSE files

### Phase 4: Testing Enhancements ✅
- Strengthened test-runner delegation in CLAUDE.md
- Added visual delegation pattern showing test flow
- Listed common mistakes to avoid (npm test, pytest directly)
- Added test routing to project-manager for test-related requests

### Phase 5: Project Structure ✅
- Added project structure guidelines to epic-decompose.md
- Created new .claude/rules/project-structure.md
- Updated project-manager with project organization section
- Default behavior: new projects in subfolders (e.g., my-app/)

## [2.0.0] - 2024-09-08
- Initial SAZ-CCPM v2.0 release