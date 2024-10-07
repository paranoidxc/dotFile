;;; package -summary;

(require 'ivy)

(defun my-search-internal (directory &optional grep-p)
  "Find/Search file in DIRECTORY.
IF GREP-P is t, grep file instead
IF GREP-P is nil, find file"
  (let* ((keyword (read-string "Please input keyword: ")))
    ;(when (any keyword (not (string= keyword "")))
    (when (not (string= keyword ""))
      (let* ((find-cmd (format "find . -path \"*/.git\" -prune -o -type f -iname \"*%s*\" -print" keyword))
	     (grep-cmd (format "grep --exclude-dir=\"*/.git\" -rsn \"%s\" *" keyword))
	     (default-directory directory)
	     (outout (shell-command-to-string (if grep-p grep-cmd find-cmd)))
	     (lines (split-string outout "[\n\r]+"))
	     (hint (if grep-p "Grep file in %s: " "Find file in %s: "))
	     selected-line
	     selected-file
	     linenum)
	;(unless grep-p (lines (cdr lines)))
	(setq selected-line
	     (ivy-read (format hint default-directory)
		       lines))
	(cond
	 (grep-p
	  (when (string-match "^\\([^:]*\\):\\([0-9]*\\):" selected-line)
	    (setq selected-file (match-string 1 selected-line))
	    (setq linenum (match-string 2 selected-line)))
	 )
	 (t
	  (setq selected-file selected-line)))
	;(message "selected-line=%s" selected-line)
	(when (and selected-line (file-exists-p selected-file))
	  (find-file selected-file)
	  ;; 打开buffer的第一个字符
	  (when grep-p
	    (goto-char (point-min))
	    (forward-line (1- (string-to-number linenum)))))
       ))))

(defun my-search-text-in-project ()
  "Search text of file in project root directory."
  (interactive)
  (my-search-internal (locate-dominating-file default-directory ".git") t))

(defun my-search-text (&optional level)
  "Serch text of file in current directory or LEVEL parent directory "
  (interactive "P")
  ;(message "level=%s" level)
  (unless level (setq level 0))
  (let* ((parent-directory default-directory)
	 (i 0))
    (while (< i level)
      (setq parent-directory
	    (file-name-directory
	     (directory-file-name parent-directory)))
      (setq i (+ i 1)))
    ;(message  "parent-directory=%s" parent-directory)
    (my-search-internal parent-directory t)))



(defun my-find-file-internal (directory)
  "Find file in DIRECTORY."
  (let* ((keyword (read-string "Please input keyword: ")))
    ;(when (any keyword (not (string= keyword "")))
    (when (not (string= keyword ""))
      (let* ((cmd (format "find . -path \"*/.git\" -prune -o -type f -iname \"*%s*\" -print" keyword))
	 (default-directory directory)
	 ;(default-directory (locate-dominating-file default-directory ".git"))
	 (outout (shell-command-to-string cmd))
	 ;(lines (cdr (split-string outout "[\n]+")))
	 (lines (split-string outout "[\n]+"))
	 selected-line
	)
       (message "cmd=%s" cmd)
       ;(message "outout=%s" outout)
       ;(message "lines=%s" lines)
       (setq selected-line
	     (ivy-read (format "Find file %s: " default-directory)
		       lines))
       ;(message "selected-line=%s" selected-line)
       (when (and selected-line (file-exists-p selected-line))
	     (find-file selected-line))
       ))))

(defun my-find-file-in-project ()
  "Find file in project root directory."
  (interactive)
  (my-find-file-internal (locate-dominating-file default-directory ".git"))
  )

(defun my-find-file (&optional level)
  "Find file in current directory or LEVEL parent directory "
  (interactive "P")
  ;(message "level=%s" level)
  (unless level (setq level 0))
  (let* ((parent-directory default-directory)
	 (i 0))
    (while (< i level)
      (setq parent-directory
	    (file-name-directory
	     (directory-file-name parent-directory)))
      (setq i (+ i 1)))
    ;(message  "parent-directory=%s" parent-directory)
    (my-find-file-internal parent-directory)))

(provide 'custom)

;;}}
