---
allowed-tools: Task, Read, Write, MultiEdit, Bash, TodoWrite
---

# Quick Clone

Generate a detailed, hour-by-hour implementation plan for rapidly cloning an analyzed app.

## Usage
```
/research:quick-clone <app-name> [--name <clone-name>] [--days <target>] [--focus <priority>]
```

## Examples
```
/research:quick-clone "fasttrack" --days 7 --focus speed
/research:quick-clone "scout:rank-3" --name "QuickSync" 
/research:quick-clone "analyze:latest" --days 14
```

## Options
- `--name <clone-name>`: Use this name instead of the one from analysis
- `--days <target>`: Target days to MVP (3|7|14|21). Default: 7
- `--focus <priority>`: Primary focus (speed|features|polish). Default: speed

## Instructions

### Context Loading Phase

#### Check for Previous Analysis
```javascript
// Smart input handling
const input = "$ARGUMENTS";

// Check multiple sources
const sources = {
  analysis: glob('research-results/analysis-*.md'),  // Recent deep analysis
  scout: glob('research-results/scout-raw-*.json'), // Scout database
  direct: input.startsWith('http') ? input : null   // Direct URL
};

// Load context from most relevant source
const context = loadPreviousDecisions(sources);

if (!context.appData) {
  console.log("⚠️ No previous analysis found. Run /research:app-analyze first for better results");
  // Proceed with minimal analysis or exit
}
```

#### Extract Key Decisions
```javascript
const planContext = {
  // From previous analysis
  chosenName: context.branding?.selected || "$NAME",
  techStack: context.techDecisions || autoDetect(),
  differentiators: context.uniqueFeatures || [],
  competitors: context.competition || [],
  targetUsers: context.market?.segment || "general",
  
  // From scout data
  mrr: context.mrr || null,
  category: context.category || detectFromUrl(),
  
  // User overrides
  userProvidedName: "$NAME" || null,
  targetDays: "$DAYS" || 7,
  focus: "$FOCUS" || "speed"
};
```

### Adaptive Planning Generation

#### Project Type Detection
```javascript
function detectProjectType(context) {
  // Adaptive planning based on app category
  const projectTypes = {
    'chrome-extension': ChromeExtensionPlan,
    'ai-wrapper': AIWrapperPlan,
    'saas': SaaSPlan,
    'no-code': NoCodeToolPlan,
    'api-service': APIServicePlan,
    'mobile': MobileAppPlan,
    'marketplace': MarketplacePlan
  };
  
  return projectTypes[context.category] || SaaSPlan;
}

// Generate contextually appropriate plan
const PlanTemplate = detectProjectType(planContext);
const detailedPlan = new PlanTemplate(planContext).generate();
```

## Adaptive Implementation Plans

**IMPORTANT**: The following plans are **examples** that adapt based on project type. The actual plan will be customized for your specific clone.

### Example: Chrome Extension Clone Plan

```markdown
# Quick Clone Plan: [Extension Name]
*Cloning: [Original] | Category: Chrome Extension | Timeline: 7 days*

## Day 1: Extension Foundation (8 hours)

### Hour 1-2: Project Setup & Architecture
- [ ] Create extension directory structure:
  ```
  /extension
    /src
      /background
      /content
      /popup
      /options
    /public
      manifest.json
      /icons
  ```
- [ ] Configure manifest.json with minimal permissions
- [ ] Set up TypeScript and webpack for extension bundling
- [ ] Configure hot-reload for development

### Hour 3-4: Core Extension Functionality
- [ ] Implement background service worker
- [ ] Create message passing system
- [ ] Set up Chrome storage API for settings
- [ ] Build basic popup UI with React/Vue

### Hour 5-6: Content Script Implementation
- [ ] Inject content script on target pages
- [ ] Create DOM manipulation functions
- [ ] Implement [key differentiator #1]
- [ ] Add MutationObserver for dynamic content

### Hour 7-8: Testing & Permissions
- [ ] Test in Chrome developer mode
- [ ] Verify minimal permissions needed
- [ ] Create options page for settings
- [ ] Test cross-origin requests if needed

## Day 2: Core Features
[Specific to extension functionality]

## Day 3: Polish & Store Prep
- Chrome Web Store assets
- Privacy policy
- Promotional images
```

### Example: AI Wrapper Clone Plan

```markdown
# Quick Clone Plan: [AI App Name]
*Cloning: [Original] | Category: AI Wrapper | Timeline: 7 days*

## Day 1: AI Infrastructure (8 hours)

### Hour 1-2: Project & API Setup
- [ ] Next.js app with TypeScript
- [ ] Environment variables for API keys:
  ```
  OPENAI_API_KEY=
  ANTHROPIC_API_KEY=
  STRIPE_SECRET_KEY=
  SUPABASE_URL=
  ```
- [ ] Install AI SDKs and streaming libraries
- [ ] Set up Vercel KV for rate limiting

### Hour 3-4: Token Management System
- [ ] Create token counting utility
- [ ] Implement usage tracking per user
- [ ] Build cost calculation system
- [ ] Add rate limiting middleware

### Hour 5-6: Streaming Response UI
- [ ] Server-sent events setup
- [ ] Streaming text component
- [ ] Loading states and animations
- [ ] Error boundary for API failures

### Hour 7-8: Prompt Engineering
- [ ] Create prompt templates
- [ ] Build prompt optimization system
- [ ] Implement [key differentiator #1]
- [ ] Add prompt versioning

## Day 2: User Management & Billing
[Specific to AI token/credit management]

## Day 3: Differentiation Features
- Advanced prompt chaining
- Custom model selection
- Export functionality
```

### Example: SaaS Clone Plan

```markdown
# Quick Clone Plan: [SaaS Name]
*Cloning: [Original] | Category: SaaS | Timeline: 7 days*

## Day 1: Foundation & Database (8 hours)

### Hour 1-2: Full-Stack Setup
- [ ] Create T3 app or Next.js + Prisma
- [ ] PostgreSQL database setup
- [ ] Configure authentication (Clerk/Auth.js)
- [ ] Set up GitHub repo and Vercel

### Hour 3-4: Data Model & APIs
- [ ] Design database schema
- [ ] Create Prisma migrations
- [ ] Build CRUD API endpoints
- [ ] Implement RLS policies

### Hour 5-6: Core Business Logic
- [ ] Main feature implementation
- [ ] Business rule validation
- [ ] Data processing pipeline
- [ ] Background job setup if needed

### Hour 7-8: Basic UI
- [ ] Dashboard layout
- [ ] Navigation structure
- [ ] Core feature UI
- [ ] Responsive design check

## Day 2: Authentication & Payments
[Standard SaaS requirements]
```

## Feature-by-Feature Detailed Breakdown

Based on the app being cloned, generate specific implementation tasks:

```markdown
## Feature: [Specific Feature Name]

### Technical Requirements
- Database tables needed
- API endpoints required
- Third-party services
- Frontend components

### Implementation Steps (3 hours)

#### Hour 1: Backend
- [ ] Create database migration
- [ ] Build API endpoint with validation
- [ ] Add authentication checks
- [ ] Implement business logic
- [ ] Write unit tests

#### Hour 2: Frontend
- [ ] Create React/Vue component
- [ ] Connect to API with SWR/React Query
- [ ] Add loading and error states
- [ ] Implement optimistic updates
- [ ] Style with Tailwind

#### Hour 3: Integration & Testing
- [ ] End-to-end testing
- [ ] Error handling
- [ ] Performance optimization
- [ ] Documentation
```

## Import Tool Implementation

Since competing with [Original], implement import feature:

```markdown
## Day 3: Import from [Original] (4 hours)

### Research Phase (30 minutes)
- [ ] Analyze [Original]'s export format
- [ ] Document field mappings
- [ ] Identify data transformations

### Implementation (3.5 hours)

#### Backend (2 hours)
- [ ] Create /api/import endpoint
- [ ] Parse [Original]'s format (CSV/JSON)
- [ ] Data validation and sanitization
- [ ] Batch processing for large imports
- [ ] Progress tracking with WebSockets

#### Frontend (1.5 hours)
- [ ] Drag-and-drop upload component
- [ ] Import progress indicator
- [ ] Error reporting UI
- [ ] Success confirmation with stats
- [ ] "Import from [Original]" marketing page
```

## Launch Preparation Checklist

```markdown
## Day 7: Launch Day Preparation

### Morning (4 hours): Final Testing
- [ ] Complete user flow testing
- [ ] Payment flow with real cards
- [ ] Import tool with sample data
- [ ] Mobile responsiveness
- [ ] Browser compatibility
- [ ] Load testing with k6/Artillery

### Afternoon (4 hours): Launch Assets

#### ProductHunt Preparation
- [ ] Gallery images (1270x760px):
  - Hero shot showing main feature
  - Comparison with [Original]
  - Unique differentiator demo
  - Pricing advantage
- [ ] 60-character tagline
- [ ] 260-character description
- [ ] Hunter lined up

#### Marketing Pages
- [ ] Landing page with clear value prop
- [ ] /compare/[original] page
- [ ] /switch-from-[original] guide
- [ ] Pricing page with launch discount

#### Content Ready
- [ ] Reddit post (3 variations)
- [ ] Twitter thread draft
- [ ] HackerNews Show HN post
- [ ] Cold email templates
```

## Go-Live Checklist

```markdown
## Launch Execution

### T-4 Hours
- [ ] Deploy to production
- [ ] Verify all env variables
- [ ] Enable error tracking (Sentry)
- [ ] Set up monitoring (Vercel Analytics)
- [ ] Test critical paths one more time

### T-0: Launch
- [ ] Submit to ProductHunt (12:01 AM PST)
- [ ] Post to relevant subreddits
- [ ] Send launch tweet thread
- [ ] Message to email list
- [ ] Update status page

### T+1 Hour: Monitor
- [ ] Check error logs
- [ ] Monitor server performance
- [ ] Respond to early feedback
- [ ] Fix critical bugs immediately
```

## Success Metrics & Tracking

```markdown
## Analytics Setup (Day 2, 1 hour)

### Events to Track
- [ ] User signup (source, referrer)
- [ ] Feature usage (which features, frequency)
- [ ] Upgrade clicks (from where)
- [ ] Import completions (success rate)
- [ ] Churn points (where users drop)

### Tools
- [ ] Posthog/Mixpanel for product analytics
- [ ] Stripe for revenue metrics
- [ ] Sentry for error tracking
- [ ] Vercel Analytics for performance
```

## Output Files

Save all generated files to the research results directory:

```
/research-results
  /clone-[app-name]-$(date +%Y%m%d)
    /plan
      - implementation-plan.md (full detailed plan)
      - day-by-day-checklist.md (simplified version)
      - tech-decisions.md (stack choices explained)
    /launch
      - marketing-copy.md (all marketing content)
      - product-hunt.md (ready to paste)
      - reddit-posts.md (3 variations)
    /code
      - setup.sh (project initialization script)
      - schema.sql (database schema if applicable)
      - .env.example (required environment variables)
```

Primary output: `research-results/clone-[app-name]-$(date +%Y%m%d)/plan/implementation-plan.md`

## Post-Generation Message

After plan generation, display:

```
✅ Quick Clone Plan Generated for [App Name]

📋 Timeline: [X] days to MVP
🎯 Differentiator Focus: [Key unique feature]
💰 Expected MRR by Month 6: $[Amount]

📁 Files created in research-results/clone-[app-name]-[date]/:
- plan/implementation-plan.md (full detail)
- plan/day-by-day-checklist.md (quick reference)
- launch/marketing-copy.md (ready to use)
- code/setup.sh (quick start script)

Next steps:
1. Open: research-results/clone-[app-name]-[date]/plan/implementation-plan.md
2. Start with Day 1, Hour 1 tasks
3. Use the setup.sh script to initialize your project

Ready to start building? The first task is already copied to your clipboard!
```

## Important Notes

1. **This is a planning tool**, not a code generator
2. **Plans adapt to project type** - Chrome extensions differ from SaaS
3. **Leverages previous analysis** - Don't repeat research already done
4. **Hour-by-hour for Day 1** - Most critical day detailed extensively
5. **Specific, not vague** - Every task is actionable
6. **Launch-focused** - Always building toward launch day

The goal: Transform strategic analysis into tactical execution with no ambiguity.