---
allowed-tools: Task, WebFetch, WebSearch, Read, Write, MultiEdit, Bash
---

# App Analyze

Deep competitive analysis of a specific app for cloning potential.

## Usage
```
/research:app-analyze <app-name-or-url> [--depth <level>] [--compare-with <competitors>]
```

## Examples
```
/research:app-analyze "typingmind.com" --depth full
/research:app-analyze "Easy Folders" --compare-with "css-scan,onetab"
/research:app-analyze "https://questgen.ai" 
```

## Options
- `--depth <level>`: Analysis depth (quick|standard|full). Default: standard
- `--compare-with <competitors>`: Comma-separated list of competitors to compare
- `--output <path>`: Custom output path. Default: research-results/analysis-[app-name].md

## Instructions

You are conducting a deep competitive analysis of: **$ARGUMENTS**

### Phase 1: Information Gathering

#### 1.1 Basic Research (WebSearch + WebFetch)
```
Searches to perform:
- "[app-name] revenue MRR"
- "[app-name] user count customers"
- "[app-name] pricing features"
- "[app-name] reviews complaints"
- "[app-name] alternatives competitors"
- "[app-name] tech stack built with"
```

#### 1.2 Deep Dive (if --depth full)
- Playwright MCP: Screenshot key pages
- WebFetch: Analyze pricing page
- EXA: Find founder interviews/tweets
- WebSearch: Technical blog posts

### Phase 2: Feature Analysis

Extract and document:

```markdown
## Core Features
- Feature 1: [Description] | Priority: High/Medium/Low
- Feature 2: [Description] | Complexity: Simple/Medium/Complex

## Unique Selling Points
1. [What makes this app special]
2. [Key differentiator]

## Missing Features (Opportunities)
- [ ] Feature users request most
- [ ] Obvious gap in functionality
- [ ] Platform/integration missing
```

### Phase 3: Technical Assessment

```javascript
{
  "tech_stack": {
    "frontend": "Framework and libraries",
    "backend": "Server technology",
    "database": "Data storage solution",
    "hosting": "Where it's deployed",
    "third_party": ["APIs", "Services"]
  },
  "complexity_score": 1-10,
  "build_time_estimate": "X weeks",
  "technical_challenges": [
    "Challenge 1",
    "Challenge 2"
  ]
}
```

### Phase 4: Market Analysis

#### 4.1 User Segmentation
- Primary users: [Description]
- Use cases: [Main scenarios]
- Pain points: [What problems it solves]

#### 4.2 Pricing Strategy
- Current pricing: $X/month
- Pricing model: Subscription/Usage/One-time
- Price sensitivity: High/Medium/Low
- Optimization opportunities

#### 4.3 Growth Analysis
- Estimated growth rate
- Marketing channels used
- Viral potential score (1-10)
- SEO opportunity score (1-10)

### Phase 5: Clone Strategy Development

#### 5.1 The 1% Better Framework
```markdown
## How to Make It 1% Better

### Quick Wins (Week 1)
1. [Improvement that takes hours]
2. [Simple feature addition]

### Medium Improvements (Week 2-3)
1. [Platform expansion]
2. [Integration addition]

### Game Changers (Week 4+)
1. [Revolutionary feature]
2. [New market approach]
```

#### 5.2 Positioning Strategy
```markdown
## Positioning Against [Original App]

### If They Say: "[Original] is the best [category]"
### We Say: "[Clone] is [Original] but [key differentiator]"

Examples:
- "TypeScript-first version of [Original]"
- "[Original] for teams"
- "Privacy-focused [Original]"
- "[Original] with AI built-in"
```

#### 5.3 Go-to-Market Strategy
```markdown
## Launch Strategy

### Week 1: Pre-launch
- [ ] Build email list from [Original]'s unhappy users
- [ ] Create comparison page: [Clone] vs [Original]
- [ ] Prepare Product Hunt assets

### Launch Day
- [ ] Product Hunt launch (Tuesday/Wednesday)
- [ ] Post in communities where [Original] users hang out
- [ ] Reach out to reviewers who covered [Original]

### Post-launch
- [ ] SEO: Target "[Original] alternatives" keywords
- [ ] Content: "Moving from [Original] to [Clone]" guide
- [ ] Partnerships: Integrate where [Original] doesn't
```

### Phase 6: Risk Assessment

```markdown
## Risks & Mitigation

### Legal Risks
- Patent concerns: [Assessment]
- Trademark issues: [Name check]
- TOS violations: [Platform rules]

### Technical Risks
- Complexity underestimation
- Scaling challenges
- Security requirements

### Market Risks
- [Original] adds our features
- Market saturation
- User acquisition cost

### Mitigation Strategies
1. [How to handle each risk]
```

### Phase 7: Implementation Blueprint

Generate detailed implementation plan:

```markdown
# Implementation Blueprint: [Clone Name]

## MVP Checklist (Launch in X weeks)

### Week 1: Core
- [ ] Project setup (Next.js + Supabase)
- [ ] Authentication system
- [ ] Core feature 1: [Feature]
- [ ] Core feature 2: [Feature]

### Week 2: Polish
- [ ] Payment integration (Stripe/Lemon Squeezy)
- [ ] Landing page
- [ ] Onboarding flow
- [ ] Basic analytics

### Week 3: Differentiation
- [ ] Unique feature 1: [Our advantage]
- [ ] Unique feature 2: [Our advantage]
- [ ] Import from [Original] feature

### Week 4: Launch Prep
- [ ] Beta testing with 20 users
- [ ] Bug fixes and optimization
- [ ] Marketing materials
- [ ] Documentation

## Tech Decisions

### Must Have
- Tech 1: [Reason]
- Tech 2: [Reason]

### Nice to Have
- Tech 3: [Can add later]

### Avoid
- Tech 4: [Overengineering]
```

### Phase 8: Competitive Comparison (if --compare-with)

| Feature | [Original] | [Competitor 1] | [Competitor 2] | Our Clone |
|---------|------------|----------------|----------------|-----------|
| Price | $X | $Y | $Z | $X-1 |
| Feature 1 | ✅ | ❌ | ✅ | ✅ |
| Feature 2 | ❌ | ✅ | ❌ | ✅ |
| Mobile App | ❌ | ❌ | ✅ | ✅ |
| API | ✅ | ✅ | ❌ | ✅ |

### Phase 9: Final Scoring

```javascript
{
  "clone_score": 0-100,
  "breakdown": {
    "market_opportunity": 0-25,
    "technical_feasibility": 0-25,
    "differentiation_potential": 0-25,
    "revenue_potential": 0-25
  },
  "recommendation": "BUILD|PASS|PIVOT",
  "confidence": "HIGH|MEDIUM|LOW",
  "expected_mrr_month_6": "$X"
}
```

### Output Format

Save analysis to: `research-results/analysis-$ARGUMENTS-$(date +%Y%m%d).md`

Include:
1. Executive summary (3 sentences)
2. Full analysis (all phases)
3. Go/No-Go recommendation
4. Next steps if GO
5. Alternative options if NO-GO

### Success Criteria

The analysis should answer:
- Can we build this in 2-4 weeks?
- Can we reach $5k MRR in 6 months?
- What's our unique angle?
- Is the market growing or shrinking?
- What's the #1 risk?

### Post-Analysis

After analysis complete:
1. Show clone score and recommendation
2. If score > 70: "✅ Strong opportunity! Create PRD? /pm:prd-new [clone-name]"
3. If score 50-70: "⚠️ Moderate opportunity. Review risks carefully"
4. If score < 50: "❌ Better opportunities exist. Try /research:app-scout"