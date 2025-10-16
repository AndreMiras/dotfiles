<!--
Attribution: Forked from https://github.com/humanlayer/humanlayer/blob/v0.12.0/.claude/commands/
Modified to work with regular Claude Code license (removed MCP/HumanLayer dependencies)
-->

# Implementation Plan (Simple)

You are tasked with creating detailed implementation plans through an interactive, iterative process using direct tools only.

## Initial Setup

When this command is invoked:

1. **Check if parameters were provided**:
   - If a file path or task description was provided as a parameter, read any mentioned files FULLY first
   - Begin the analysis process

2. **If no specific task provided**, respond with:
```
I'll help you create a detailed implementation plan. Please provide:
1. The task description (or reference to a file/document)
2. Any relevant context, constraints, or specific requirements
3. Related files or areas of the codebase to consider
```

Then wait for the user's input.

## Process Steps

### Step 1: Understanding the Task

1. **Read all mentioned files immediately and FULLY**:
   - Task descriptions, research documents, configuration files
   - **IMPORTANT**: Use the Read tool WITHOUT limit/offset parameters to read entire files
   - This ensures you have full context before proceeding

2. **Ask clarifying questions**:
   - Present your understanding of the task
   - Identify ambiguities or missing information
   - Ask specific questions about scope and requirements
   ```
   Based on [source], I understand we need to [summary].

   Before I create the plan, I need to clarify:
   - [Specific question about scope]
   - [Technical detail question]
   - [Design preference question]
   ```

### Step 2: Research the Codebase

1. **Create a research todo list** using TodoWrite to track exploration

2. **Use direct tools to research**:
   - Use **Glob** to find relevant files by patterns
   - Use **Grep** to search for keywords, function names, patterns
   - Use **Read** to examine files you discover
   - Make multiple tool calls in parallel when searching for independent things

3. **Document findings as you go**:
   - Note existing patterns to follow
   - Identify files that will need changes
   - Find similar implementations to model after
   - Discover constraints or dependencies

4. **Search thoughts/ directory for context**:
   - Use **Glob** to find relevant documents: `thoughts/**/*.md`
   - Use **Grep** to search for related decisions or research
   - Use **Read** to examine historical context

5. **Present findings and design options**:
   ```
   Based on my research, here's what I found:

   **Current State:**
   - [Key discovery about existing code with file:line]
   - [Pattern or convention to follow]

   **Design Options:**
   1. [Option A] - [pros/cons]
   2. [Option B] - [pros/cons]

   **Open Questions:**
   - [Technical uncertainty needing clarification]

   Which approach aligns best with your vision?
   ```

### Step 3: Plan Structure Development

Once aligned on approach:

1. **Create initial plan outline**:
   ```
   Here's my proposed plan structure:

   ## Overview
   [1-2 sentence summary]

   ## Implementation Phases:
   1. [Phase name] - [what it accomplishes]
   2. [Phase name] - [what it accomplishes]
   3. [Phase name] - [what it accomplishes]

   Does this phasing make sense? Should I adjust the order or granularity?
   ```

2. **Get feedback on structure** before writing details

### Step 4: Write the Implementation Plan

After structure approval:

1. **Gather metadata first**:
   - Use **Bash** to run:
     - Current date/time: `date -Iseconds`
     - Git commit: `git rev-parse HEAD`
     - Branch: `git branch --show-current`
     - Repository name: `basename $(git rev-parse --show-toplevel)`
   - Determine filename: `thoughts/shared/plans/YYYY-MM-DD-description.md`
     - Format: `YYYY-MM-DD-description.md` where:
       - YYYY-MM-DD is today's date
       - description is a brief kebab-case description

2. **Create the directory if needed**:
   ```bash
   mkdir -p thoughts/shared/plans
   ```

3. **Write the plan** using this template:

````markdown
---
date: [ISO format date with timezone]
author: Claude Code
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

### Key Discoveries:
- [Important finding with file:line reference]
- [Pattern to follow]
- [Constraint to work within]

## Desired End State

[A specification of the desired end state after this plan is complete, and how to verify it]

## What We're NOT Doing

[Explicitly list out-of-scope items to prevent scope creep]

## Implementation Approach

[High-level strategy and reasoning]

## Phase 1: [Descriptive Name]

### Overview
[What this phase accomplishes]

### Changes Required:

#### 1. [Component/File Group]
**File**: `path/to/file.ext`
**Changes**: [Summary of changes]

```[language]
// Specific code to add/modify
```

**Rationale**: [Why this change is needed]

### Success Criteria:

#### Automated Verification:
- [ ] Tests pass: `make test` (or specific test command)
- [ ] Linting passes: `make lint`
- [ ] Type checking passes: `make typecheck`
- [ ] Build succeeds: `make build`

#### Manual Verification:
- [ ] Feature works as expected when tested manually
- [ ] Edge cases handled correctly
- [ ] No regressions in related functionality
- [ ] Performance is acceptable

**Implementation Note**: After completing this phase and all automated verification passes, pause for manual confirmation before proceeding to the next phase.

---

## Phase 2: [Descriptive Name]

[Similar structure with both automated and manual success criteria...]

---

## Testing Strategy

### Unit Tests:
- [What to test]
- [Key edge cases]

### Integration Tests:
- [End-to-end scenarios]

### Manual Testing Steps:
1. [Specific step to verify feature]
2. [Another verification step]
3. [Edge case to test manually]

## Performance Considerations

[Any performance implications or optimizations needed]

## Migration Notes

[If applicable, how to handle existing data/configurations]

## References

- Original task description: [location]
- Related research: `thoughts/shared/research/[relevant].md`
- Similar implementation: `[file:line]`
- Relevant documentation: [links]
````

4. **Use Write tool to create the plan file**

### Step 5: Review and Iterate

1. **Present the plan location**:
   ```
   I've created the implementation plan at:
   `thoughts/shared/plans/YYYY-MM-DD-description.md`

   Please review it and let me know:
   - Are the phases properly scoped?
   - Are the success criteria specific enough?
   - Any technical details that need adjustment?
   - Missing edge cases or considerations?
   ```

2. **Iterate based on feedback**:
   - Use **Read** to get current plan content
   - Use **Edit** to make changes
   - Update metadata fields if needed:
     - `last_updated: [date]`
     - `last_updated_by: Claude Code`
   - Continue refining until satisfied

3. **Mark status as ready**:
   - When plan is finalized, update frontmatter: `status: ready`
   - Use **Edit** to change the status field

## Important Guidelines

1. **Be Thorough**:
   - Read all context files COMPLETELY before planning
   - Research actual code patterns using direct tools
   - Include specific file paths and line numbers
   - Write measurable success criteria with clear automated vs manual distinction

2. **Be Interactive**:
   - Don't write the full plan in one shot
   - Get buy-in at each major step
   - Allow course corrections
   - Work collaboratively

3. **Be Skeptical**:
   - Question vague requirements
   - Identify potential issues early
   - Ask "why" and "what about"
   - Verify assumptions with code

4. **Be Practical**:
   - Focus on incremental, testable changes
   - Consider migration and rollback
   - Think about edge cases
   - Include "what we're NOT doing"

5. **No Open Questions in Final Plan**:
   - If you encounter open questions during planning, STOP
   - Research or ask for clarification immediately
   - Do NOT write the plan with unresolved questions
   - The implementation plan must be complete and actionable

## Tool Usage Guidelines

**Finding Files:**
- Use Glob with patterns like:
  - `**/*.py` - all Python files
  - `**/*config*` - files with "config" in name
  - `**/*.lua` - all Lua files

**Searching Content:**
- Use Grep to search for:
  - Function names: `pattern: "function_name"`
  - Keywords: `pattern: "keyword"`
  - Patterns: `pattern: "class.*Config"`
  - With context: use `-A`, `-B`, or `-C` parameters
  - Set `output_mode: "content"` to see matching lines
  - Set `output_mode: "files_with_matches"` to see just file paths

**Reading Files:**
- Use Read to examine files
- Read full files without limit/offset to get complete context
- Read multiple files in parallel when they're independent

**Editing Files:**
- Use Edit to update the plan based on feedback
- Use Write only for creating new files

**Metadata Gathering:**
- Use Bash to get git information, dates, etc.
- Always gather real metadata before writing documents

## Success Criteria Guidelines

**Always separate success criteria into two categories:**

1. **Automated Verification** (can be run by execution):
   - Commands that can be run: `make test`, `npm run lint`, etc.
   - Specific files that should exist
   - Code compilation/type checking
   - Automated test suites

2. **Manual Verification** (requires human testing):
   - UI/UX functionality
   - Performance under real conditions
   - Edge cases that are hard to automate
   - User acceptance criteria

## Common Patterns

### For Configuration Changes:
- Identify current configuration location
- Understand default vs custom values
- Plan backward compatibility
- Document testing approach

### For New Features:
- Research existing patterns first
- Start with data model
- Build core logic
- Add tests
- Update documentation

### For Refactoring:
- Document current behavior
- Plan incremental changes
- Maintain backwards compatibility
- Include migration strategy

## Track Progress

- Use TodoWrite to track planning tasks
- Update todos as you complete research
- Mark planning tasks complete when done
