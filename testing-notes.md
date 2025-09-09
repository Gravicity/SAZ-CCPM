# SAZ-CCPM Testing Notes & Recommendations

Context: I tested our latest updates to the SAZ-CCPM framework with a friend. Here are the following issues I noticed with detailed recommendations for each.

## Issue 1: Brainstorming vs PRD Threshold Logic

**Problem**: When giving SAZ the following prompt, it immediately jumped straight to suggesting it would create the PRD which was not what we wanted. We need to be more precise about our logic when to either use brainstorming-specialist agent, vs jumping ahead to PRD creation with project-manager. 

**Test Prompt**: "i want to create simple media editing webapp that allows me to trim, split, fuse videos together, drag and drop media files into editor field, deatach audio from video, on video track i should see the audio wave, i should be able to zoom in and out the track, and i should be able to export all media files together or separate, and the webapp should look like capcut."

**Original Suggestions**:
a. I suggest we invoke a higher requirement of detail and specifications before skipping the brainstorming agent. If unclear, we could SAZ follow up by asking if we would like to brainstorm first, or go straight to generating the PRD.
b. As an alternative option, I am thinking we should create a new command that the user can use to improve their first prompt (like above) into a much better, well structured prompt, even when using for brainstorming. We could look to examples of prompts from prompt libraries (available on github) that can influence, improve the users intitial prompt. This too could be automatically recommended.

### 🔧 Recommendations

1. **Strengthen threshold criteria** in CLAUDE.md: Feature lists ≠ technical specifications
2. **Add ambiguity detection**: When unclear between "Most projects" vs "Detailed specs", ask user: "Would you like me to explore different approaches first (brainstorming) or create implementation plan directly (PRD)?"
3. **Create `/enhance-prompt` command**: Takes user's initial prompt and improves it using prompt library patterns for better brainstorming input
4. **Update delegation examples**: Add "media editing webapp with trim/split features" → brainstorming-specialist (feature-rich but no tech specs)

**Analysis**: The user's media editing webapp prompt was feature-rich but lacked technical implementation details. According to our delegation logic, this should have triggered brainstorming-specialist, not direct PRD creation. The threshold between "Most projects" and "Detailed specs" isn't clear enough.

---

## Issue 2: Project-Manager Command Execution Problems

**Problem**: I noticed that the specialized agents (project-manager) did not seem to run the commands properly. It however, did a good job at telling the user what command to use next. When copying and posting the prompt, it seemed to keep SAZ on track, which did a good job at delegating the work to general agents (minimizing use of context window). I am thinking that project-manager needs to be revised so that instead of trying to run the commands itself, it simply just guides the user through the process, providing next steps to both the user, and SAZ. I am wondering, if project-manager tells SAZ what to do next (ei. use this command to continue: /pm:prd-new [concept-name]), then perhaps SAZ can run the commands itself? Or does the user have to use it for it to actually work? This is something to consider, but for now, we need at minimum, revise project-manager so that it's not trying to run the command itself, but instead, guides the user through the process, which it did overall quite well once it was stopped from attempting to do the work itself.

### 🔧 FINAL Recommendations (Revolutionary Discovery)

**🚨 BREAKTHROUGH INSIGHTS**: 
1. **General-purpose agents can execute `/pm:` commands directly** with full access to `.claude/commands/`
2. **Project-manager is PERFECT as initial assessment agent** to reduce SAZ's cognitive load

#### **The Optimal Two-Phase Approach**:

### **Phase 1: Initial Assessment (project-manager)**
Use project-manager as the **front-door triage agent** that:
- **Detects existing projects** via framework files (package.json, requirements.txt, etc.)
- **Assesses project complexity** by checking src/, test/, and other code directories
- **Identifies project type** (React, Python, etc.) for tailored suggestions
- **Determines appropriate workflow** (brainstorming vs context analysis vs resume)
- **Offloads initial logic** from SAZ (reduces main context usage)
- **Provides targeted routing** to general-purpose agents

**Key Insight**: Don't rely on `.claude/` existence for project detection since we create it on install. Instead, look for:
- Framework indicators: package.json, requirements.txt, Cargo.toml, go.mod, etc.
- Code structure: src/, app/, lib/, test/ directories
- Version control: .git/ directory
- File density: More than just .claude/ and a few files

### **Phase 2: Efficient Execution (general-purpose agents)**
After initial assessment, route to general-purpose agents for:
- **Command execution**: `/pm:prd-new`, `/pm:epic-decompose`, etc.
- **~75% context reduction**: 100 tokens vs 460 tokens per command
- **Self-guided workflows**: Commands provide built-in next steps

### **Routing Logic**:

```
ALWAYS START: User Input → project-manager (initial assessment)

Then project-manager routes based on analysis:
- Empty folder + vague → brainstorming-specialist → general + /pm:prd-new
- Existing code + no SAZ → general + /context:create → /pm:init
- Active SAZ project → general + /pm:status → /pm:next
- Emergency → code-analyzer (immediate)
- User needs help → project-manager stays engaged
```

### **Key Benefits**:
1. **Reduced SAZ context** - Initial logic offloaded to project-manager
2. **Intelligent routing** - Right workflow for each scenario
3. **Efficient execution** - General agents handle commands
4. **Help when needed** - Project-manager available for guidance

**Analysis**: Project-manager as initial assessment agent + general-purpose for execution = optimal efficiency. This leverages project-manager's intelligence for routing while avoiding its token overhead for routine execution.

---

## Issue 3: PRD Quality and UI/UX Integration

**Problem**: I feel like our prd:new and/or prd:parse and/or prd:decompose, needs to do a better job at seeing the development through, or be more thoughtful of the user interface at later stages, such that it ensures that each function/process/features it create are all carefully tied into the new user interface/website/UI, giving a bit more detail to how all features created come together to create the UI/UX of the software/app/website. Perhaps we can do some research into what makes a good quality prd and ensure our process from prd:new creation to epic-decompose, is not lacking or losing detail from idea>prd>decompose into seperate issues.

### 🔧 Recommendations

1. **Add UI/UX Design section** to PRD template:
   - Interface layout specifications  
   - User flow diagrams connecting all features
   - Key screen mockups/wireframes
   - Design system requirements
2. **Feature-to-UI mapping table** showing how each function integrates
3. **User Journey Integration** section connecting features into complete workflows  
4. **Research industry PRD templates** for UI/UX best practices
5. **Add design deliverables** to implementation roadmap

**Analysis**: Current PRD structure lacks comprehensive UI/UX integration sections. It mentions "user interactions" and "user flows" but doesn't tie features together into cohesive interface design. Features aren't connected to unified user experience.

---

## Issue 4: Installation Script File Organization

**Problem**: When using the install scripts, we need to revise it so that all files from the repo, that sit in the root folder (like AGENTS.md, COMMANDS.md, LICENSE, README.md, screenshot.webp) all get put into a folder under .claude/saz-docs/ to avoid conflicts with either pre-existing software/files, and or, when installing other packages/frameworks that have similarly named files causing conflicts.

### 🔧 Recommendations

1. **Modify installation scripts** to create `.claude/saz-docs/` directory
2. **Move documentation files** during installation:
   - AGENTS.md → `.claude/saz-docs/AGENTS.md`
   - COMMANDS.md → `.claude/saz-docs/COMMANDS.md`  
   - LICENSE → `.claude/saz-docs/LICENSE.md`
   - README.md → `.claude/saz-docs/README.md`
   - screenshot.webp → `.claude/saz-docs/screenshot.webp`
3. **Update file references** in init.sh and other scripts
4. **Keep `.claude/` structure** in project root as designed

**Analysis**: Current installation script clones all files to project root, potentially conflicting with existing project files (README.md, LICENSE, etc.). Documentation files need better organization to prevent conflicts.

---

## Issue 5: Project Structure and Subfolder Organization

**Problem**: When creating a new project, and installing the recommended packages, they should always go into a new subfolder under the root project folder. ei project-folder-root/project-name/. This would help keep the project's root folder more organized, and allow for development of multiple ideas. The only issue with doing it this way is I've sometimes noticed that CLAUDE will be in one folder, and forget that it needs to move around or CD into another folder. Though it usually figures it out and cd's into correct folder.

### 🔧 Recommendations

1. **Add optional project folder creation** to workflow
2. **Make it user-configurable**: Ask "Create project in subfolder or current directory?"
3. **Enhance directory awareness** in commands and agents
4. **Create navigation helpers** for Claude with clear directory context
5. **Add directory validation** before command execution
6. **Consider hybrid approach**: Default to current directory, offer subfolder option

**Analysis**: Currently SAZ-CCPM works directly in the current directory without creating project-specific subfolders. User suggests organizing multiple projects in dedicated subfolders for better organization, but this introduces directory navigation complexity.

---

## Issue 6: Parallel Execution Not Working Properly

**Problem**: I noticed that when SAZ says it will run multiple agents in "parallel" for issues/tasks that is considered safe to do so, it tends to only do one task at a time (sequential). We might need to strengthen the language around this and perhaps too the project manager can help with its output (when suitable) to ensure that SAZ actually runs multiple general agents (task) simultaneously.

### 🔧 Recommendations

1. **Strengthen parallel execution language** in CLAUDE.md with explicit Task tool batching guidance
2. **Add parallel Task tool examples**: Show proper syntax for simultaneous tool calls
3. **Enhance project-manager output** to explicitly guide SAZ: "Execute these 3 agents simultaneously using batched Task tool calls"
4. **Add parallel execution validation**: Confirm multiple agents actually running at same time  
5. **Create parallel execution templates** showing correct implementation patterns
6. **Update agent descriptions** to emphasize parallel capabilities where appropriate

**Analysis**: Extensive parallel execution documentation exists (parallel-worker agent, task frontmatter with parallel fields, coordination rules), but actual execution is sequential despite claims of parallel operation. SAZ makes sequential Task tool calls instead of parallel ones, creating a gap between documented capability and actual execution.

---

## 🎯 Implementation Priority

### **Critical (Affects Core Functionality)**
- **Issue #1**: Brainstorming vs PRD threshold logic
- **Issue #2**: Project-manager command execution problems  
- **Issue #6**: Parallel execution not working properly

### **Important (User Experience)**
- **Issue #3**: PRD quality and UI/UX integration
- **Issue #4**: Installation script file organization

### **Enhancement (Nice-to-Have)**
- **Issue #5**: Project structure and subfolder organization

## 🔗 Interdependency Analysis

### **Critical Path Dependencies**:

**Issue #1 ↔ Issue #2**: Brainstorming threshold logic directly depends on project-manager guidance
- Project-manager should help SAZ determine brainstorming vs PRD routing
- If project-manager can't execute commands, it must provide clear routing guidance
- **Solution**: Project-manager outputs routing recommendations to SAZ

**Issue #2 ↔ Issue #6**: Project-manager orchestration affects parallel execution
- Project-manager needs to guide SAZ toward parallel Task tool usage
- Removing Bash tool from project-manager requires enhanced guidance output
- **Solution**: Project-manager provides explicit parallel execution instructions

**Issue #3 → Issue #1**: Enhanced PRD quality affects brainstorming decisions
- Better UI/UX integration in PRDs means higher threshold for skipping brainstorming
- More comprehensive PRDs require more detailed input specifications
- **Solution**: Update threshold criteria to account for UI/UX requirements

### **Implementation Order Dependencies (REVISED)**:

1. **Issue #2 FIRST** (Delegation Logic Overhaul) 
   - Transform delegation from `project-manager` → `general-purpose + commands`
   - Most critical efficiency improvement (~75% context reduction)
   - Foundation for all other optimizations

2. **Issue #1 SECOND** (Brainstorming Threshold)
   - Update routing: `brainstorming-specialist` → `general-purpose + /pm:prd-new`
   - Depends on new delegation patterns from Issue #2
   - Sets up proper workflow entry points

3. **Issue #6 THIRD** (Parallel Execution)
   - Enhance general-purpose agents to use parallel Task tool calls
   - Much simpler with general agents vs specialized project-manager
   - Can leverage command self-guidance for parallel workflows

4. **Issues #3-5 PARALLEL** (Quality & Organization)
   - Independent of core workflow logic changes
   - Can be implemented simultaneously with delegation improvements
   - Don't affect the new agent routing patterns

### **Conflict Analysis**:

**No Direct Conflicts Identified** - All issues address separate concerns:
- Issue #1: Input routing logic
- Issue #2: Agent execution model
- Issue #3: Content quality
- Issue #4: File organization
- Issue #5: Directory structure
- Issue #6: Performance optimization

### **Synergistic Effects**:

**Issues #1 + #3**: Better brainstorming threshold + Enhanced PRD quality = More targeted requirement gathering

**Issues #2 + #6**: Orchestration guidance + Parallel execution = Efficient workflow management

**Issues #4 + #5**: File organization + Directory structure = Clean project setup

## 📋 Detailed Implementation Plan (REVISED)

### **Phase 1: Project-Manager as Initial Assessment Agent**
**Timeline**: 1-2 days
**Focus**: Transform project-manager into intelligent front-door triage agent

#### **1.1 Issue #2: Project-Manager Transformation**
- [ ] **Transform project-manager to Initial Assessment Agent**:
  - Keep minimal tools: Read, Glob (for project detection)
  - Remove Bash tool completely
  - Update description: "Initial assessment and routing agent - analyzes project state and directs workflow"
  - Add efficient project detection logic (< 5 seconds)
  
- [ ] **Implement Smart Project Detection**:
  ```
  Check for framework files: package.json, requirements.txt, Cargo.toml, go.mod, etc.
  Check for code directories: src/, app/, lib/, test/, public/, etc.
  Assess project complexity: file count, directory structure
  Identify project type: React, Python, Rust, etc.
  ```

- [ ] **Update CLAUDE.md delegation to always start with project-manager**:
  ```
  ALL REQUESTS → project-manager (initial assessment) → routing decision:
    - Empty project + vague → brainstorming-specialist → general + /pm:prd-new
    - Existing code → general + /context:create → workflow recommendation
    - Active SAZ work → general + /pm:status → /pm:next
    - Emergency → code-analyzer (immediate)
    - User needs help → project-manager continues engagement
  ```

- [ ] **Define clear routing responses for SAZ**:
  ```markdown
  PROJECT STATE: [empty|existing_codebase|active_saz|saz_only|emergency]
  DETECTED: [Project type, complexity, key findings]
  WORKFLOW: [Recommended approach]
  ROUTE TO: [agent-name with specific command]
  NEXT STEPS: [Clear 1-3 step action plan]
  ```

#### **1.2 Issue #1: Enhanced Brainstorming Threshold**
- [ ] **Update routing criteria in project-manager**:
  - Feature lists WITHOUT technical specs → brainstorming-specialist
  - Include media editing webapp example as brainstorming trigger
  - Technical implementation details → general + /pm:prd-new directly
  
- [ ] **Add ambiguity handling**:
  - When unclear, project-manager asks: "Would you like to explore different approaches (brainstorming) or create implementation plan (PRD)?"
  - User choice determines routing path

### **Phase 2: Command Execution & Routing Enhancement**
**Timeline**: 1-2 days
**Focus**: Efficient command execution via general-purpose agents

#### **2.1 Update Command Execution Pattern**
- [ ] **Ensure all /pm: commands work with general-purpose agents**:
  - Verify command access from general agents
  - Test command execution without project-manager involvement
  - Document self-guiding command patterns
  
- [ ] **Create efficient routing patterns**:
  ```
  After project-manager assessment:
  → general-purpose + /pm:prd-new [name]
  → general-purpose + /pm:epic-decompose [name]
  → general-purpose + /pm:epic-sync [name]
  → general-purpose + /pm:status
  → general-purpose + /pm:next
  ```

#### **2.2 Issue #6: Parallel Execution Fix**
- [ ] **Add explicit parallel Task guidance in CLAUDE.md**:
  ```
  When spawning multiple agents, use single message with multiple Task tool calls:
  Task 1: agent for component A
  Task 2: agent for component B  
  Task 3: agent for tests
  (All in one message for true parallel execution)
  ```
  
- [ ] **Update project-manager assessment to identify parallel opportunities**:
  - Detect independent work streams
  - Recommend parallel execution to SAZ
  - Example: "These 3 tasks can run simultaneously: [list]"

### **Phase 3: Quality & Organization (Parallel Development)**
**Timeline**: 2-3 days
**Focus**: Content quality and user experience

#### **3.1 Issue #3: PRD UI/UX Integration**
- [ ] Research industry PRD templates for UI/UX sections
- [ ] Add UI/UX Design section to PRD template
- [ ] Create Feature-to-UI mapping requirements
- [ ] Add User Journey Integration section
- [ ] Update epic-decompose to preserve UI context
- [ ] Test: PRDs connect features to cohesive user experience

#### **3.2 Issue #4: Installation File Organization**
- [ ] Modify install/ccpm.sh to create `.claude/saz-docs/`
- [ ] Modify install/ccpm.bat for Windows compatibility
- [ ] Move documentation files during installation
- [ ] Update init.sh references to new file locations
- [ ] Test: Installation doesn't conflict with existing files

#### **3.3 Issue #5: Project Structure Enhancement**
- [ ] Add project folder creation option to workflow
- [ ] Create directory awareness helpers for agents
- [ ] Add navigation validation to commands
- [ ] Make subfolder creation user-configurable
- [ ] Test: Claude maintains directory context correctly

### **Phase 4: Advanced Features**
**Timeline**: 1-2 days
**Focus**: Enhanced user experience

#### **4.1 Issue #1B: Prompt Enhancement Command**
- [ ] Create `/enhance-prompt` command
- [ ] Research prompt library patterns
- [ ] Implement prompt improvement logic
- [ ] Add automatic recommendations
- [ ] Test: User prompts improve for brainstorming

## 🧪 Test Scenarios & Validation

### **Regression Testing**:
1. **Existing workflows** continue to work
2. **File structure** remains compatible
3. **Command execution** doesn't break
4. **Agent communication** maintains integrity

### **New Feature Testing (Updated for New Workflow)**:

#### **Test Scenario 1: New Project with Vague Requirements**
**Input**: "i want to create simple media editing webapp that allows me to trim, split, fuse videos together..."
**Flow**: 
1. SAZ → project-manager (initial assessment)
2. project-manager detects: empty project + feature list without tech specs
3. Routes to: brainstorming-specialist
4. After concept selection: general-purpose + /pm:prd-new [concept]
**Success**: Brainstorming generates concepts, then efficient PRD creation via general agent

#### **Test Scenario 2: Existing Codebase Detection**
**Input**: "Help me add authentication" (in directory with package.json, src/)
**Flow**:
1. SAZ → project-manager (initial assessment)  
2. project-manager detects: React project with 47 files in src/
3. Response: "I see you're working on a React project. Suggest /context:create first"
4. Routes to: general-purpose + /context:create
5. Then: brainstorming-specialist or general + /pm:prd-new
**Success**: Correctly identifies existing project, suggests context analysis

#### **Test Scenario 3: Active SAZ Project Resume**
**Input**: "Continue working on the dashboard"
**Flow**:
1. SAZ → project-manager (initial assessment)
2. project-manager detects: .claude/epics/dashboard/ with tasks
3. Routes to: general-purpose + /pm:status
4. Shows current progress
5. Routes to: general-purpose + /pm:next
**Success**: Seamlessly resumes work without re-explaining project

#### **Test Scenario 4: Parallel Execution from Assessment**
**Input**: "Build login, signup, and password reset pages"
**Flow**:
1. SAZ → project-manager (initial assessment)
2. project-manager identifies: 3 independent components
3. Recommends: "These can be built simultaneously"
4. SAZ spawns 3 agents in single Task tool message
**Success**: Console shows 3 agents running concurrently

#### **Test Scenario 5: Emergency Override**
**Input**: "Production is down! Payment processing broken!"
**Flow**:
1. SAZ → project-manager (initial assessment)
2. project-manager detects: emergency keywords
3. Immediate route to: code-analyzer
4. Skips all workflow steps
**Success**: < 30 second response to emergency

#### **Test Scenario 6: SAZ Installed but No Project**
**Input**: "Create a todo app"
**Flow**:
1. SAZ → project-manager (initial assessment)
2. project-manager detects: only .claude/ exists, no code
3. Routes to: brainstorming-specialist for concepts
4. After selection: general-purpose + /pm:prd-new
**Success**: Correctly identifies empty project despite .claude/ presence

## ⚠️ Backward Compatibility Considerations

### **Breaking Changes**:
- **Project-manager behavior** changes from executor to orchestrator
- **Installation file locations** change from root to `.claude/saz-docs/`
- **Threshold logic** may route differently than before

### **Migration Strategy**:
1. **Gradual rollout** with feature flags
2. **Documentation updates** for behavior changes  
3. **User communication** about workflow improvements
4. **Fallback patterns** for edge cases

### **Compatibility Preservation**:
- **Existing `.claude/` structure** unchanged
- **Command interfaces** remain the same
- **Agent tool lists** only change for project-manager
- **File formats** maintain backward compatibility

**Success Criteria**: User can provide feature-rich prompts that properly trigger brainstorming, project-manager provides clear guidance without execution conflicts, parallel execution actually works as documented, and existing users experience seamless upgrade.