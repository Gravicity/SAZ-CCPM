---
allowed-tools: Task, Read, Write, MultiEdit, Bash, TodoWrite
---

# Quick Clone

Rapidly scaffold a clone based on analyzed apps from the database.

## Usage
```
/research:quick-clone <app-name-from-db> [--name <clone-name>] [--stack <tech>] [--days <target>]
```

## Examples
```
/research:quick-clone "easy-folders" --name "FolderGPT" --days 7
/research:quick-clone "css-scan" --name "StyleSnap" --stack nextjs
/research:quick-clone "bank-statement-converter" 
```

## Options
- `--name <clone-name>`: Name for your clone. Default: generates suggestion
- `--stack <tech>`: Tech stack (nextjs|react|vue|svelte|chrome). Default: auto-selects
- `--days <target>`: Target days to MVP (7|14|21|30). Default: 14
- `--features <list>`: Comma-separated MVP features. Default: core features only

## Instructions

You are rapidly scaffolding a clone of: **$ARGUMENTS**

### Phase 1: Load App Data

#### 1.1 Fetch from Database
```bash
# Read the profitable apps database
cat research-results/profitable-apps-database.json | jq '.apps[] | select(.name=="$ARGUMENTS")'
```

If not found, check for partial match or suggest alternatives.

#### 1.2 Extract Clone Requirements
```javascript
const appData = {
  original_name: "from database",
  mrr: "current MRR",
  tech_stack: "original stack",
  features: ["core features"],
  improvements: ["our 1% better additions"],
  build_time_weeks: "estimated time"
};
```

### Phase 2: Generate Clone Specification

#### 2.1 Name Generation (if not provided)
```javascript
function generateCloneName(originalName) {
  // Strategies:
  // 1. Add descriptor: "Smart" + Original
  // 2. Rhyme/similar: "TypeMind" -> "TypeGenius"
  // 3. Feature focus: "FolderOrganizer" -> "FolderSync"
  // 4. Platform specific: "ChromeSwiper"
  
  return suggestions;
}
```

#### 2.2 Feature Prioritization
```markdown
## MVP Features (Week 1)
Must have for launch:
- [ ] Core feature 1
- [ ] Core feature 2
- [ ] Payment integration
- [ ] Basic auth

## Quick Wins (Week 2)
1% better additions:
- [ ] Improvement 1
- [ ] Improvement 2

## Future Features (Post-launch)
- [ ] Advanced feature 1
- [ ] Advanced feature 2
```

### Phase 3: Project Scaffolding

#### 3.1 Create Project Structure
```bash
# Create project directory
mkdir -p $CLONE_NAME
cd $CLONE_NAME

# Initialize based on stack
if [[ "$STACK" == "nextjs" ]]; then
  npx create-next-app@latest . --typescript --tailwind --app
elif [[ "$STACK" == "chrome" ]]; then
  npx plasmo init
fi

# Set up standard directories
mkdir -p src/components src/lib src/hooks src/types
mkdir -p public/images public/fonts
mkdir -p docs tests
```

#### 3.2 Install Dependencies
```bash
# Core dependencies based on app type
npm install @supabase/supabase-js stripe @vercel/analytics

# Development dependencies
npm install -D @types/node prettier eslint vitest
```

### Phase 4: Generate Core Files

#### 4.1 Environment Configuration
Create `.env.local`:
```env
# Supabase
NEXT_PUBLIC_SUPABASE_URL=your-project-url
NEXT_PUBLIC_SUPABASE_ANON_KEY=your-anon-key

# Stripe
STRIPE_SECRET_KEY=sk_test_xxx
NEXT_PUBLIC_STRIPE_PUBLISHABLE_KEY=pk_test_xxx

# App Config
NEXT_PUBLIC_APP_NAME=$CLONE_NAME
NEXT_PUBLIC_APP_URL=http://localhost:3000
```

#### 4.2 Authentication Boilerplate
Create `src/lib/auth.ts`:
```typescript
import { createClient } from '@supabase/supabase-js'

const supabase = createClient(
  process.env.NEXT_PUBLIC_SUPABASE_URL!,
  process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY!
)

export async function signUp(email: string, password: string) {
  // Implementation
}

export async function signIn(email: string, password: string) {
  // Implementation
}
```

#### 4.3 Payment Integration
Create `src/lib/stripe.ts`:
```typescript
import Stripe from 'stripe'

const stripe = new Stripe(process.env.STRIPE_SECRET_KEY!, {
  apiVersion: '2023-10-16',
})

export async function createCheckoutSession(priceId: string) {
  // Implementation
}

export async function createCustomerPortal(customerId: string) {
  // Implementation
}
```

### Phase 5: Feature Implementation

#### 5.1 Core Feature Templates
Based on app type, generate:

**For Chrome Extensions:**
```javascript
// manifest.json
{
  "manifest_version": 3,
  "name": "$CLONE_NAME",
  "version": "1.0.0",
  "permissions": ["storage", "tabs"],
  "action": {
    "default_popup": "popup.html"
  }
}
```

**For SaaS Apps:**
```typescript
// src/app/dashboard/page.tsx
export default function Dashboard() {
  return (
    <div>
      <h1>Dashboard</h1>
      {/* Core feature components */}
    </div>
  )
}
```

**For API Services:**
```typescript
// src/app/api/v1/[endpoint]/route.ts
export async function POST(request: Request) {
  // API implementation
}
```

### Phase 6: UI/UX Setup

#### 6.1 Landing Page
Create `src/app/page.tsx`:
```typescript
export default function Home() {
  return (
    <div>
      {/* Hero Section */}
      <section>
        <h1>$CLONE_NAME</h1>
        <p>$TAGLINE</p>
        <button>Get Started</button>
      </section>
      
      {/* Features */}
      <section>
        {/* Feature grid */}
      </section>
      
      {/* Pricing */}
      <section>
        {/* Pricing cards */}
      </section>
    </div>
  )
}
```

#### 6.2 Component Library
Create reusable components:
```typescript
// src/components/ui/button.tsx
// src/components/ui/card.tsx
// src/components/ui/input.tsx
// src/components/ui/modal.tsx
```

### Phase 7: Testing Setup

#### 7.1 Test Configuration
Create `vitest.config.ts`:
```typescript
import { defineConfig } from 'vitest/config'

export default defineConfig({
  test: {
    environment: 'jsdom',
    setupFiles: './tests/setup.ts',
  },
})
```

#### 7.2 Initial Tests
Create `tests/auth.test.ts`:
```typescript
describe('Authentication', () => {
  test('should sign up new user', async () => {
    // Test implementation
  })
})
```

### Phase 8: Deployment Preparation

#### 8.1 Docker Configuration
Create `Dockerfile`:
```dockerfile
FROM node:20-alpine
WORKDIR /app
COPY package*.json ./
RUN npm ci --only=production
COPY . .
RUN npm run build
CMD ["npm", "start"]
```

#### 8.2 CI/CD Pipeline
Create `.github/workflows/deploy.yml`:
```yaml
name: Deploy
on:
  push:
    branches: [main]
jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: actions/setup-node@v3
      - run: npm ci
      - run: npm test
      - run: npm run build
      - uses: vercel/action@v20
```

### Phase 9: Documentation

#### 9.1 README Generation
Create comprehensive README.md with:
- Project overview
- Quick start guide
- Feature list
- Tech stack
- Deployment instructions
- Contributing guidelines

#### 9.2 Launch Checklist
Create `docs/LAUNCH_CHECKLIST.md`:
```markdown
# Launch Checklist

## Pre-launch (Day -7)
- [ ] Feature freeze
- [ ] Beta testing with 10 users
- [ ] Fix critical bugs
- [ ] Prepare marketing materials

## Launch Day
- [ ] Deploy to production
- [ ] Submit to Product Hunt
- [ ] Post on social media
- [ ] Email list announcement

## Post-launch (Day +1)
- [ ] Monitor for issues
- [ ] Respond to feedback
- [ ] Track metrics
- [ ] Plan iteration
```

### Phase 10: Generate Implementation Plan

#### 10.1 Create Todo List
Use TodoWrite to create implementation tasks:
```javascript
const todos = [
  { content: "Set up project structure", status: "pending" },
  { content: "Implement authentication", status: "pending" },
  { content: "Build core feature: " + coreFeature1, status: "pending" },
  { content: "Add payment integration", status: "pending" },
  { content: "Create landing page", status: "pending" },
  { content: "Deploy MVP", status: "pending" }
];
```

#### 10.2 Time Estimation
```markdown
## Timeline to MVP

### Day 1-2: Foundation
- Project setup
- Auth system
- Database schema

### Day 3-5: Core Features
- Feature 1 implementation
- Feature 2 implementation
- Basic UI

### Day 6-7: Polish & Launch
- Payment integration
- Landing page
- Deployment

Total: $DAYS days to MVP
```

### Phase 11: Competitive Positioning

#### 11.1 Generate Comparison Page
Create `docs/COMPETITIVE_ANALYSIS.md`:
```markdown
# $CLONE_NAME vs $ORIGINAL_NAME

| Feature | $ORIGINAL | $CLONE_NAME |
|---------|-----------|-------------|
| Price | $30/mo | $24/mo |
| [Feature] | ✅ | ✅ |
| [Our Addition] | ❌ | ✅ |
```

#### 11.2 Migration Guide
Create `docs/MIGRATION_GUIDE.md`:
```markdown
# Migrating from $ORIGINAL to $CLONE_NAME

1. Export your data from $ORIGINAL
2. Import into $CLONE_NAME
3. Enjoy new features!
```

### Success Criteria

Quick clone is successful if:
- [ ] Project runs locally within 10 minutes
- [ ] Core feature implemented in scaffold
- [ ] Payment ready to connect
- [ ] Can deploy to Vercel/Netlify immediately
- [ ] Clear path to MVP in target days

### Post-Scaffold Actions

After scaffolding complete:
1. Display summary: "✅ Clone scaffolded: $CLONE_NAME"
2. Show immediate next steps:
   ```
   cd $CLONE_NAME
   npm install
   npm run dev
   ```
3. Suggest: "Ready to implement! Check todos with: /todo:list"
4. Remind: "MVP target: $DAYS days. Stay focused on core features!"

### Integration with Other Commands

- Use after `/research:app-analyze` identifies good candidate
- Triggers `/pm:prd-new` for detailed planning if needed
- Can initiate `/research:app-monitor` for original app
- Links to `/pm:epic-start` for team collaboration

Remember: The goal is to go from idea to running code in under 30 minutes, with clear path to MVP in days, not weeks.