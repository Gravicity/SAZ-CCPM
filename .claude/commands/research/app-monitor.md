---
allowed-tools: Task, WebFetch, WebSearch, Read, Write, Bash, Grep
---

# App Monitor

Track competitor apps and market changes over time.

## Usage
```
/research:app-monitor <action> <app-name> [--frequency <interval>] [--metrics <list>]
```

## Examples
```
/research:app-monitor add "typingmind" --frequency daily --metrics pricing,features
/research:app-monitor check "easy-folders"
/research:app-monitor report --all
/research:app-monitor remove "questgen"
```

## Actions
- `add`: Start monitoring an app
- `check`: Run immediate check on specific app
- `report`: Generate monitoring report
- `remove`: Stop monitoring an app
- `list`: Show all monitored apps

## Options
- `--frequency <interval>`: How often to check (daily|weekly|monthly). Default: weekly
- `--metrics <list>`: What to track (pricing,features,users,reviews,traffic). Default: all
- `--alert-on <changes>`: Send alerts for specific changes. Default: pricing,major-features

## Instructions

### Phase 1: Setup Monitoring

#### 1.1 Create Monitoring Database
Path: `research-results/monitoring/apps.json`

```json
{
  "monitored_apps": [
    {
      "name": "app-name",
      "url": "website",
      "added_date": "ISO date",
      "frequency": "daily|weekly|monthly",
      "metrics": ["pricing", "features", "users"],
      "last_check": "ISO date",
      "next_check": "ISO date",
      "baseline": {
        "pricing": {},
        "features": [],
        "users": "count",
        "traffic": "estimate"
      },
      "history": []
    }
  ]
}
```

#### 1.2 Initialize Baseline (for 'add' action)
When adding new app to monitor:

```javascript
async function createBaseline(appName) {
  const baseline = {
    pricing: await fetchPricing(appName),
    features: await fetchFeatures(appName),
    users: await estimateUsers(appName),
    reviews: await fetchReviews(appName),
    traffic: await estimateTraffic(appName),
    last_updated: new Date().toISOString()
  };
  return baseline;
}
```

### Phase 2: Monitoring Checks

#### 2.1 Daily Monitoring Tasks
For apps with daily frequency:

```markdown
## Daily Checks
1. Pricing page changes (WebFetch)
2. Product Hunt ranking (if listed)
3. Social media mentions (EXA search)
4. New reviews (if available)
```

#### 2.2 Weekly Monitoring Tasks
For apps with weekly frequency:

```markdown
## Weekly Checks
1. Feature updates (changelog, blog)
2. User count estimates
3. Traffic trends (similarweb)
4. Competitor landscape changes
5. Marketing campaign detection
```

#### 2.3 Monthly Deep Dive
For all monitored apps monthly:

```markdown
## Monthly Analysis
1. Growth trajectory analysis
2. Market position changes
3. New competitor emergence
4. Technology stack updates
5. Team/funding changes
```

### Phase 3: Change Detection

#### 3.1 Detect Changes
```javascript
function detectChanges(current, baseline) {
  const changes = {
    pricing: comparePricing(current.pricing, baseline.pricing),
    features: compareFeatures(current.features, baseline.features),
    users: compareUsers(current.users, baseline.users),
    significance: "none|minor|major|critical"
  };
  
  return changes;
}
```

#### 3.2 Change Classifications
- **Critical**: Price changes, major pivot, shutdown
- **Major**: New major feature, platform expansion
- **Minor**: UI updates, small features, bug fixes
- **None**: No significant changes

### Phase 4: Alert Generation

When changes detected, create alert:

```markdown
# 🚨 Competitor Alert: [App Name]

## Change Detected: [Type]
- **What changed**: [Description]
- **When detected**: [Date]
- **Impact level**: Critical|Major|Minor
- **Our response needed**: Yes|No|Monitor

## Details
[Specific details about the change]

## Recommended Actions
1. [If critical: Immediate response needed]
2. [If major: Plan counter-strategy]
3. [If minor: Note and continue monitoring]

## Market Impact
- Affects our positioning: [How]
- Opportunity created: [What]
- Risk introduced: [What]
```

### Phase 5: Reporting

#### 5.1 Individual App Report
Path: `research-results/monitoring/reports/[app-name]-[date].md`

```markdown
# Monitoring Report: [App Name]

## Summary
- Monitoring since: [Date]
- Total changes detected: [Count]
- Current status: Growing|Stable|Declining

## Key Metrics
| Metric | Start | Current | Change | Trend |
|--------|-------|---------|--------|-------|
| Pricing | $X | $Y | +Z% | ↑ |
| Users | X | Y | +Z% | ↑ |
| Features | X | Y | +Z | → |

## Timeline of Changes
- [Date]: [Change description]
- [Date]: [Change description]

## Competitive Insights
[What we've learned from monitoring]

## Opportunities Identified
1. [Gap they haven't filled]
2. [Feature they removed]
3. [Market they abandoned]
```

#### 5.2 Market Overview Report
Path: `research-results/monitoring/market-report-[date].md`

```markdown
# Market Monitoring Report

## Executive Summary
Monitoring X apps across Y categories

## Market Trends
1. **Pricing**: Overall trend up/down/stable
2. **Features**: Common additions across apps
3. **Consolidation**: Mergers or shutdowns

## Top Movers
### Biggest Gainers
1. [App]: [What changed]

### Biggest Losers
1. [App]: [What happened]

## Opportunities
Based on monitoring, best opportunities:
1. [Gap in market]
2. [Underserved segment]

## Threats
Watch out for:
1. [Emerging competitor]
2. [Market shift]
```

### Phase 6: Automation Setup

#### 6.1 Cron Job Configuration
Create monitoring schedule:

```bash
# Add to crontab or scheduler
# Daily checks at 9 AM
0 9 * * * /research:app-monitor check --frequency daily

# Weekly checks on Mondays
0 10 * * 1 /research:app-monitor check --frequency weekly

# Monthly reports on 1st
0 11 1 * * /research:app-monitor report --all
```

#### 6.2 Historical Data Management
```javascript
{
  "retention_policy": {
    "raw_data": "90 days",
    "summaries": "1 year",
    "alerts": "6 months"
  },
  "storage_location": "research-results/monitoring/history/",
  "backup_location": "research-results/monitoring/backup/"
}
```

### Phase 7: Competitive Intelligence

#### 7.1 Pattern Recognition
Track patterns across monitored apps:

```markdown
## Patterns Detected
1. **Pricing pattern**: Apps raising prices before feature launch
2. **Feature pattern**: AI features being added across category
3. **Marketing pattern**: Shift from SEO to paid acquisition
```

#### 7.2 Predictive Insights
Based on patterns, predict:

```markdown
## Predictions
1. **[App Name]** likely to:
   - Raise prices (confidence: 75%)
   - Based on: Historical pattern + recent features
   
2. **Market trend**:
   - Consolidation expected in [category]
   - Based on: Declining new entrants + acquisitions
```

### Phase 8: Integration Actions

Based on monitoring insights:

#### 8.1 Trigger PRD Updates
If competitor adds game-changing feature:
```bash
/pm:prd-update [our-app] --add-feature [competitive-response]
```

#### 8.2 Trigger Marketing Response
If competitor changes pricing:
```bash
/marketing:campaign competitive-pricing --versus [competitor]
```

#### 8.3 Trigger Feature Fast-Track
If critical competitive threat:
```bash
/pm:epic-start [response-feature] --priority critical
```

### Quality Checks

Before saving monitoring data:
- [ ] Verify data accuracy (cross-reference sources)
- [ ] Check for false positives
- [ ] Validate change significance
- [ ] Ensure historical data integrity
- [ ] Test alert thresholds

### Success Metrics

Track monitoring effectiveness:
- Changes detected vs manually found
- Alert accuracy (false positive rate)
- Time to respond to competitor changes
- Opportunities identified and captured

### Error Handling

- **Site structure changed**: Update selectors, use AI extraction
- **Rate limited**: Implement backoff, rotate requests
- **App disappeared**: Mark as discontinued, final report
- **Data corruption**: Restore from backup, re-baseline

### Post-Monitoring Actions

After each monitoring run:
1. Update database with findings
2. Generate alerts if changes detected
3. Update next check schedule
4. Create summary for dashboard
5. If critical change: Immediate notification

Remember: The goal is to never be surprised by competitor moves and to identify opportunities before they become obvious.