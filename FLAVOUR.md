# Flavour: Saint-Jimon's copy

This copy of Org Flex is for **Saint-Jimon**, who runs Org from **Doom Emacs** (`(org +roam +dragndrop)`, evil) with `org-directory` at `~/Nextcloud/emacs/org/`, synced through Nextcloud. On the phone the same files are edited with **Metanote**, so everything Org Flex writes must stay plain Org with relative links that Metanote, Orgzly and Emacs all resolve (INV-1). In Obsidian, the vault root plays the role of `org-directory`: notes in `roam/`, dailies in `roam/daily/`, attachments in `attachments/images/`, tasks in `roam/todo.org`.

## How they use Org (from `init.el`, `config.el` and their files)

- **org-roam**: notes in `roam/` named by their capture template `"${slug}-%<%Y%m%d%H%M%S>.org"` (e.g. `emperorofallmaladies-20261030091500.org`) with `#+title:` and a UUID `:ID:`; links are `[[id:…][Title]]`; notes carry `#+filetags:`.
- **Dailies**: org-roam dailies at `roam/daily/YYYY-MM-DD.org`, `#+title: <date>`, a UUID `:ID:`, free text with `id:` links.
- **Tasks and agenda**: one file, `roam/todo.org`, a `* Tasks` outline of plain `TODO`/`DONE` items with `[#A]`–`[#C]` priorities, `SCHEDULED:` dates, and — when done — `CLOSED: [time]` plus a `:LOGBOOK:` drawer with `- CLOSING NOTE [time]` (`org-log-done 'note` into a drawer). `org-agenda-files` is only that file.
- **Capture**: org-roam templates `"d"` (new note as above) and `"t"` (`* TODO %?` into `todo.org` under "Tasks").
- **Attachments**: `org-download` (the `+dragndrop` flag) saves pasted/dragged images into `<org>/attachments/images/` and inserts relative links (`[[file:../attachments/images/…]]` from `roam/`, `../../…` from `roam/daily/`), declared per file in the first-line file-local `-*- org-download-image-dir: "…" -*-`.
- **Looks**: inline images as ~25%-width thumbnails, click opens full size; LaTeX fragments and mermaid blocks are rendered by Babel on the desktop (`dvisvgm`, `ob-mermaid`) — that needs Emacs, so it stays desktop-only.
- Obsidian `.md` notes are converted to `.org` with a script (`obsidian-to-org`), so Markdown task blocks stay useful.

## Decisions made for this copy (the interview, `TAILOR.md`)

- **Dailies replace the base journal layout** (JRN-1..4): day files are `roam/daily/YYYY-MM-DD.org` (flat, not `YYYY/MM/`), starting with the file-local image-dir line, `:ID:` and `#+title: <date>`.
- **New notes** (NOTE-3/5, LP-10, FIND-3) go to `roam/` named `<slug>-<YYYYMMDDHHMMSS>.org` with `#+title:` and a UUID `:ID:` — the user's `"d"` capture template. Links stay `id:`-based (`links: "id"`).
- **Capture** (CAP-2/3) files `* TODO …` at the end of the `* Tasks` heading in `roam/todo.org` — the `"t"` template.
- **Attachments** (ATT-3/5) save into `attachments/images/` at the vault root and are linked relative to the note, exactly like org-download.
- **Agenda** (AG-1..3) reads only `roam/todo.org`, as `org-agenda-files` does in Emacs.
- **Marking a task done** (ACT-15) writes `CLOSED: [time]` and logs `- CLOSING NOTE [time]` in a `:LOGBOOK:` drawer, as their Emacs does.
- **On open, files show unfolded** (`defaultFoldLevel: "expandall"`); the bar's **daily, capture and attach** buttons are on (BAR-2/3); priorities are `[#A]`–`[#C]` with default `B`.
- **Images in the live preview** (LP-3) show as ~25%-width thumbnails that open the full file on tap, matching Emacs.
- Kept from the base: backlinks, link-follow-rename, front matter panel, go to node, task blocks, timeline.

## Wishes for later

- Smoother phone editing overall — tasks, images and linking were all named as today's pain (Metanote is the current phone editor).
- Mermaid and LaTeX rendering in Obsidian would need running Emacs/Babel; not possible here — the nearest thing is the highlighted source block with its copy button.
- Getting the same setup onto the Asus laptop (mentioned in the 2026-10-30 daily) — a sync question, not a plugin one.
