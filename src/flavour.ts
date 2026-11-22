// The flavour (§12a): how this copy of Org Flex is set up for the way its
// user works with Org. These are code, not settings: a fork changes them here
// (usually through TAILOR.md), next to the rules they feed, and the spec's
// §12a table says what each one does. Which features this copy has is the
// list in src/features/index.ts (PLAT-8). Settings (src/settings.ts) only
// hold what differs between one person's vaults and devices.

import type { VisibilityLevel } from "./org/folding";
import { DEFAULT_JOURNAL_TEMPLATE } from "./org/journal";
import { compactStampId, timestampId } from "./org/denote";
import { uuidId } from "./org/ids";
import { stampedMediaName, type MediaKind } from "./org/edit";
import { slugTitle } from "./org/new-note";
import type { LinkScheme } from "./org/vault-index";

export interface Flavour {
  /** open-task keywords, in cycling order (PARSE-3, ACT-3) */
  todoKeywords: string[];
  /** closed-task keywords */
  doneKeywords: string[];
  /** priority of tasks that have none, when sorting task blocks (TASK-2) */
  defaultPriority: string;
  /** LP-7 */
  hideStars: boolean;
  /** TBL-3: table widths leave out emphasis markers, as Emacs aligns with `org-hide-emphasis-markers` */
  hideEmphasisMarkers: boolean;
  /** FOLD-4, FM-4 */
  foldPropertyDrawers: boolean;
  /** FOLD-5 */
  defaultFoldLevel: VisibilityLevel;
  /** JRN-2: `{{date}}` and `{{id}}` are filled in (not used with Denote, DEN-6) */
  journalTemplate: string;
  /** IDX-3: a new org `:ID:`, made `now` (microseconds since the epoch), not one of `taken` */
  orgId(now: number, taken: ReadonlySet<string>): string;
  /** DEN-1: link notes by `:ID:` as org-roam does, or by the identifier in Denote file names */
  links: LinkScheme;
  /** DEN-5: the identifier for a note or file made at `date`, not one of `taken` */
  denoteId(date: Date, taken: ReadonlySet<string>): string;
  /** DEN-6: the identifier for the journal file of the day `date` */
  journalId(date: Date, taken: ReadonlySet<string>): string;
  /** ATT-6: the name for a recording or pasted image made at `date`; `taken` is the names of the vault's files */
  mediaName(kind: MediaKind, date: Date, ext: string, taken: ReadonlySet<string>): string;
  /** ACT-15: a task marked done gets `CLOSED: [time]`; with `"note"`, also a `:LOGBOOK:` `- CLOSING NOTE [time]` (`org-log-done 'note`) */
  logDone: boolean | "note";
  /** NOTE-2, LP-10, FIND-3: new notes go to this folder (org-roam's `org-roam-directory`) */
  noteFolder: string;
  /** NOTE-3: the file name (without `.org`) of a new note titled `title`, made at `date` */
  noteName(title: string, date: Date): string;
  /** CAP-3: captures are filed at the end of this heading's subtree in the capture file (`file+olp`) */
  captureHeading: string;
  /** AG-1: the files the agenda reads (the fork's `org-agenda-files`) */
  agendaFiles: string[];
}

export const FLAVOUR: Flavour = {
  todoKeywords: ["TODO"],
  doneKeywords: ["DONE"],
  defaultPriority: "B",
  hideStars: false,
  hideEmphasisMarkers: false,
  foldPropertyDrawers: true,
  defaultFoldLevel: "expandall",
  journalTemplate: DEFAULT_JOURNAL_TEMPLATE,
  orgId: uuidId,
  links: "id",
  denoteId: timestampId,
  journalId: timestampId,
  mediaName: stampedMediaName,
  logDone: "note",
  noteFolder: "roam",
  noteName: (title, date) => `${slugTitle(title)}-${compactStampId(date)}`,
  captureHeading: "Tasks",
  agendaFiles: ["roam/todo.org"],
};
