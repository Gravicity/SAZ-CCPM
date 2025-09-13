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

### Operation Mode Detection

1. **Check for Scout Data**: Look for recent `scout-raw-*.json` files
2. **Mode A - Standalone**: User provides app name/URL directly
3. **Mode B - Scout Follow-up**: Read app data from scout results

```javascript
// Auto-detect mode
const scoutFiles = glob('research-results/scout-raw-*.json');
if (scoutFiles.length > 0 && appInScoutData($ARGUMENTS)) {
  // Mode B: Use existing scout data
  const appData = loadScoutData($ARGUMENTS);
  skipToEnrichment(appData);
} else {
  // Mode A: Full discovery needed
  startFullAnalysis($ARGUMENTS);
}
```

You are conducting a deep competitive analysis of: **$ARGUMENTS**

### Phase 1: Data Enrichment & Gap Filling

#### 1.1 Priority Gap Filling (Scout Follow-up Mode)
Focus on data not collected during scout phase:
```
Priority searches:
- "[app-name] tech stack" OR "built with"
- site:github.com "[app-name]"
- "[app-name] team size" OR "solo founder"
- "[app-name] marketing strategy"
- "[app-name] build time" OR "launched in X weeks"
- builtwith.com/[app-url]
```

#### 1.2 Full Discovery (Standalone Mode)
```
Complete searches:
- "[app-name] revenue MRR ARR"
- "[app-name] users customers downloads"
- "[app-name] pricing plans features"
- "[app-name] reviews complaints problems"
- "[app-name] alternatives competitors"
```

#### 1.3 Deep Enrichment (Both Modes)
- WebFetch: Scrape pricing page directly
- WebSearch: "[app-name] case study" OR "postmortem"
- GitHub/GitLab: Check for open source components
- LinkedIn: Founder/team research

### Phase 2: Deep Feature Analysis

Analyze what to build, what to skip, and what to improve:

```markdown
## Must-Have Features (MVP)
- Feature 1: [Core value prop] | Build time: X days
- Feature 2: [Essential for launch] | Build time: X days

## Nice-to-Have Features (Post-Launch)
- Feature 3: [Can add later] | Build time: X days

## Skip These Features
- Feature X: [Overengineered, not core value]
- Feature Y: [Low usage based on reviews]

## Improvement Opportunities
1. **User Complaint #1**: "[Original] is too slow" → Make speed a priority
2. **Missing Integration**: No [Platform] support → Add it
3. **Pricing Friction**: $X/month too high → Offer $X-20 with fewer limits
```

### Phase 3: Market & Competition Analysis

#### 3.1 Market Intelligence
```markdown
## Target Market
- **Primary Users**: [Who actually pays]
- **Market Size**: [TAM estimate]
- **Growth Rate**: [X% annually]
- **Underserved Segment**: [Opportunity]

## Pricing Intelligence
- **Current**: $X/month
- **Sweet Spot**: $Y based on reviews
- **Our Price**: $X-20 (undercut by 20%)

## Competition Landscape
| Competitor | MRR | Strength | Weakness |
|------------|-----|----------|----------|
| [Original] | $Xk | Feature Y | Slow, expensive |
| [Comp 2] | $Xk | Marketing | Poor UX |
```

### Phase 4: Differentiation & Branding Strategy

#### 4.1 Why Users Would Switch
```markdown
## Pain Points We Solve
1. [Original] users complain about X → We fix with Y
2. Missing feature Z → We make it core
3. Pricing friction → Our approach

## Our Unique Advantages
- **Speed**: 10x faster than [Original] by using [tech]
- **Price**: 30% cheaper with better limits
- **Feature**: [Killer feature] they can't easily copy
```

#### 4.2 Naming & Positioning Options
```markdown
## Branding Strategy

### Option A: The Technical Angle
- **Name**: "FastTrack" (emphasizes speed vs their slowness)
- **Tagline**: "[Original] but 10x faster"
- **Domain**: fasttrack.io
- **Visual Identity**: Minimal, performance-focused
- **Target Audience**: Power users frustrated with speed

### Option B: The Market Angle
- **Name**: "TeamSync" (targets their solo weakness)
- **Tagline**: "[Original] built for teams"
- **Domain**: teamsync.app
- **Visual Identity**: Collaborative, modern
- **Target Audience**: Small teams needing collaboration

### Option C: The Modern Angle
- **Name**: "Spark" (fresh vs their dated brand)
- **Tagline**: "[Original] reimagined with AI"
- **Domain**: spark.ai
- **Visual Identity**: Gradient, futuristic
- **Target Audience**: Early adopters wanting AI features

## Visual Differentiation
- If original is corporate → Go playful/friendly
- If original is complex → Go minimal/clean
- If original is dated → Go modern gradient/glassmorphism
- If original is colorful → Go monochrome/elegant
```

#### 4.3 Go-to-Market Strategy
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

### Phase 5: Implementation Blueprint & Risk Assessment

#### 5.1 Build Decision

```markdown
## Kill Switches (Stop if found)
- \u274c Patent/legal issues \u2192 STOP
- \u274c Market declining >20% YoY \u2192 STOP
- \u274c Identical clone exists \u2192 STOP
- \u274c Tech requirements too complex (>8 weeks) \u2192 STOP

## Manageable Risks
1. **[Original] copies our feature**
   - Mitigation: Build 3 differentiators, not 1
2. **User acquisition expensive**
   - Mitigation: Focus on organic/SEO first
3. **Technical complexity**
   - Mitigation: Start with 60% feature parity
```

#### 5.2 Detailed Implementation Roadmap

```markdown
# Implementation Blueprint: [Chosen Name from Phase 4]

## Week 1: Core Value Delivery
- [ ] Set up [Next.js/Remix] + [Supabase/Postgres]
- [ ] Build feature that proves core value prop
- [ ] Basic auth with [Clerk/Auth.js]
- [ ] Implement ONE key differentiator
- [ ] Deploy to Vercel/Railway

## Week 2: Monetization Ready
- [ ] Stripe/Lemon Squeezy integration
- [ ] Pricing page with comparison to [Original]
- [ ] Trial/freemium logic
- [ ] Usage tracking and limits

## Week 3: Growth Features
- [ ] Polished onboarding flow
- [ ] "Import from [Original]" tool
- [ ] First viral/sharing feature
- [ ] SEO-optimized landing pages

## Week 4: Launch Excellence
- [ ] ProductHunt assets (gallery, demo video)
- [ ] Comparison page: Us vs [Original]
- [ ] Blog post: "Why we built a better [Original]"
- [ ] Email templates for outreach

## Tech Stack Decision
**Frontend**: [Next.js/Remix] - Fast, SEO-friendly
**Backend**: [Supabase/PostgreSQL] - Scales, good DX
**Auth**: [Clerk/Auth.js] - Quick setup
**Payments**: [Stripe/Lemon] - Trusted
**Hosting**: [Vercel/Railway] - Easy deploys
```

#### 5.3 Launch Sequence & Messaging

```markdown
## Launch Strategy

### Soft Launch (Week 4, Day 1-3)
- Post to [specific subreddit/community]
- Gather 10-20 beta users
- Collect testimonials about [key differentiator]

### Public Launch (Week 4, Day 4)
**ProductHunt**: Tuesday/Wednesday, 12:01 AM PST
**Reddit Posts** (prepare 3 variations):
```
Title: "Frustrated with [Original]'s [problem]? I built [solution]"
Body: Brief story → Problem → Solution → Free trial link
```

**Twitter Thread**:
```
1/ [Original] is great but [specific pain point]
2/ So I built [YourApp] - here's what's different:
3/ [Key differentiator with screenshot]
4/ [Social proof or early user quote]
5/ [Link to free trial]
```

**Cold Email to Reviewers**:
```
Subject: You covered [Original] - we solved [their main criticism]

Hi [Name],

Saw your review of [Original] where you mentioned [specific criticism].

We built [YourApp] specifically to address this. [Brief how].

Happy to give you early access to check it out.

[Your name]
```

### Post-Launch Growth Hacks
1. **SEO Play**: Create "[Original] alternatives" page
2. **Comparison Content**: Detailed Us vs Them blog post  
3. **Migration Tool**: One-click import from [Original]
4. **Referral Program**: Users get month free for each referral
```

### Competitive Comparison (if --compare-with)

| Feature | [Original] | [Competitor 1] | [Competitor 2] | Our Clone |
|---------|------------|----------------|----------------|-----------|
| Price | $X | $Y | $Z | $X-1 |
| Feature 1 | ✅ | ❌ | ✅ | ✅ |
| Feature 2 | ❌ | ✅ | ❌ | ✅ |
| Mobile App | ❌ | ❌ | ✅ | ✅ |
| API | ✅ | ✅ | ❌ | ✅ |

### Final Analysis: Decision Matrix

```markdown
## Decision Matrix

| Factor | Score | Notes |
|--------|-------|-------|
| Market Opportunity | ⭐⭐⭐⭐⭐ | $50k+ MRR potential |
| Technical Feasibility | ⭐⭐⭐⭐ | 3 weeks with Next.js |
| Competition Risk | ⭐⭐⭐ | 2 strong players but gaps exist |
| Differentiation | ⭐⭐⭐⭐⭐ | Clear unique angle |
| Speed to Market | ⭐⭐⭐⭐ | Can launch in 4 weeks |

**Overall Score**: 85/100
**Build Time**: 3-4 weeks
**Expected MRR Month 6**: $8,000
**Confidence Level**: HIGH

## Recommendation: GO ✅

### Why GO:
- Clear differentiation opportunity
- Proven market demand ($X market size)
- Achievable in 4 weeks
- Path to $5k MRR visible

### Key Risks:
1. [Original] could copy our feature → Mitigation: Move fast, build moat
2. Market saturation → Mitigation: Focus on underserved segment
```

### Output Format

Save to: `research-results/analysis-$ARGUMENTS-$(date +%Y%m%d).md`

```markdown
# Deep Analysis: [App Name]

## Executive Summary
- Clone Score: X/100
- Build Complexity: X weeks
- Expected MRR Month 6: $X
- **Recommendation: GO/PIVOT/PASS**

[Continue with all phases...]

## Next Actions
✅ **GO Decision**: Run `/pm:prd-new [chosen-name-from-phase4]`
⚠️ **PIVOT Needed**: Focus on [suggested niche]
❌ **PASS**: Try `/research:app-scout [different-focus]`
```

### Post-Analysis Actions

1. Display summary with score and recommendation
2. If GO (>80): "✅ Strong opportunity! Ready to build [chosen-name]. Run: `/pm:prd-new [name]`"
3. If PIVOT (60-79): "⚠️ Good with modifications. Consider: [specific pivot suggestion]"
4. If PASS (<60): "❌ Better opportunities exist. Run: `/research:app-scout [new-focus]`"