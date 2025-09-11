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

Before proceeding, complete these validation steps silently:

### Input Validation
1. **Parse search focus:**
   - Extract primary search terms from "$ARGUMENTS"
   - Map to appropriate search strategies
   - If "trending", prioritize recent launches

2. **Validate parameters:**
   - Parse MRR range into min/max values
   - Ensure build-weeks is 1-12
   - Validate category against allowed types

3. **Check existing data:**
   - Look for `research-results/profitable-apps-database.json`
   - If exists, load for deduplication
   - Track last scout timestamp

## Instructions

You are conducting automated app discovery using the SAZ-CCPM MCP ecosystem for: **$ARGUMENTS**

### Phase 1: Discovery Sources

Execute searches across multiple sources IN PARALLEL using Task tool:

#### 1.1 Twitter/X Search (EXA MCP)
```
Search queries based on "$ARGUMENTS":
- "[focus] $10k MRR"
- "indie hacker [focus] monthly revenue"
- "just launched [focus] making $"
- "solo founder [focus] revenue update"
- "[focus] hit $5000 per month"
```

#### 1.2 Trending Topics (Playwright MCP)
```
Sites to crawl:
- explodingtopics.com (filter by [focus])
- trends.google.com (related to [focus])
- producthunt.com/topics/[focus]
```

#### 1.3 Community Mining (EXA MCP)
```
Reddit searches:
- "r/SaaS [focus] revenue"
- "r/entrepreneur [focus] MRR"
- "r/SideProject [focus] profitable"
- "r/IndieHackers [focus] milestone"
```

#### 1.4 Market Research (WebSearch)
```
General searches:
- "[focus] alternatives making money"
- "profitable [focus] apps 2024-2025"
- "[focus] app revenue statistics"
- "best [focus] to build solo"
```

### Phase 2: Data Extraction

For each discovered app, extract:

```javascript
{
  "name": "App Name",
  "category": "chrome-extension|ai-wrapper|api|no-code|saas",
  "description": "What it does",
  "mrr": 0, // Monthly recurring revenue in USD
  "users": "Number or estimate",
  "tech_stack": "Technologies used",
  "build_time_weeks": 0, // Estimated build time
  "team_size": "solo|small|team",
  "marketing_channels": ["channel1", "channel2"],
  "founded": "YYYY-MM",
  "growth_rate": "X% monthly",
  "url": "website or product page",
  "source": "where we found this",
  "discovered_date": "ISO date"
}
```

### Phase 3: Scoring Algorithm

Score each app 0-100 based on:

```python
def calculate_clone_score(app):
    score = 0
    
    # MRR Score (30 points)
    if 5000 <= app.mrr <= 50000:
        score += 30
    elif 3000 <= app.mrr < 5000:
        score += 20
    elif app.mrr > 50000:
        score += 10  # Too complex
    
    # Build Complexity (25 points)
    if app.build_time_weeks <= 2:
        score += 25
    elif app.build_time_weeks <= 4:
        score += 15
    else:
        score += 5
    
    # Market Demand (20 points)
    if app.growth_rate > 20:
        score += 20
    elif app.growth_rate > 10:
        score += 15
    elif app.growth_rate > 5:
        score += 10
    
    # Competition (15 points)
    # Assess based on category saturation
    
    # Marketing Ease (10 points)
    if "viral" in app.marketing_channels:
        score += 10
    elif "seo" in app.marketing_channels:
        score += 7
    
    return score
```

### Phase 4: Competitive Analysis

For top 10 scoring apps, generate:

#### 4.1 Improvement Opportunities
- Missing features from user complaints
- UI/UX weaknesses
- Platform limitations
- Pricing gaps

#### 4.2 Clone Strategy
- **Name suggestions**: 3 alternatives
- **Positioning**: How to differentiate
- **Tech stack**: Optimal implementation
- **MVP features**: Core functionality for launch
- **Growth strategy**: Initial marketing approach

#### 4.3 Implementation Roadmap
```markdown
## Week 1: Foundation
- [ ] Set up project structure
- [ ] Core functionality
- [ ] Basic UI

## Week 2: MVP
- [ ] Payment integration
- [ ] User authentication
- [ ] Landing page

## Week 3: Polish
- [ ] Bug fixes
- [ ] Performance optimization
- [ ] Beta testing

## Week 4: Launch
- [ ] Product Hunt preparation
- [ ] Marketing materials
- [ ] Go live
```

### Phase 5: Output Generation

#### 5.1 Save JSON Database
Path: `research-results/scout-$(date +%Y%m%d)-$ARGUMENTS.json`

```json
{
  "metadata": {
    "scout_date": "ISO date",
    "search_focus": "$ARGUMENTS",
    "parameters": {
      "mrr_range": "min-max",
      "build_weeks": "max",
      "category": "type"
    },
    "apps_found": 0,
    "apps_analyzed": 0
  },
  "apps": [...],
  "recommendations": {
    "top_pick": {},
    "runners_up": [],
    "quick_wins": []
  }
}
```

#### 5.2 Generate Markdown Report
Path: `research-results/scout-$(date +%Y%m%d)-$ARGUMENTS.md`

```markdown
# App Scout Report: $ARGUMENTS

## Executive Summary
- Apps discovered: X
- Apps meeting criteria: Y
- Top opportunity: [App Name] ($MRR, score/100)

## Top 5 Opportunities
[Detailed analysis of each]

## Quick Wins (Build in 1 week)
[List of simplest apps]

## Market Insights
[Patterns and trends discovered]

## Recommended Action
[Specific next steps]
```

### Phase 6: Automation Pipeline

If high-scoring app found (score > 80):

1. **Auto-generate PRD**:
   ```bash
   /pm:prd-new [app-clone-name]
   ```

2. **Create implementation epic**:
   ```bash
   /pm:prd-parse [app-clone-name]
   ```

3. **Set up monitoring**:
   - Track original app for updates
   - Monitor competitor launches
   - Watch for market changes

### Quality Checks

Before finalizing results:
- [ ] Verify MRR data from multiple sources
- [ ] Cross-reference user counts
- [ ] Validate tech stack feasibility
- [ ] Confirm no legal/TOS issues
- [ ] Check for existing clones
- [ ] Assess market saturation

### Post-Scout Actions

After successful scout:
1. Display summary: "✅ Found X apps, Y meet criteria, Z are high-opportunity"
2. Show top 3 recommendations with scores
3. Suggest next step based on findings:
   - If score > 80: "Ready to build! Run: /build:start [app-name]"
   - If score 60-80: "Good opportunities. Review report for best fit"
   - If score < 60: "Limited opportunities. Try different search focus"

### Error Handling

- **No results**: Expand search terms, try related categories
- **API limits**: Use cached data, schedule retry
- **Invalid data**: Flag and skip, continue with others
- **MCP failures**: Fallback to WebSearch tool

## Advanced Options

### Continuous Monitoring Mode
```
/research:app-scout "trending" --monitor daily
```
Sets up daily automated scouts with change detection

### Competitive Tracking
```
/research:app-scout --track "competitor-name"
```
Monitors specific competitor for changes

### Bulk Analysis
```
/research:app-scout --input-file "apps-list.txt"
```
Analyzes predefined list of apps

## Integration with SAZ-CCPM

This command integrates with:
- `/pm:prd-new` - Create PRD for promising apps
- `/pm:epic-start` - Begin implementation
- `/build:start` - Quick prototype generation
- `/research:analyze` - Deep dive on specific app

## Success Metrics

Track scout effectiveness:
- Apps discovered per scout
- Score accuracy (vs actual build success)
- Time to first customer
- MRR achievement vs projection

Remember: The goal is finding apps that can reach $5k+ MRR within 6 months with minimal marketing spend.