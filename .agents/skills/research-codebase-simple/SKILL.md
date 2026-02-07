---
name: research-codebase-simple
description: Use when the user asks to understand, document, or map an existing codebase (how it works today, where things live, how components interact). Do not use for proposing improvements, refactors, performance tuning, or root-cause analysis unless the user explicitly asks. Primary deliverable is a research document written to thoughts/shared/research/.
---

# Research Codebase (Simple)

You are tasked with conducting comprehensive research across the codebase to answer user questions using direct inspection tools (shell commands + reading files).

## CRITICAL: YOUR ONLY JOB IS TO DOCUMENT AND EXPLAIN THE CODEBASE AS IT EXISTS TODAY
- DO NOT suggest improvements or changes unless the user explicitly asks for them
- DO NOT perform root cause analysis unless the user explicitly asks for it
- DO NOT propose future enhancements unless the user explicitly asks for them
- DO NOT critique the implementation or identify problems
- DO NOT recommend refactoring, optimization, or architectural changes
- ONLY describe what exists, where it exists, how it works, and how components interact
- You are creating a technical map/documentation of the existing system

## Initial Setup

When this skill is invoked, respond with:

"I'm ready to research the codebase. Please provide your research question or area of interest, and I'll analyze it thoroughly."

Then wait for the user's research query.

## CRITICAL: Complete ALL Steps

YOU MUST COMPLETE ALL 10 STEPS BELOW. Do not stop after presenting findings to the user — the research document in `thoughts/shared/research/` is the primary deliverable and MUST be created.

## Steps to follow after receiving the research query

1) Read any directly mentioned files first
- If the user mentions specific files, read them fully first to get context.
- Prefer full-file reads (no truncation) whenever feasible.

2) Analyze and decompose the research question
- Break down the query into specific areas to investigate.
- Identify relevant directories, files, or patterns.
- Create a concrete checklist (mentally or in notes) that includes steps 6-10 (metadata, doc generation, permalinks, sync, follow-ups).

3) Conduct codebase research via direct inspection
- Use file discovery and search techniques:
  - File patterns: `find`, `fd`, `ls`, etc.
  - Content search: `rg` (ripgrep) / `grep`, searching for keywords, symbols, function names, config keys.
  - Read files to understand contents: `sed -n '1,200p'`, `cat`, or your environment’s file viewer.
- Read and cross-reference the relevant files you discover.
- Prefer parallelizable searches when investigating independent threads.

4) Search `thoughts/` for historical context
- Search and read relevant documents under `thoughts/` for prior decisions or explorations.
- Treat `thoughts/` as supplementary context; live code is the source of truth.

5) Synthesize findings (prep for the document)
- Compile findings from code + `thoughts/`.
- Connect components and call paths.
- Include precise references (file paths + line numbers / ranges).
- Answer the user’s question with concrete evidence.
- Continue to step 6 (do not stop here).

Steps 6-10 are mandatory. The research document in `thoughts/` is the primary deliverable.

6) Gather metadata for the research document
- Prefer running `hack/spec_metadata.sh` if it exists.
- Otherwise gather manually (shell):
  - Current date/time (ISO with timezone): `date -Iseconds`
  - Git commit: `git rev-parse HEAD`
  - Branch: `git branch --show-current`
  - Repository name: `basename "$(git rev-parse --show-toplevel)"`
- Determine filename:
  - `thoughts/shared/research/YYYY-MM-DD-ENG-XXXX-description.md`
  - Use today’s date; include ticket `ENG-XXXX` only if the user provided one; pick a short kebab-case description.

7) Generate the research document
- Create the file under `thoughts/shared/research/`.
- Use this structure (fill with real values; no placeholders):

  ---
  date: [ISO format date with timezone]
  researcher: [Your name/identifier]
  git_commit: [Current commit hash]
  branch: [Current branch name]
  repository: [Repository name]
  topic: "[User's Question/Topic]"
  tags: [research, codebase, relevant-components]
  status: complete
  last_updated: [YYYY-MM-DD]
  last_updated_by: [Researcher name]
  ---

  # Research: [User's Question/Topic]

  **Date**: [Full date/time]
  **Researcher**: [Name]
  **Git Commit**: [Hash]
  **Branch**: [Branch name]
  **Repository**: [Repo name]

  ## Research Question
  [Original user query]

  ## Summary
  [High-level findings answering the question]

  ## Detailed Findings

  ### [Component/Area 1]
  - Description of what exists (path:line-range)
  - How it connects to other components
  - Current implementation details

  ### [Component/Area 2]
  ...

  ## Code References
  - `path/to/file.py:123` - Description
  - `another/file.ts:45-67` - Description

  ## Architecture Documentation
  [Current patterns, conventions, and design implementations found]

  ## Historical Context (from thoughts/)
  [Relevant insights from thoughts/ with references]
  - `thoughts/shared/something.md` - Historical decision about X
  Note: Paths exclude "searchable/" even if found there.

  ## Related Research
  [Links to other research documents in thoughts/shared/research/]

  ## Open Questions
  [Areas needing further investigation]

8) Add GitHub permalinks (if applicable)
- Check branch/status:
  - `git branch --show-current`
  - `git status`
- If commit is pushed (or you can reliably generate permalinks), add permalinks for key references:
  - Determine repo owner/name (e.g., via `gh repo view --json owner,name` if available).
  - Permalink format:
    `https://github.com/{owner}/{repo}/blob/{commit}/{path}#L{line}`
- Update the document so key code references include permalinks (keep local refs too if helpful).

9) Sync and present findings
- If a sync command exists in the repo/tooling (e.g., `humanlayer thoughts sync`), run it; otherwise skip.
- Present a concise summary to the user:
  - Key conclusions
  - Key file references with line numbers
  - The research document path in `thoughts/shared/research/...`
- Ask if they have follow-up questions.

10) Handle follow-up questions
- Append follow-up research to the same document:
  - Update frontmatter:
    - `last_updated`, `last_updated_by`
    - Add: `last_updated_note: "Added follow-up research for [brief description]"`
  - Add section: `## Follow-up Research [timestamp]`
- Re-run sync step if available.

## Notes

### Path handling for thoughts/
- `thoughts/searchable/` may contain hard links for searching.
- When documenting paths, remove ONLY `searchable/` and preserve all other subdirectories.
  - `thoughts/searchable/allison/old_stuff/notes.md` → `thoughts/allison/old_stuff/notes.md`
  - `thoughts/searchable/shared/prs/123.md` → `thoughts/shared/prs/123.md`
  - `thoughts/searchable/global/shared/templates.md` → `thoughts/global/shared/templates.md`
- NEVER change `allison/` to `shared/` or vice versa.

### Metadata and document generation
- Always gather real metadata before writing the doc.
- Never use placeholder values.
- Frontmatter uses snake_case keys.
- Tags should reflect the actual components researched.

### Critical ordering
- Always read user-mentioned files first (step 1).
- Always gather metadata before writing the research doc (step 6 before step 7).
- Never skip metadata gathering.
