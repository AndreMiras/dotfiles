---
name: long-running-agent
description: Explicit-only protocol for compute/time intensive autonomous research or development missions that may run for hours, require persistent task management, checkpoint files, context rotation, and validation. Use only when the user explicitly invokes `$long-running-agent` or directly asks to use the Long-Running Agent skill; do not use implicitly for normal research, debugging, coding, planning, or codebase exploration.
---

# Long-Running Agent

Run an explicitly requested long-running mission as a persistent senior engineer/researcher. Continue autonomously until the mission is solved, truly blocked, no meaningful work remains, or the configured time budget expires.

## Invocation Contract

Require an explicit mission from the user. Treat text after `$long-running-agent` as the mission.

Use a default wall-clock budget of 3 hours unless the user specifies another duration, such as `for 45 minutes`, `time budget: 6h`, or `run until 2026-05-26T18:00Z`. If no duration is clear, use 3 hours.

Interpret the configured duration as wall-clock time only. Do not create or set a goal-tracker token budget unless the user explicitly requests a token budget. Track wall-clock deadline, task state, and checkpoints in the skill's state files instead.

Before substantial work, restate:

- mission objective
- time budget and deadline
- whether any explicit token budget exists
- checkpoint directory
- first active task

## Budget Semantics

Separate these concepts:

- Wall-clock budget: the user-configurable runtime for the mission; default to 3 hours.
- Context budget: the live conversation/context window; manage it with checkpoint files and rotation before it becomes unsafe.
- Token-budgeted goal: an external platform control that can forcibly stop substantive work when reached.

Do not use token-budgeted goals as a substitute for the wall-clock budget. If goal-tracker tools are available and useful, create a goal only when the user explicitly asks for one; set a token budget only when the user explicitly gives a token budget.

If the platform reports that an active goal is `budget_limited`, stop substantive work for that goal, write a final checkpoint, and explain that the stop was caused by the platform goal token budget rather than mission completion, wall-clock expiry, or research blockage.

If resuming after a token-budget stop, continue from the handover/state files without reusing the exhausted token-budgeted goal unless the user explicitly asks to resume under a new token budget.

## Workspace State

Create or reuse a compact state directory. Prefer an existing mission-appropriate directory if present; otherwise use:

```text
agent/
|-- HANDOVER.md
|-- FINDINGS.md
|-- TASKS.json
|-- STATE.json
|-- DECISIONS.md
|-- LOGS/
|-- SCRATCHPAD/
`-- REPORTS/
```

Keep these files canonical during the mission:

- `HANDOVER.md`: compact resume package for another session.
- `TASKS.json`: active, backlog, blocked, and completed tasks.
- `FINDINGS.md`: durable evidence, facts, hypotheses, and open questions.
- `STATE.json`: mission metadata, time budget, current task, important paths, and latest checkpoint.
- `DECISIONS.md`: decisions, rationale, rejected paths, and tradeoffs.

Do not persist repetitive logs, low-value speculation, or raw command output unless it is needed as evidence. Store large transient outputs under `LOGS/` or `SCRATCHPAD/` and summarize them in durable files.

## Operating Loop

Maintain and continually reprioritize:

- `ACTIVE_TASKS`
- `BACKLOG_TASKS`
- `BLOCKED_TASKS`
- `COMPLETED_TASKS`
- `KNOWN_FACTS`
- `OPEN_QUESTIONS`
- `HYPOTHESES`

For each loop:

1. Select the highest-value unblocked task aligned with the mission.
2. Break it into executable steps.
3. Investigate with evidence: inspect files, search, run commands, execute tests, browse when current external information is required, and validate experimentally.
4. Update facts, hypotheses, decisions, and task state.
5. Add newly discovered relevant work to the backlog.
6. Drop or defer low-value branches explicitly.
7. Check remaining time and context pressure.

Do not stop merely because the initial task list is done if important follow-up work emerged. Avoid speculative rabbit holes; evaluate relevance, expected value, cost, and distraction risk before pursuing a new branch.

## Context Budget Protocol

Keep conversation/context usage below roughly 40% of capacity. When approaching that threshold:

1. Update `HANDOVER.md`, `TASKS.json`, `FINDINGS.md`, and `STATE.json`.
2. Compress aggressively: save durable conclusions, evidence, decisions, exact paths, commands, test results, assumptions, blockers, unresolved questions, and next actions.
3. Treat the handover files as canonical memory.
4. Continue from the handover files, mission, and current active task.

Writing a handover is not a completion condition.

If the platform requires manual context clearing or continuing would exceed the limit unsafely, output exactly:

```text
Context rotation required. Resume from: <handover path>. Next task: <task id/title>.
```

## Anti-Loop Rules

Do not repeat the same failed action without new information. After repeated failure:

- reassess assumptions
- try a materially different approach
- document evidence and blocker
- escalate only when no viable alternative remains

Avoid endlessly rewriting plans or optimizing irrelevant details.

## Human Escalation

Ask for human input only when credentials, permissions, external decisions, or blocking ambiguity are required, or when repeated attempts have failed with no viable alternative.

When escalating, report:

- what was attempted
- evidence gathered
- exact blocker
- minimal input needed

## Completion

Stop only when one condition is true:

- mission is fully achieved and validated
- no meaningful remaining work exists
- remaining work is low-value or speculative
- hard blocked requiring human intervention
- time budget expired

Before stopping, write a final checkpoint to the state files and summarize status, validation, remaining risks, unfinished optional improvements, and recommended next actions.
