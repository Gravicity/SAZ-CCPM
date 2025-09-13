---
allowed-tools: Task, WebSearch, WebFetch, Bash, Read, Write, MultiEdit
---

# App Scout

Automated app discovery and cloning analysis workflow using MCP ecosystem.

## Usage
```
/research:app-scout <search-focus> [--mrr-range <min-max>] [--build-weeks <max>] [--category <type>]
```

## Examples
```
/research:app-scout "ai-wrappers" --mrr-range 5k-50k --build-weeks 2
/research:app-scout "chrome-extensions" --mrr-range 3k-20k
/research:app-scout "no-code-apps" --category bubble
/research:app-scout "trending" 
```

## Options
- `--mrr-range <min-max>`: Target MRR range (e.g., "5k-50k", "10k-100k"). Default: "3k-50k"
- `--build-weeks <max>`: Maximum build time in weeks. Default: 4
- `--category <type>`: Specific category (chrome, ai, api, no-code, saas). Default: all
- `--output <format>`: Output format (json, markdown, both). Default: both

## Required Rules

**IMPORTANT:** Before executing this command, read and follow:
- `.claude/rules/datetime.md` - For getting real current date/time

## Preflight Checklist

1. Parse search focus from "$ARGUMENTS"
2. Validate MRR range and category parameters  
3. Check for existing `research-results/*.json` to avoid duplicates

## Instructions

You are conducting automated app discovery using the SAZ-CCPM MCP ecosystem for: **$ARGUMENTS**

### Phase 1: Discovery Process

Execute searches IN PARALLEL with 3-5 second delays between same-domain requests:

#### 1.1 High-Signal Search Patterns
```
Revenue-focused (Priority 1):
- "[focus] $*k MRR"
- "[focus] revenue per month"
- "built [focus] making $"

Milestone/Launch (Priority 2):
- "launched [focus] customers"
- "[focus] hit $5000"
- "Show HN: [focus]"

Competition (Priority 3):
- "alternative to [focus] cheaper"
- "[focus] vs" comparison
```

#### 1.2 Primary Data Sources
```
Revenue Transparency (Most Reliable):
- baremetrics.com/open-startups
- indiehackers.com/products?revenueVerified=true
- microacquire.com/startups

Launch/Discovery Platforms:
- producthunt.com/topics/[focus]
- alternativeto.net/software/[competitor]
- explodingtopics.com/topics-last-6-months

Note: Rotate domains, 3-8 second delays with jitter
```

#### 1.3 Community Sources
```
Reddit (High-Signal):
- "r/SaaS [focus] reached MRR"
- "r/entrepreneur [focus] paying customers"
- "r/IndieHackers AMA [focus] revenue"

HackerNews:
- "Show HN: [focus]" (comments>50)
- "Launch HN: [focus]"

Twitter/LinkedIn:
- "#buildinpublic [focus] MRR"
- "[focus] proud to announce revenue"
```

#### 1.4 Market Research
```
- "[competitor] alternatives revenue"
- "case study [category] $10k MRR"
- "micro-saas [category] opportunities"
```

### Phase 2: Data Extraction (Essentials Only)

**Use `null` for unknown data - NEVER hallucinate.**

```javascript
{
  "name": "App Name",  // Required
  "category": "chrome-extension|ai-wrapper|api|no-code|saas",  // or null
  "description": "What it does",  // or null
  "mrr": 0,  // Monthly recurring revenue, or null
  "users": "Number or estimate",  // or null
  "growth_rate": "X% monthly",  // or null
  "url": "website",  // or null
  "source": "where found",  // Required
  "discovered_date": "ISO date",  // Required
  "data_confidence": "high|medium|low"
}
```

**Extract only if explicitly stated:**
- MRR: "making $5k/month" → `"mrr": 5000`
- Users: "10,000 users" → `"users": "10000"`
- Growth: "growing 20% monthly" → `"growth_rate": "20"`

**Defer to app-analyze phase:** tech_stack, team_size, marketing_channels, build_time

### Phase 3: Quick Scoring

Score ALL apps (max 40) for initial ranking:

```python
def calculate_clone_score(app):
    score = 0
    confidence = 1.0
    
    # Count known critical fields
    known = sum(1 for f in ['mrr', 'users', 'growth_rate'] 
                if app.get(f) is not None)
    if known < 2: confidence = 0.5
    
    # MRR (40 points - most important for scout)
    if app.mrr:
        if 5000 <= app.mrr <= 50000: score += 40
        elif 3000 <= app.mrr < 5000: score += 25
        elif app.mrr > 50000: score += 10
    
    # Growth (30 points)
    if app.growth_rate:
        rate = int(app.growth_rate.split('%')[0]) if '%' in str(app.growth_rate) else app.growth_rate
        if rate > 20: score += 30
        elif rate > 10: score += 20
        elif rate > 5: score += 10
    
    # Category opportunity (20 points)
    if app.category in ['ai-wrapper', 'chrome-extension', 'no-code']:
        score += 20  # High opportunity categories
    elif app.category:
        score += 10
    
    # Users/traction (10 points)  
    if app.users: score += 10
    
    app['clone_score'] = int(score * confidence)
    app['score_confidence'] = 'high' if known >= 2 else 'low'
    return app['clone_score']
```

### Phase 4: Save All Results

Path: `research-results/scout-raw-$(date +%Y%m%d-%H%M%S)-$ARGUMENTS.json`

```json
{
  "metadata": {
    "scout_date": "ISO date",
    "search_focus": "$ARGUMENTS",
    "apps_discovered": 0,
    "max_score": 0
  },
  "all_apps": [  // Up to 40, sorted by score
    {
      "name": "App Name",
      "category": "type",
      "description": "What it does",
      "mrr": 0,
      "users": "count",
      "growth_rate": "X%",
      "url": "website",
      "source": "where found",
      "clone_score": 85,
      "score_confidence": "high|low"
    }
  ]
}
```

### Phase 5: Top 10 Quick Analysis

For top 10 apps only, identify:
- Key improvement opportunity
- Simple differentiation angle
- Estimated build complexity (1-4 weeks)

**Note:** Detailed competitive analysis deferred to `/research:app-analyze` command

### Phase 6: Final Report

Path: `research-results/scout-report-$(date +%Y%m%d)-$ARGUMENTS.md`

```markdown
# App Scout Report: $ARGUMENTS

## Summary
- Apps found: X (scored: Y)
- Top opportunity: [App] ($MRR, score/100)

## Top 10 Ranking
| Rank | App | MRR | Score | Quick Take |
|------|-----|-----|-------|------------|
| 1 | Name | $X | Y/100 | One-line insight |

## Next Steps
- Score > 80: Run `/research:app-analyze [top-app]`
- Score 50-80: Review top 3 opportunities
- Score < 50: Try different search focus

## Data: `scout-raw-{timestamp}.json`
```

### Phase 7: Next Actions

If score > 80: Suggest `/research:app-analyze [app-name]` for deep dive
If score > 90: Auto-trigger `/pm:prd-new [app-clone-name]`

### Quality Checks

**Data Integrity:**
- Use null for unverified data
- Cite sources for all stats
- Flag old data (>6 months)

**Acceptable sources:** Founder statements, official pages, transparency reports
**Reject:** User guesses, competitor claims, estimates

### Post-Scout Actions

1. Display: "✅ Found X apps, top score: Y/100"
2. Show top 3 with scores
3. Next step:
   - Score > 80: `/research:app-analyze [top-app]`
   - Score < 60: Try different search focus


## Next Commands

- **Deep dive**: `/research:app-analyze [app-name]` - Detailed analysis
- **Build PRD**: `/pm:prd-new [app-name]` - Start building
- **New search**: `/research:app-scout [different-focus]` - Try another niche

**Goal**: Find apps reaching $5k+ MRR in 6 months with minimal marketing.