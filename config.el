;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)
;; Specify both a dark and light theme, like so and Doom will choose which one
;; to load based on your system light/dark setting:
;;
;;   (setq doom-theme '(doom-one   . doom-one-light))   ; (DARK . LIGHT)
;;
;; If you want more pro-active theme switching based on OS light/dark mode, look
;; up the `auto-dark' package.

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/Nextcloud/emacs/org/")
(setq org-roam-directory (expand-file-name "roam/" org-directory))
;; org-agenda: include todo.org (Doom's default only scans org-directory, which
;; has no .org files directly — todos live in org/roam/todo.org).
(setq org-agenda-files (list (expand-file-name "roam/todo.org" org-directory)))
(setq org-roam-capture-templates
      '(("d" "default" plain "%?"
         :target (file+head "${slug}-%<%Y%m%d%H%M%S>.org"
                            "#+title: ${title}\n")
         :unnarrowed t)
        ("t" "todo" entry "* TODO %?\n"
         :target (file+olp "todo.org" ("Tasks"))
         :unnarrowed t)))
(after! org-roam (org-roam-setup))

;; Faster image rendering
(setq image-transform-smoothing nil           ; faster scaling (less smooth)
      image-recompute-map-p nil               ; skip map recompute on scale
      org-image-actual-width '(0.25)          ; thumbnails: 25% of window width (click to open full size)
      org-preview-latex-default-process 'dvisvgm  ; 'dvipng default isn't installed here
      org-startup-with-latex-preview t        ; render $...$ LaTeX at file-open (needs TeX)
      org-startup-with-inline-images t)       ; render images at file-open, not scroll-into-view

;; Left-click an inline image to open the original (full size) in its own buffer.
;; image-map is attached to every inline image overlay by org, so this only
;; affects clicks landing on an image, not elsewhere in the buffer.
(defun +org-mouse-open-image (event)
  "Open the link under the mouse click. Intended for `image-map' in org buffers."
  (interactive "e")
  (mouse-set-point event)
  (when (derived-mode-p 'org-mode)
    (call-interactively #'org-open-at-point)))

(with-eval-after-load 'image
  (define-key image-map [mouse-1] #'+org-mouse-open-image))

;; Keep thumbnails at 25% of the text width even after resizing the window.
;; (`org-image-actual-width` is only recomputed when previews are redrawn.)
(defun +org-rescale-inline-images (&rest _)
  "Recompute inline image sizes in visible org buffers."
  (dolist (win (window-list))
    (with-current-buffer (window-buffer win)
      (when (derived-mode-p 'org-mode)
        (ignore-errors (org-link-preview-refresh))))))
(add-hook 'window-size-change-functions #'+org-rescale-inline-images)

;; Cap inline image height so very tall images don't dominate the buffer.
;; org only caps width (`org-image-max-width`); this adds :max-height (50% of
;; the window height) to every inline image spec.
(after! org
  (defun +org--cap-inline-image-height-a (orig file width)
    (let ((img (funcall orig file width)))
      (when img
        (setcdr img (plist-put (cdr img) :max-height
                               (floor (* 0.5 (window-pixel-height))))))
      img))
  (advice-add #'org--create-inline-image :around #'+org--cap-inline-image-height-a))

;; Paste images into <org-directory>/attachments/images/ via org-download (+dragndrop flag)
(setq-default org-download-image-dir (expand-file-name "attachments/images/" org-directory)
              org-download-method 'directory)
;; Trust the per-file `org-download-image-dir' file-local variable in org files
;; (first line: -*- org-download-image-dir: "../attachments/images/" -*-)
(put 'org-download-image-dir 'safe-local-variable #'stringp)
(after! org-download
  ;; Force-set in current and all org buffers (image-dir is buffer-local)
  (let ((dir (expand-file-name "attachments/images/" org-directory)))
    (setq org-download-image-dir dir
          org-download-method 'directory)
    (dolist (buf (buffer-list))
      (with-current-buffer buf
        (when (derived-mode-p 'org-mode)
          (setq org-download-image-dir dir
                org-download-method 'directory)))))
  (setq org-download-clipboard-method
        (cond ((executable-find "wl-paste") "wl-paste -t image/png > %s")
              ((executable-find "xclip")    "xclip -selection clipboard -target image/png -out > %s")))
  ;; Insert [[file:../attachments/images/<name>]] (relative to the note) so the
  ;; links also work in mobile org apps (Orgzly, Orgro, beorg, ...).
  (setq org-download-link-format-function
        (lambda (filename)
          (let ((org-dir (file-name-directory (or (buffer-file-name) default-directory))))
            (format "[[file:%s]]\n" (file-relative-name filename org-dir)))))
  (map! :map org-mode-map
        :localleader
        "y" #'org-download-yank
        "Y" #'org-download-clipboard))


;;; Convert Obsidian .md files to org via the Python script in ~/bin/.
(defcustom obsidian-vault-path (expand-file-name "~/Documents/Vault")
  "Default Obsidian vault root used by `obsidian-to-org'."
  :type 'directory)

(defun obsidian-to-org (vault file-pattern)
  "Convert an Obsidian FILE-PATTERN (relative to VAULT) to org-mode.

Both arguments are read from the minibuffer. Uses the Python script
at ~/bin/obsidian-to-org.py and shows its output in a compilation
buffer."
  (interactive
   (list (read-directory-name "Obsidian vault: " obsidian-vault-path)
         (read-string "File pattern (relative to vault, e.g. **/Note.md): "
                      "**/*.md")))
  (let* ((script (expand-file-name "~/bin/obsidian-to-org.py"))
         (default-directory vault)
         (cmd (format "python3 %s %s --pattern \"%s\" --out %s --img %s"
                      (shell-quote-argument script)
                      (shell-quote-argument vault)
                      file-pattern
                      (shell-quote-argument (expand-file-name "roam/" org-directory))
                      (shell-quote-argument (expand-file-name "attachments/images/" org-directory))))
         (buffer (get-buffer-create "*obsidian-to-org*")))
    (if (file-exists-p script)
        (progn
          (with-current-buffer buffer
            (erase-buffer))
          (let ((compilation-buffer-name-function
                 (lambda (_) "*obsidian-to-org*")))
            (compile cmd t)))
      (user-error "Script not found: %s" script))))

(map! :leader
      (:prefix ("o" . "open")
       :desc "Obsidian .md to org" "O" #'obsidian-to-org))


;;; Mermaid via ob-mermaid. Renders #+begin_src mermaid blocks to PNG/SVG
;;; on C-c C-c. Requires `mmdc' (mermaid-cli) on $PATH:
;;;   npm install -g @mermaid-js/mermaid-cli
(after! ob-mermaid
  (setq ob-mermaid-cli-path (or (executable-find "mmdc")
                                "/usr/local/bin/mmdc")))


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `with-eval-after-load' block, otherwise Doom's defaults may override your
;; settings. E.g.
;;
;;   (with-eval-after-load 'PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look them up).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
