;;; package --- Summary"

(require 'company)


(defun company-mytags-scan-project-root ()
  (let* ((root-dir (locate-dominating-file default-directory ".git"))
	 (find-cmd (format "find . -path \"*/.git\" -prune -o -type f -iname \"1.txt\" -print"))
	 (output (shell-command-to-string find-cmd))
	 (files (split-string output "[\n\r]+"))
	 (all-content "")
	 rlt)
    (message "root-dir=%s" root-dir)
    (message "files=%s" files)

    (dolist (file files)
      (when (and (not (string= file ""))
		      (file-exists-p file))
		 (message "file=%s" file)
		 (setq all-content
		       (concat all-content
			       (with-temp-buffer (insert-file-contents file)
						 (buffer-string))))))
    
    ;(message "all-content=%s len=%s"
	;     (substring all-content 0 100)
	;     (length all-content))

    ;; [a-zA-Z-_]+

    (setq rlt (delq nil (delete-dups
			 (sort
			  (split-string all-content "[^a-zA-Z-_]")
			  'string<))))
    ;(message "rlt=%s" rlt)
    rlt))


(defun company-mytags-candidates (prefix)
  (let* ((all-items (company-mytags-scan-project-root))
	 (i 0)
	 (pattern "^")
	 rlt)
    (while (< i (length prefix))
      (setq pattern (concat pattern (substring prefix i (1+ i)) ".*"))
      (setq i (1+ i)))
    ;(message "pattern=%s" pattern)
    (dolist (item all-items)
      (when (string-match pattern item)
	(push item rlt)))
    rlt))


(defun company-mytags-prefix ()
  (company-grab-symbol))

(defun company-mytags (command &optional arg &rest _ignored)
  (interactive (list 'interactive))
  (cl-case command
    (interactive (company-begin-backend 'company-mytags))
    (prefix (company-mytags-prefix))
    (candidates (company-mytags-candidates arg))))


(setq company-backends '(company-mytags))
(provide 'company-mytags)

;;; company-mytags.el ends here

