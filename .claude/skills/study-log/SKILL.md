---
name: study-log
description: >-
  Log each lesson of the Linux Shell Scripting (Udemy / Jason Cannon) course as a
  GitHub issue and a standard conventional-commit. Use when the user finishes or is
  studying a lesson and wants to (1) open an issue describing what the lesson covers,
  or (2) commit their staged practice scripts with a clean message that references
  that issue. Triggers: "tạo issue cho bài", "viết commit cho bài học", "log bài",
  "study-log", "commit bài học", "issue bài học".
---

# Study Log — one issue + one commit per lesson

This is a **learning log** workflow for the repo
`dev000000/Linux-Shell-Scripting-Jason_Cannon`. Each lesson becomes:

1. **An issue** — short description of what the lesson covers (notes, practice, mind map).
2. **A commit** — conventional-commit message derived from the *staged* scripts, ending
   with `Refs: #<issue>` so GitHub cross-links the commit to the issue.

The user's real goal: build a clean, professional GitHub history for a DevOps CV.
Keep everything **short, clear, and in English** (issue title, issue body, and commit
message are all English). Talk to the user / ask for confirmation **in Vietnamese**.

## Fixed configuration (do not re-ask)

- **Language of GitHub artifacts:** English (title, body, commit message).
- **Language when chatting / confirming with the user:** Vietnamese.
- **Reference style:** `Refs: #N` (does NOT close the issue). Use `Closes #N` only if the
  user explicitly wants the issue auto-closed when this commit is pushed.
- **`gh` binary:** prefer `gh` on PATH. If the shell says `gh` is not found (PATH not yet
  refreshed after install), use the full path: `"C:/Program Files/GitHub CLI/gh.exe"`.

## THE ONE RULE: always confirm before writing

Never create an issue and never run `git commit` until you have shown the exact draft and
the user has said yes. Show the draft → ask in Vietnamese "Ok tạo chưa? / sửa gì không?"
→ only then execute. If the user edits, revise and re-confirm.

## Which step to run

- Arg `issue` (or "b1", "bước 1") → run **Step 1** only.
- Arg `commit` (or "b2", "bước 2") → run **Step 2** only.
- No arg → infer: if `git diff --staged --stat` is empty → they're probably starting a
  lesson, run **Step 1**. If there are staged changes → run **Step 2**. When unsure, ask
  briefly which step.

---

## Step 1 — Create the lesson issue

**Input from the user:** which lesson (section / video name or number) and, optionally,
a short description of what they learned / achieved. If they only give a topic and you
lack the key points, ask 1-2 light questions — don't over-interrogate.

**Draft the issue** using this template (all English, keep it tight):

Title — `<N>.<short title>` where **N is the issue's own sequential number** so issues
sort in study order and are easy to find. Compute N = (highest existing issue number) + 1
— check with `gh issue list --state all`. The short title is a concise English noun phrase
of the topic, ≤ ~70 chars. Real examples:
- `1.Shell scripting basics: naming, permissions, variables, builtins`
- `2.Special variables, conditionals & the if statement`

Body:

```markdown
## Lesson
<Verbatim course lesson title, exactly as in the course, keeping its trailing period> (S<section>-L<lesson>)

## Key points
- <one idea per bullet — short, clear phrase>
- <another distinct subtopic>
- <list every subtopic the lesson covered; no long descriptions>
```

The **`## Lesson` line is the course lesson title copied verbatim**, followed by a
`(S<section>-L<lesson>)` tag — `S` = section number, `L` = the course's lesson number
(e.g. Section 3, lesson 13 → `(S3-L13)`). Do NOT paraphrase it. If the section/lesson
number isn't obvious from what the user gives, ask them briefly.

Keep the issue **minimal: only `## Lesson` + `## Key points`**. Do NOT add `## Practice`,
`## Deliverables`, or checklists. **Key points: one idea per bullet** — each a short, clear
phrase; do NOT merge several ideas onto one line, do NOT write long descriptions, and do
NOT invent subtopics the user didn't actually learn (only what the lesson/their notes and
their scripts show). List every distinct subtopic the lesson covered, in lesson order.

**Confirm, then create.** After the user approves, write the body to a temp file and run:

```bash
gh issue create --title "<title>" --body-file <tempfile>
# optional: --label learning   (only if that label already exists in the repo)
```

Use `--body-file` (not inline `--body`) so the markdown/newlines survive shell quoting.
Capture the returned issue URL/number and tell the user: e.g. "Đã tạo #3 — sẽ dùng số này
cho `Refs:` ở commit." Remember this number for Step 2.

---

## Step 2 — Create the commit from staged changes

**Read what is staged first** — never guess:

```bash
git diff --staged --stat      # which files
git diff --staged             # the actual changes
```

If nothing is staged: tell the user to `git add` the files for this lesson first. You may
*offer* to stage specific files, but only stage after they confirm — and never blanket
`git add -A` (that would sweep in unrelated files, including this skill).

Read the staged script(s) to understand **what each one demonstrates and what was learned**.
If the user gave their own description, combine it with the staged content; otherwise derive
the message purely from the code.

**Pick the issue to reference:** use the issue just created in Step 1. If none is fresh, ask
the user for the number, or list candidates with `gh issue list --state open`.

**Draft the commit** in conventional-commit format (their own template):

```
<type>(<scope>): <subject>

- <file or topic>: <what it shows / what was learned>
- <file or topic>: <...>

Refs: #<issue>
```

Rules:
- **type** — use **`lesson`** for a lesson's practice script(s) / newly demonstrated
  capability (this is a study-log repo, so lesson commits read as `lesson(scope): …`).
  Use standard types for support work only: `docs` (notes, README, mind map), `fix`
  (correcting a wrong script), `refactor` (cleanup, same behavior), `chore` (tooling /
  skill, Vagrantfile, structure, .gitignore).
- **scope** — the lesson topic in kebab-case, derived from the script/topic:
  `parameter-expansion`, `command-substitution`, `quoting`, `localusers`, …
- **subject** — imperative, lowercase, no trailing period, ≤ ~72 chars.
- **body** — one `- ` bullet per file or key idea: what it demonstrates + the takeaway.
  Concise, English. This is the "what did I learn" record.
- **footer** — `Refs: #<issue>`.

Concrete example for this repo:

```
lesson(parameter-expansion): add variable expansion practice script

- 01-parameter-expansion.sh: contrast $var vs ${var}; show appending text,
  default values (:-), length (${#var}), substring, and search/replace
- Takeaway: ${var} is required for advanced expansions and safe concatenation

Refs: #1
```

**Confirm, then commit.** After approval, write the message to a temp file and commit with
`-F` so multi-line formatting is preserved (robust on Windows PowerShell):

```bash
git commit -F <tempfile>
```

(Alternatively, a Bash-tool heredoc `git commit -F - <<'EOF' … EOF` also works.)

Report the resulting commit hash. Do **not** push unless the user asks — pushing is a
separate step. Note: `Refs: #N` only becomes a live cross-link on the issue after the
commit is pushed to GitHub.

---

## Setup notes / troubleshooting

- **Auth:** issue creation needs `gh` logged in. If `gh auth status` shows "not logged in",
  the user must run `gh auth login` themselves in their terminal (interactive — pick
  GitHub.com → HTTPS → login via browser). This cannot be done from inside a tool call.
  Alternatively they can set a `GH_TOKEN` env var with a Personal Access Token (repo scope).
- **PATH:** `gh` was installed to `C:\Program Files\GitHub CLI\gh.exe`. A brand-new terminal
  will have it on PATH; an old session may not — fall back to the full path if needed.
- **Repo scope:** run `gh` commands from inside the repo so it targets
  `dev000000/Linux-Shell-Scripting-Jason_Cannon` automatically.
