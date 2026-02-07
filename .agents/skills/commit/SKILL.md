---
name: commit
description: Use when the user asks to create git commits for the changes made in the working tree. Review git status/diff, propose a commit plan (one or multiple commits), get explicit user approval, then stage files explicitly (never git add . or -A) and commit with clean messages. Never add any AI/Claude attribution or co-author lines.
---

# Commit Changes

You are tasked with creating git commits for the changes made during this session.

## Process

### 1) Inspect what changed
- Review the conversation context to understand what was accomplished.
- Run:
  - `git status`
  - `git diff`
  - If needed: `git diff --staged`
- Determine whether the changes should be:
  - one commit, or
  - multiple logical commits.

### 2) Plan the commit(s)
- Identify which files belong together.
- Draft clear, descriptive commit messages.
- Use imperative mood in commit messages.
- Focus on why the changes were made, not just what.

### 3) Present the plan to the user (mandatory)
Before committing anything, present:
- How many commits you plan to create.
- For each commit:
  - the list of files you will stage
  - the commit message you will use

Then ask:

"I plan to create [N] commit(s) with these changes. Shall I proceed?"

Do not proceed without explicit confirmation.

### 4) Execute upon confirmation
- Stage files explicitly:
  - Use `git add path/to/file` for specific files only.
  - Never use `git add .` or `git add -A`.
- Create the commit(s) with the planned messages.
- Show the result:
  - `git log --oneline -n [N+2]` (or similar)

## Important Rules

- NEVER add co-author information or any AI attribution.
- Do not include:
  - "Generated with Claude"
  - "Generated with Codex"
  - "Co-Authored-By"
  - any similar footer
- Commits should be authored solely by the user.
- Write commit messages as if the user wrote them.

## Guidance

- Keep commits focused and atomic when possible.
- If there are unrelated formatting/lint changes, separate them into their own commit.
- If there are large mechanical changes, consider isolating them.
- If there are changes you are unsure about committing, ask before staging.
