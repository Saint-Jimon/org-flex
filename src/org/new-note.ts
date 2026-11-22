// New org notes (§10a): the file is named `<slug>-<YYYYMMDDHHMMSS>.org`, as the
// org-roam `${slug}-%<%Y%m%d%H%M%S>.org` capture template does, with the title
// as the #+title and a fresh UUID as the :ID:. With Denote (DEN-5) the file is
// named ID--title.org and starts with Denote's front matter.

import { compactStampId, denoteFileName } from "./denote";

const FORBIDDEN = /[\\/:*?"<>|#^\[\]]/;

/** NOTE-3: why a title can't be used, or null when it's fine. */
export function titleProblem(raw: string): string | null {
  const title = raw.trim();
  if (!title) return "Enter a title.";
  const bad = FORBIDDEN.exec(title);
  if (bad) return `A title can't contain "${bad[0]}".`;
  if (title.startsWith(".") || title.endsWith(".")) return "A title can't start or end with a dot.";
  return null;
}

/** NOTE-3: `<folder>/<title>.org`, with the title trimmed; DEN-5: `<folder>/ID--title.org` with a Denote identifier. */
export function notePath(folder: string, raw: string, denoteId?: string): string {
  const dir = folder.replace(/^\/+|\/+$/g, "");
  const name = denoteId === undefined ? `${raw.trim()}.org` : denoteFileName(denoteId, raw.trim(), [], "org");
  return dir ? `${dir}/${name}` : name;
}

/** NOTE-3: org-roam's `${slug}`: the lowercased title, runs of non-alphanumerics as `-`. */
export function slugTitle(raw: string): string {
  const slug = raw.trim().toLowerCase().replace(/[^a-z0-9]+/g, "-").replace(/^-+|-+$/g, "");
  return slug || "untitled";
}

/**
 * NOTE-3: `<folder>/<slug>-<YYYYMMDDHHMMSS>.org` for a title made at `date`,
 * with ` 2`, ` 3`, … added when `taken` says the path exists.
 */
export function stampedNotePath(folder: string, raw: string, date: Date, taken?: (path: string) => boolean): string {
  const dir = folder.replace(/^\/+|\/+$/g, "");
  const base = `${slugTitle(raw)}-${compactStampId(date)}`;
  for (let n = 1; ; n++) {
    const name = n === 1 ? base : `${base} ${n}`;
    const path = dir ? `${dir}/${name}.org` : `${name}.org`;
    if (!taken || !taken(path)) return path;
  }
}

/** NOTE-5: a new note's header: the file-local `org-download-image-dir` line (when `imageDir`), the :ID:, the #+title. */
export function noteFileContent(raw: string, id: string, imageDir?: string): string {
  const title = raw.trim();
  const local = imageDir ? `# -*- org-download-image-dir: "${imageDir}" -*-\n` : "";
  return `${local}:PROPERTIES:\n:ID:       ${id}\n:END:\n#+title: ${title}\n\n`;
}

/**
 * LP-10: a file name for a title typed in the `[[` list: characters NOTE-3
 * refuses become "-", and leading and trailing dots are dropped.
 */
export function noteFileName(raw: string): string {
  const name = raw.trim().replace(new RegExp(FORBIDDEN.source, "g"), "-").replace(/^\.+|\.+$/g, "").trim();
  return name || "Untitled";
}

/** LP-10: `<name>.org`, or `<name> 2.org`, `<name> 3.org`, … when taken. */
export function freeNotePath(folder: string, name: string, taken: (path: string) => boolean): string {
  for (let n = 1; ; n++) {
    const path = notePath(folder, n === 1 ? name : `${name} ${n}`);
    if (!taken(path)) return path;
  }
}

/**
 * LP-10, FIND-2: whether to offer creating a note titled `typed`: when
 * something is typed and no entry has exactly that label (ignoring case and
 * spaces around it).
 */
export function offerCreate(labels: Iterable<string>, typed: string): boolean {
  const title = typed.trim().toLowerCase();
  if (!title) return false;
  for (const label of labels) if (label.trim().toLowerCase() === title) return false;
  return true;
}
