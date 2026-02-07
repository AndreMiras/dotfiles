---
name: create-plan-simple
description: >-
  Use when the user wants a detailed, actionable implementation plan for a change/feature/bugfix.
  This is an interactive, research-driven planning workflow: read relevant files, clarify requirements,
  research existing patterns, propose options, align on approach, then write a plan doc to thoughts/shared/plans/.
  Do not produce a full plan immediately without first clarifying and researching.
---

# Implementation Plan (Simple)

You are tasked with creating detailed implementation plans through an interactive, iterative process using direct inspection tools only (shell commands + reading files).

## Initial Setup

When this skill is invoked:

1) If the user already provided a task description and/or referenced files:
- Read any mentioned files fully first.
- Begin Step 1 immediately.

2) If no specific task is provided, respond with:

"I'll help you create a detailed implementation plan. Please provide:
1. The task description (or reference to a file/document)
2. Any relevant context, constraints, or specific requirements
3. Related files or areas of the codebase to consider"

Then wait for the user's input.

## Process Steps

### Step 1: Understanding the Task

1) Read all mentioned files immediately and fully
- Task descriptions, research documents, configuration files, etc.
- Prefer full-file reads (no truncation) whenever feasible.

2) Ask clarifying questions
- Present your understanding of the task.
- Identify ambiguities or missing information.
- Ask specific questions about scope and requirements.

Use this format:

Based on [source], I understand we need to [summary].

Before I create the plan, I need to clarify:
- [Specific question about scope]
- [Technical detail question]
- [Design preference question]

### Step 2: Research the Codebase

1) Create a research checklist
- Track exploration topics (files to inspect, symbols to search, similar implementations).

2) Research using direct inspection
- File discovery: `find`, `fd`, `ls`, etc.
- Content search: `rg` (ripgrep) / `grep` for keywords, types, function names, config keys.
- Read relevant files.
- Run multiple searches in parallel when independent.

3) Document findings as you go
- Existing patterns to follow.
- Files that will need changes.
- Similar implementations to model after.
- Constraints or dependencies discovered.

4) Search `thoughts/` for context
- Look for prior research/plans/decisions under `thoughts/**/*.md`.
- Treat `thoughts/` as supplementary; live code is the source of truth.

5) Present findings and design options
Use this format:

Based on my research, here's what I found:

**Current State:**
- [Key discovery about existing code with path:line-range]
- [Pattern or convention to follow]

**Design Options:**
1. [Option A] - [pros/cons]
2. [Option B] - [pros/cons]

**Open Questions:**
- [Anything still unclear]

Then ask:
"Which approach aligns best with your vision?"

Do not proceed until aligned or ambiguities are resolved.

### Step 3: Plan Structure Development

Once aligned on approach:

1) Propose the plan structure:

Here's my proposed plan structure:

## Overview
[1-2 sentence summary]

## Implementation Phases:
1. [Phase name] - [what it accomplishes]
2. [Phase name] - [what it accomplishes]
3. [Phase name] - [what it accomplishes]

Then ask:
"Does this phasing make sense? Should I adjust the order or granularity?"

2) Get feedback on structure before writing details.

### Step 4: Write the Implementation Plan

After structure approval:

1) Gather metadata first (shell):
- Current date/time (ISO with timezone): `date -Iseconds`
- Git commit: `git rev-parse HEAD`
- Branch: `git branch --show-current`
- Repository name: `basename "$(git rev-parse --show-toplevel)"`

2) Ensure directory exists:
- `mkdir -p thoughts/shared/plans`

3) Determine filename:
- `thoughts/shared/plans/YYYY-MM-DD-description.md`
  - YYYY-MM-DD is today’s date
  - description is a brief kebab-case summary

4) Write the plan using this template (fill with real values; no placeholders):

---
date: [ISO format date with timezone]
author: Codex
git_commit: [Current commit hash]
branch: [Current branch name]
repository: [Repository name]
title: "[Feature/Task Name]"
tags: [plan, implementation, relevant-components]
status: draft
---

# [Feature/Task Name] Implementation Plan

## Overview
[Brief description of what we're implementing and why]

## Current State Analysis
[What exists now, what's missing, key constraints discovered]

### Key Discoveries
- [Important finding with path:line-range reference]
- [Pattern to follow]
- [Constraint to work within]

## Desired End State
[A specification of the desired end state after this plan is complete, and how to verify it]

## What We're NOT Doing
[Explicit out-of-scope items to prevent scope creep]

## Implementation Approach
[High-level strategy and reasoning]

## Phase 1: [Descriptive Name]

### Overview
[What this phase accomplishes]

### Changes Required

#### 1. [Component/File Group]
**File**: `path/to/file.ext`
**Changes**: [Summary of changes]

```[language]
# Specific code to add/modify (only if helpful)
````

**Rationale**: [Why this change is needed]

### Success Criteria

#### Automated Verification

* [ ] Tests pass: `...`
* [ ] Linting passes: `...`
* [ ] Type checking passes: `...`
* [ ] Build succeeds: `...`

#### Manual Verification

* [ ] Feature works as expected when tested manually
* [ ] Edge cases handled correctly
* [ ] No regressions in related functionality
* [ ] Performance is acceptable

Implementation note: after completing this phase and automated verification passes, pause for manual confirmation before proceeding to the next phase.

---

## Phase 2: [Descriptive Name]

[Repeat structure...]

---

## Testing Strategy

### Unit Tests

* [What to test]
* [Key edge cases]

### Integration Tests

* [End-to-end scenarios]

### Manual Testing Steps

1. [Specific step to verify feature]
2. [Another verification step]
3. [Edge case to test manually]

## Performance Considerations

[Any implications]

## Migration Notes

[If applicable]

## References

* Original task description: [location]
* Related research: `thoughts/shared/research/[relevant].md`
* Similar implementation: `path/to/file.ext:line-range`
* External docs: [links if provided]

5. Write the plan file to `thoughts/shared/plans/...`.

### Step 5: Review and Iterate

1. Present the plan location:

I've created the implementation plan at:
`thoughts/shared/plans/YYYY-MM-DD-description.md`

Please review it and let me know:

* Are the phases properly scoped?
* Are the success criteria specific enough?
* Any technical details that need adjustment?
* Missing edge cases or considerations?

2. Iterate based on feedback

* Read the existing plan, edit it, and refine until satisfied.
* If you add updates, add/update:

  * `last_updated: [YYYY-MM-DD]`
  * `last_updated_by: Codex`

3. Mark as ready

* When finalized, update frontmatter: `status: ready`

## Important Guidelines

* Be thorough: read context fully, research actual patterns, cite file references precisely.
* Be interactive: do not write the full plan in one shot; get buy-in at major steps.
* Be skeptical: challenge vague requirements; verify assumptions in code.
* Be practical: incremental, testable changes; consider rollback/migrations; include explicit out-of-scope.
* No open questions in the final plan:

  * If something is unclear, stop and resolve it before finalizing the plan.

## Notes

### Path handling for thoughts/

If `thoughts/searchable/` exists, paths may be hard links.
When documenting paths, remove ONLY `searchable/` and preserve subdirectories.
