---
description: List the user-scoped commands and skills in ~/.claude (fast, hardcoded — refresh with /toolbox-update).
---

Output exactly the following text verbatim, with no preamble, commentary, or trailing summary:

**Commands**
- `/grill-me` — Interview me relentlessly to stress-test a plan or design.
- `/to-issues` — Break a plan/PRD into independently-grabbable issues using tracer-bullet vertical slices.
- `/to-prd` — Turn the current conversation context into a PRD and publish it to the issue tracker.
- `/toolbox` — List the user-scoped commands and skills in ~/.claude (fast, hardcoded — refresh with /toolbox-update).
- `/toolbox-update` — Rescan ~/.claude and refresh the hardcoded list inside /toolbox.
- `/write-a-skill` — Create a new agent skill with proper structure and progressive disclosure.
- `/zoom-out` — Zoom out and give a higher-level map of the surrounding code.

**Skills**
- `/diagnose` (engineering) — Disciplined diagnosis loop for hard bugs and performance regressions.
- `/grill-with-docs` (engineering) — Grilling session that challenges your plan against the existing domain model, sharpens terminology, and updates documentation (CONTEXT.md, ADRs) inline as decisions crystallise.
- `/improve-codebase-architecture` (engineering) — Find deepening opportunities in a codebase, informed by the domain language in CONTEXT.md and the decisions in docs/adr/.
- `/setup-matt-pocock-skills` (engineering) — Sets up an `## Agent skills` block in AGENTS.md/CLAUDE.md and `docs/agents/` so the engineering skills know this repo's issue tracker (GitHub or local markdown), triage label vocabulary, and domain doc layout.
- `/tdd` (engineering) — Test-driven development with red-green-refactor loop.
- `/triage` (engineering) — Triage issues through a state machine driven by triage roles.
