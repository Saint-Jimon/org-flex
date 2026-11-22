# orgstar settings. The Settings window writes its changes here, and edits made here
# apply while orgstar runs. Keys go in keymap.toml, capture templates in capture.toml
# and saved agenda views in views.toml, all in this folder.

# Emacs variables, by their Emacs names.
fill-column = 80  # M-q fills to this column
org-tags-column = -77  # negative: tags end at that column; 0: one space before them
org-insert-heading-respect-content = false  # M-RET adds the new heading after the subtree
org-M-RET-may-split-line = false  # M-RET splits the line at the caret
org-use-property-inheritance = "nil"  # nil, t, or property names that inherit, separated by spaces, such as "STYLE"
org-list-allow-alphabetical = true  # lists can use a. b. c.
org-hide-emphasis-markers = true  # hide *bold* and =code= markers when markup is hidden
org-pretty-entities = true  # \alpha shows as α and x_{1} is lowered when markup is hidden
org-todo-keywords = "TODO | DONE"  # for files without #+TODO, in #+TODO syntax, one sequence per line (\n); keys in parentheses turn on fast selection; read at launch
org-log-done = "nil"  # nil, time (CLOSED when done) or note (CLOSED and a note)
org-log-reschedule = "nil"  # nil, time or note: log changing or removing a SCHEDULED date
org-log-redeadline = "nil"  # nil, time or note: log changing or removing a DEADLINE
org-log-into-drawer = ""  # the drawer state notes go in ("LOGBOOK" is Emacs's t); "" for none
org-enforce-todo-dependencies = false  # an entry can't be done before its TODO children, or under an ORDERED parent before its earlier siblings
org-enforce-todo-checkbox-dependencies = false  # an entry can't be done while it has unchecked boxes
org-archive-location = "%s_archive::"  # where Archive Subtree moves an entry without an ARCHIVE property or #+ARCHIVE: file::heading, %s the file's name
org-export-default-language = "en"  # the language of exports without #+LANGUAGE and of clock tables without :lang, such as "de"
org-use-tag-inheritance = "t"  # t, nil, tags that inherit separated by spaces, or a regexp in braces such as "{^@}"
org-tags-exclude-from-inheritance = ""  # tags that never inherit, separated by spaces
org-tag-alist = ""  # tags C-c C-q offers in files without #+TAGS, in #+TAGS syntax: "work(w) home(h) { @office(o) @home(H) }"
org-track-ordered-property-with-tag = "nil"  # nil, t (the tag ORDERED) or a tag that Toggle ORDERED Property toggles too
org-startup-indented = true  # indent bodies under their headings (org-indent-mode); #+STARTUP: (no)indent overrides
org-hide-leading-stars = false  # show only a heading's last star without indentation; #+STARTUP: hidestars/showstars overrides
org-startup-align-all-tables = false  # align every table when a file opens; #+STARTUP: (no)align overrides
org-startup-truncated = false  # truncate long lines instead of wrapping them (Emacs's default is t; Doom wraps)
spell-check = false  # check spelling while typing, outside code, links, dates, tags and keywords
electric-pair-mode = true  # type brackets, <> and quotes in pairs as electric-pair-mode does (off in plain Emacs; Doom pairs with smartparens)
org-startup-with-inline-images = true  # show image links as images when a file opens; #+STARTUP: (no)inlineimages overrides
org-startup-with-latex-preview = true  # show LaTeX fragments as typeset math when a file opens; #+STARTUP: (no)latexpreview overrides
org-roam-directory = "~/org/roam"  # the folder org-roam notes are in; empty for the first folder
org-roam-dailies-directory = "daily/"  # the folder daily notes are in, relative to org-roam-directory
org-roam-dailies-file = "%<%Y-%m-%d>.org"  # a daily note's file name; %<...> formats the date as format-time-string does
org-roam-dailies-head = "#+title: %<%Y-%m-%d>\n"  # what a new daily note starts with, under its ID
org-roam-dailies-entry = "* %?"  # the capture template Capture to Daily Note files
auto-fill-mode = false  # typing a space past fill-column breaks the line (View ▸ Auto Fill)
org-timer-format = "%s "  # how Insert Timer Value writes the timer; %s is h:mm:ss
org-timer-default-timer = "0"  # the countdown Set Countdown Timer offers, in minutes or h:mm:ss; 0 offers none
org-attach-id-dir = "data/"  # the folder attachment folders named by ID go in, relative to the org file's folder unless absolute
org-attach-use-inheritance = "selective"  # whether DIR and ID inherit for attachments: selective (as org-use-property-inheritance), t or nil
org-yank-image-save-method = "attach"  # where pasted images go: attach (the entry's attachments) or a folder, relative to the org file's folder unless absolute
org-yank-dnd-method = "ask"  # files dropped on the editor: ask, attach, open or file-link
org-crypt-tag-matcher = "crypt"  # the tag of entries Encrypt Tagged Entries encrypts
org-display-remote-inline-images = "skip"  # images at http(s) links: skip, download (each run) or cache (kept on disk)
org-use-speed-commands = false  # single keys at the start of a heading line run commands (n, p, t, c, …)
org-cycle-hide-drawer-startup = true  # fold drawers when a file opens; #+STARTUP: nohidedrawers overrides
org-cycle-hide-block-startup = false  # fold blocks when a file opens; #+STARTUP: hideblocks overrides
display-line-numbers-type = true  # line numbers: true, false, "relative" or "visual" (View ▸ Line Numbers)
org-agenda-span = 10  # days the agenda shows
org-agenda-start-day = "+0d"  # the agenda's first day: "-3d", "+0d"
org-deadline-warning-days = 14  # days ahead the agenda warns about a deadline; a -Nd cookie overrides
org-agenda-start-on-weekday = "1"  # weeks start on this day, 0 Sunday to 6 Saturday, or nil for the agenda's first day
org-agenda-show-all-dates = true  # show days with no entries (Emacs's default is t; orgstar hides them); today always shows
org-agenda-skip-scheduled-if-done = false  # leave done entries out of the agenda even on the day they are scheduled
org-agenda-skip-deadline-if-done = false  # leave done entries out of the agenda even on the day they are due
org-habit-show-habits-only-for-today = true  # habits show only on today's agenda, not on the later days they are scheduled for
org-agenda-log-mode-items = "closed clock"  # what log mode shows, separated by spaces: closed, clock, state
org-agenda-todo-ignore-with-date = false  # the TODO list leaves out entries with any active timestamp
org-agenda-todo-ignore-scheduled = "nil"  # the TODO list leaves out scheduled entries: nil, all, future, past, or days ahead (negative: days ago)
org-agenda-todo-ignore-deadlines = "nil"  # the TODO list leaves out entries with deadlines: nil, near, far, all, future, past, or days
org-agenda-todo-ignore-timestamp = "nil"  # the TODO list leaves out entries with other active timestamps: nil, all, future, past, or days
org-agenda-tags-todo-honor-ignore-options = false  # the org-agenda-todo-ignore settings apply to TODO-only matches too
org-agenda-search-view-always-boolean = false  # search strings are always +word -word {regexp} snippets, never a phrase
org-agenda-search-view-force-full-words = false  # search snippets match whole words only
org-agenda-dim-blocked-tasks = "t"  # t dims entries the enforce settings block, invisible hides them (unless only checkboxes block them), nil shows them as usual
appt-message-warning-time = 12  # minutes of warning before timed entries; APPT_WARNTIME overrides
org-clock-idle-time = 0  # minutes idle with a clock running before asking what to do with the time; 0 never (nil)
org-clock-into-drawer = "t"  # t: clock lines go in the log drawer (LOGBOOK); nil: none; a number: once there are that many; or a drawer name
org-clock-rounding-minutes = 0  # clocks start and end on multiples of this many minutes; 0 doesn't round
org-clock-out-remove-zero-time-clocks = false  # clocking out removes a clock line of 0:00
org-clock-in-switch-to-state = ""  # the TODO keyword an entry takes when you clock in; "" leaves it
org-clock-out-when-done = "t"  # t: marking the clocked entry done clocks out; nil: it doesn't; or keywords that clock out, separated by spaces
org-clock-history-length = 5  # recently clocked entries to remember
org-refile-targets = ""  # as Lisp: ((nil :maxlevel . 3) (org-agenda-files :tag . "project")); "" offers headings to level 3 in every file
org-refile-use-outline-path = "file"  # how targets are named: nil, t, file, full-file-path, buffer-name or title
org-refile-allow-creating-parent-nodes = "nil"  # a target typed as parent/new adds the heading: t, confirm (asks first) or nil
org-agenda-files = "~/org/roam/todo.org"  # files and folders the agenda reads, separated by \n; a file that isn't .org lists more, one per line; "" reads the folders' files
org-icalendar-use-deadline = "event-if-not-todo todo-due"  # iCalendar export: what a DEADLINE makes, of event-if-not-todo, event-if-todo, event-if-todo-not-done and todo-due
org-icalendar-use-scheduled = "todo-start"  # iCalendar export: what SCHEDULED makes, of event-if-not-todo, event-if-todo, event-if-todo-not-done and todo-start
org-icalendar-include-todo = "nil"  # iCalendar export: tasks as VTODOs: nil, t (not done), all, unblocked, or TODO keywords separated by spaces
org-icalendar-combined-agenda-file = "~/org.ics"  # where Combine Agenda Files into iCalendar writes
org-agenda-use-time-grid = true  # time grid lines among timed entries, as [org-agenda-time-grid] says
org-agenda-show-current-time-in-grid = true  # the now line on today's grid
org-agenda-sort-notime-is-late = true  # lines without a time sort after timed ones for time-up, and without a date after dated ones
org-agenda-sort-noeffort-is-high = true  # entries without an effort sort as the longest for effort-up

[org-agenda-prefix-format]
agenda = " %i %-12:c%?-12t% s"  # %c category, %t time, %s scheduled/deadline, %e effort, %l level, %b outline path; %-12 pads
todo = " %i %-12:c"  # the TODO list
tags = " %i %-12:c"  # tag and property matches

[org-agenda-sorting-strategy]
agenda = "time-up habit-down urgency-down category-keep"  # how lines of a day are ordered: time-up, priority-down, category-keep, alpha-up, effort-up, tag-up, todo-state-up, …
todo = "urgency-down category-keep"  # the TODO list
tags = "urgency-down category-keep"  # tag and property matches
search = "category-keep"  # text search

[org-stuck-projects]
match = "+LEVEL=2/-DONE"  # the entries that are projects, as a tag and property match
todo = "TODO NEXT NEXTACTION"  # a heading in the project with one of these keywords unsticks it; * for any open keyword
tags = ""  # a heading in the project with one of these tags unsticks it; * for any tag
regexp = ""  # text in the project matching this Emacs regexp unsticks it

[org-agenda-time-grid]
when = "daily today require-timed"  # daily (one-day views), today, weekly (every day), require-timed (only with timed entries), remove-match (no line at an entry's time)
times = "800 1000 1200 1400 1600 1800 2000"  # the grid's times as HHMM, separated by spaces

[theme]
font = ""  # a monospaced font family; "" for the system's
body-font = ""  # a font family for prose, or "system"; tables, code, dates and tags keep the font above; "" for the font above throughout
font-size = 13  # points
line-spacing = 2  # points between lines
text-width = 0  # the widest the text runs, in columns, centred in a wider editor; 0 for the whole width
heading-size-step = 1  # points a heading is larger than the level below; level 4 and deeper are body size
theme-file = ""  # a theme in its own file in this folder, under the colors set here; colors: see default-theme.toml
light-theme = "default-light"  # the built-in theme for the light appearance: default-light, solarized-light, gruvbox-light, modus-operandi, catppuccin-latte, tomorrow or paper
dark-theme = "default-dark"  # the built-in theme for the dark appearance: default-dark, solarized-dark, gruvbox-dark, modus-vivendi, catppuccin-mocha, nord, dracula, tokyo-night or doom-one

[orgstar]
save = "automatic"  # automatic (1 s after typing stops) or explicit (only with ⌘S)
keymap = "doom"  # emacs, mac or doom; your own bindings go in keymap.toml
option-as-meta = "left"  # left, right, both or none
pdf-margin = 50  # PDF export's page margins, in points
pdf-font = ""  # a font family for PDF export's text; "" for the export's own
pdf-page-numbers = true  # number PDF export's pages
tab-bar = false  # a tab for each open buffer above the editor (View ▸ Show Tab Bar)
show-markup = false  # show link brackets and emphasis markers (View ▸ Show Markup)
show-hidden-files = true  # list dotfiles and dot folders in your folders
ignored-folders = ".Spotlight-V100 .Trash .build .bzr .cache .fseventsd .git .gradle .hg .jj .mypy_cache .next .pytest_cache .stfolder .stversions .svn .terraform .tox .venv node_modules"  # folder names never listed or searched, separated by spaces
agenda-include-subfolders = false  # the agenda reads org files in subfolders too
agenda-exclude-archives = false  # the agenda leaves out files that other agenda files archive to (#+ARCHIVE:, org-archive-location)
reminders = true  # notify before timed entries
calendar-events = true  # show events from Calendar in the agenda
calendar-event-calendars = ""  # the calendars whose events show, by title or identifier, separated by commas; "" for all
agenda-reminders = true  # show incomplete reminders with a due date from Reminders in the agenda, read-only
agenda-reminder-lists = "Reminders"  # the Reminders lists shown, by title or identifier, separated by commas; "" for all
global-capture-hotkey = true  # ⌃⌥Space opens Capture from any app; templates go in capture.toml
