;;; package --- Summary;

(require 'ivy)

(defun my-find-grep-internal (keyword directory &optional grep-p)
  "Find/Search file in DIRECTORY.
IF GREP-P is t, grep file instead
IF GREP-P is nil, find file"
    (when (not (string= keyword ""))
      (message "grep-p=%s" grep-p)
      (message "directory=%s" directory)
      (let*
          ((find-cmd
            (format
             "find . -path \"*/.git\" -prune -o -type f -iname \"*%s*\" -print"
             keyword))
           (grep-cmd
            (format "grep --exclude-dir=\"*/.git\" -rsn \"%s\" *"
                    keyword))
           (default-directory directory)
           (outout
            (shell-command-to-string
             (if grep-p
                 grep-cmd
               find-cmd)))
           (lines (split-string outout "[\n\r]+"))
           (hint
            (if grep-p
                "Grep file in %s: "
              "Find file in %s: "))
           selected-line
           selected-file
           linenum)
        ;(unless grep-p (lines (cdr lines)))
        (setq selected-line
              (ivy-read (format hint default-directory) lines))
        (cond
         (grep-p
          (when (string-match
                 "^\\([^:]*\\):\\([0-9]*\\):" selected-line)
            (setq selected-file (match-string 1 selected-line))
            (setq linenum (match-string 2 selected-line))))
         (t
          (setq selected-file selected-line)))
        ;(message "selected-line=%s" selected-line)
        (when (and selected-line (file-exists-p selected-file))
          (find-file selected-file)
          ;; 打开buffer的第一个字符
          (when grep-p
            (goto-char (point-min))
            (forward-line (1- (string-to-number linenum))))))))

;; (defgroup my-find-group-config nil
;;   "Non-nil if my-find-group-config mode mode is enabled."
;;   :group 'my-find-group-config
;;   :prefix "my-find-group-config-"
;;   :link '(url-link "https://github.com/jamescherti/my-find-group-config.el"))

;; (defgroup my-find-grep-config nil
;;   :group 'my-find-grep-config
;;   :prefix "my-find-grep-config-"
;;   :version "0.1")

(defgroup my-find-group-config nil
  "Non-nil if my-find-group-config mode mode is enabled."
  :group 'my-find-group-config
  :prefix "my-find-group-config-"
  :link '(url-link "https://github.com/paranoidxc/xxxx.el"))

(defcustom my-find-group-config-project-hits nil
  "Show groups in the tab-bar."
  :type '(repeat symbol)
  ;;:initialize (init-prod-list)
  :group 'my-find-group-config)


;; (defcustom my-find-grep-project-hint t
;;   :type 'list
;;   :initialize '( .prod .git .svn)
;;   :set (lambda (sym val)
;;          (set-default sym val)
;;          (force-mode-line-update))
;;   :group 'my-find-grep-config
;;   :version "0.1")


(setq prod-list '(".prod" ".git" ".svn"))

(defun init-prod-list ()
  prod-list)

(defun opposite-type (ident)
  (if (equal ident ".")
      ","
    "."))

(defun inner-type (keyword ident)
  (cond
   ((equal (substring keyword 0 1) ident)
	t)
   ((>= (length keyword) 2)
    (if
	(and (equal (substring keyword 0 1) (opposite-type ident))
	     (equal (substring keyword 1 2) ident))
	t
      nil))
   (t nil)))

(defun is-current-directory (keyword)
  (inner-type keyword "."))

(defun is-grep (keyword)
  (inner-type keyword ","))

(defun trim-keyword (keyword)
  (let ((c (substring keyword 0 1)))
    (if (or (equal c ".") (equal c ","))
	(trim-keyword (substring keyword 1 (length keyword)))
      keyword)))
  
(defun get-prod-directory (tmp-prod-list)
 (if (equal (length tmp-prod-list) 0)
     nil
   (let* ((path (locate-dominating-file default-directory (car tmp-prod-list))))
     (if path
	 path
       (get-prod-directory (cdr tmp-prod-list))))))

(defun get-search-directory ()
  (or (locate-dominating-file default-directory ".prod")
      (locate-dominating-file default-directory ".git")
      (locate-dominating-file default-directory ".svn")))


(defun my-find-grep-combine ()
  "Find file in current directory or LEVEL parent directory
Find file in project directory
Grep file in current directory or LEVEL parent directory
Grep file in project directory
Grep file start keyword with comma"
  (interactive)
  (let* ((keyword (read-string "Find/Grep(prefix with,) keyword: "))
	 search-directory)
    ;; (message my-find-group-config-project-hits)
    ;; (message (format "keyword=%s" keyword))
    ;; (message (format "search-dir=%s" (get-search-directory)))
    (when (not (string= keyword ""))
      ;; (setq search-directory (get-search-directory))
      (setq search-directory
	    (if (equal (is-current-directory keyword) nil)
		nil
	      (get-prod-directory prod-list)))
      (setq clean-keyword (trim-keyword keyword))
      (cond
        ;; ((equal (substring keyword 0 1) ",")
       ((is-grep keyword)
	;;(my-find-grep-internal (substring keyword 1 (length keyword)) search-directory t))
	(my-find-grep-internal clean-keyword search-directory t))
       (t
	(my-find-grep-internal clean-keyword search-directory))))))

(provide 'my-find-grep-combine)
;;; my-find-grep-combine.el ends here
