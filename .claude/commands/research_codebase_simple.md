<!--
Attribution: Forked from https://github.com/humanlayer/humanlayer/blob/v0.12.0/.claude/commands/
Modified to work with regular Claude Code license (removed MCP/HumanLayer dependencies)
-->

# Research Codebase (Simple)

You are tasked with conducting comprehensive research across the codebase to answer user questions using direct tools only.

## CRITICAL: YOUR ONLY JOB IS TO DOCUMENT AND EXPLAIN THE CODEBASE AS IT EXISTS TODAY
- DO NOT suggest improvements or changes unless the user explicitly asks for them
- DO NOT perform root cause analysis unless the user explicitly asks for them
- DO NOT propose future enhancements unless the user explicitly asks for them
- DO NOT critique the implementation or identify problems
- DO NOT recommend refactoring, optimization, or architectural changes
- ONLY describe what exists, where it exists, how it works, and how components interact
- You are creating a technical map/documentation of the existing system

## Initial Setup:

When this command is invoked, respond with:
```
I'm ready to research the codebase. Please provide your research question or area of interest, and I'll analyze it thoroughly.
```

Then wait for the user's research query.

## CRITICAL: Complete ALL Steps

**YOU MUST COMPLETE ALL 10 STEPS BELOW.** Do not stop after presenting findings to the user - the research document in `thoughts/shared/research/` is the primary deliverable and MUST be created.

## Steps to follow after receiving the research query:

1. **Read any directly mentioned files first:**
   - If the user mentions specific files, read them FULLY first
   - **IMPORTANT**: Use the Read tool WITHOUT limit/offset parameters to read entire files
   - This ensures you have full context before proceeding

2. **Analyze and decompose the research question:**
   - Break down the user's query into specific areas to investigate
   - Identify which directories, files, or patterns are relevant
   - Create a research plan using TodoWrite to track all subtasks
   - **IMPORTANT**: Include todos for steps 6-10 (metadata gathering, document generation, syncing)
   - Consider what file patterns to search for, what keywords to grep for

3. **Conduct codebase research using direct tools:**
   - Use **Glob** to find files by patterns (e.g., "**/*.lua", "**/*config*")
   - Use **Grep** to search for keywords, function names, or patterns
   - Use **Read** to examine relevant files you discover
   - When you find relevant files, read them to understand their contents
   - Make multiple tool calls in parallel when searching for independent things
   - Document your findings as you go

4. **Search thoughts/ directory for historical context:**
   - Use **Glob** to find relevant documents in thoughts/ (e.g., "thoughts/**/*.md")
   - Use **Grep** to search for keywords in thoughts/ directory
   - Use **Read** to examine the most relevant historical documents
   - Look for past research, decisions, or explorations related to your query
   - Note: thoughts/ provides supplementary context; prioritize live codebase findings

5. **Synthesize findings:**
   - Compile all your findings from both codebase and thoughts/
   - Prioritize live codebase findings as primary source of truth
   - Use thoughts/ findings as supplementary historical context
   - Connect findings across different components
   - Include specific file paths and line numbers for reference
   - Highlight patterns, connections, and architectural decisions
   - Answer the user's specific questions with concrete evidence
   - **NOTE**: This synthesis is preparation for the research document - continue to step 6

**IMPORTANT**: Steps 6-10 are MANDATORY. The research document in `thoughts/` is the primary deliverable, not just the verbal response to the user.

6. **Gather metadata for research document:**
   - Use **Bash** to run: `hack/spec_metadata.sh` (if it exists) to generate metadata
   - Or manually gather using Bash:
     - Current date/time: `date -Iseconds`
     - Git commit: `git rev-parse HEAD`
     - Branch: `git branch --show-current`
     - Repository name: `basename $(git rev-parse --show-toplevel)`
   - Determine filename: `thoughts/shared/research/YYYY-MM-DD-ENG-XXXX-description.md`
     - Format: `YYYY-MM-DD-ENG-XXXX-description.md` where:
       - YYYY-MM-DD is today's date
       - ENG-XXXX is the ticket number (omit if no ticket)
       - description is a brief kebab-case description

7. **Generate research document:**
   - Use **Write** to create document in `thoughts/shared/research/`
   - Structure with YAML frontmatter followed by content:
     ```markdown
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
     - Description of what exists (file.ext:line)
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
     Note: Paths exclude "searchable/" even if found there

     ## Related Research
     [Links to other research documents in thoughts/shared/research/]

     ## Open Questions
     [Areas needing further investigation]
     ```

8. **Add GitHub permalinks (if applicable):**
   - Check if on main branch or if commit is pushed:
     - `git branch --show-current`
     - `git status`
   - If on main/master or pushed, generate GitHub permalinks:
     - Get repo info: `gh repo view --json owner,name`
     - Create permalinks: `https://github.com/{owner}/{repo}/blob/{commit}/{file}#L{line}`
   - Use **Edit** to replace local file references with permalinks in the document

9. **Sync and present findings:**
   - Use **Bash** to run: `humanlayer thoughts sync` (if available)
   - Present a concise summary of findings to the user
   - Include key file references with line numbers
   - Mention the research document location
   - Ask if they have follow-up questions or need clarification

10. **Handle follow-up questions:**
    - If the user has follow-up questions, append to the same research document
    - Use **Read** to get current document content
    - Use **Edit** to update:
      - Frontmatter fields `last_updated` and `last_updated_by`
      - Add `last_updated_note: "Added follow-up research for [brief description]"`
      - Add new section: `## Follow-up Research [timestamp]`
    - Continue researching and updating the document
    - Run thoughts sync again after updates

## Tool Usage Guidelines:

**Finding Files:**
- Use Glob with patterns like:
  - `**/*.py` - all Python files
  - `**/*config*` - files with "config" in name
  - `src/**/*.ts` - TypeScript files in src directory
  - `.config/**/*` - all files in .config directory

**Searching Content:**
- Use Grep to search for:
  - Function names: `pattern: "function_name"`
  - Keywords: `pattern: "keyword"`
  - Patterns: `pattern: "class.*Config"`
  - With context: use `-A`, `-B`, or `-C` parameters
  - File filtering: use `glob` or `type` parameters
  - Set `output_mode: "content"` to see matching lines
  - Set `output_mode: "files_with_matches"` to see just file paths

**Reading Files:**
- Use Read to examine files you've found
- Read full files without limit/offset to get complete context
- Read multiple files in parallel when they're independent

## Important Notes:
- Make parallel tool calls whenever possible for efficiency
- Focus on documentation, not evaluation
- Include specific file paths and line numbers
- Document what exists, not what should be improved
- Keep your explanations clear and factual
- Use code references to help users navigate to source locations

**Path Handling for thoughts/ directory:**
- The `thoughts/searchable/` directory contains hard links for searching
- When documenting paths, remove ONLY "searchable/" - preserve all other subdirectories
- Examples of correct transformations:
  - `thoughts/searchable/allison/old_stuff/notes.md` → `thoughts/allison/old_stuff/notes.md`
  - `thoughts/searchable/shared/prs/123.md` → `thoughts/shared/prs/123.md`
  - `thoughts/searchable/global/shared/templates.md` → `thoughts/global/shared/templates.md`
- NEVER change allison/ to shared/ or vice versa - preserve the exact directory structure
- This ensures paths are correct for editing and navigation

**Metadata and Document Generation:**
- Always gather real metadata before writing research documents
- NEVER write documents with placeholder values
- Use actual git commit hashes, dates, and branch names
- Frontmatter fields use snake_case (e.g., `last_updated`, `git_commit`)
- Tags should be relevant to the research topic and components studied

**Critical Ordering:**
- ALWAYS read mentioned files first before starting research (step 1)
- ALWAYS gather metadata before writing the document (step 6 before step 7)
- NEVER skip metadata gathering - it's essential for document context
