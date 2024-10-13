;;; package --- Summary"
(require 'ivy)
(require 'xref)

(defun my-codenav ()
  (interactive)
  ;(message "codenav call")
  (let*
      ((root-dir (locate-dominating-file default-directory "TAGS"))
       (tags-file (concat root-dir "TAGS"))
       candidates
       all-content
       cur-line
       selected-candidate
       (regex
        "^\\([^\177\001]+\\)\177[^\177\001]+\001\\([0-9]+\\),[0-9]+$")
       (symbol (thing-at-point 'symbol))
       (default-directory root-dir))

    (setq all-content
          (with-temp-buffer
            (insert-file-contents tags-file)
            (buffer-string)))

    ;; (message "all-content length=%s" (length all-content))

    (when (and symbol (not (string= symbol "")))
      ;(message "symbol=%s" symbol)
      (with-temp-buffer
        (insert all-content)
        (goto-char (point-min))

        (while (search-forward-regexp (concat "\177" symbol "\001")
                                      (point-max)
                                      t)
	  (message "FIND")
          ;; 取得当前行信息
          (setq cur-line
                (buffer-substring
                 (line-beginning-position) (line-end-position)))
          (when (string-match regex cur-line)
            (let* ((code-line (match-string 1 cur-line))
                   (line-num
                    (string-to-number (match-string 2 cur-line)))
                   (file (etags-file-of-tag t))
		   one-candidate)
	      ;(setq one-candidate (cons (format "%s:%s:%s" file line-num code-line)
	      ;			(list code-line line-num file)))

	      (setq one-candidate (format "%s:%s:%s" file line-num code-line))

              ;; (message "code-line=%s" code-line)
              ;; (message "line-num=%s" line-num)
              ;; (message "file=%s" file)
              (push one-candidate candidates)))
          ;(forward-line) ;; 不需要
          ))

      ;; (message "candidates=%s len=%s"
      ;;          candidates
      ;;          (length candidates))

      (when candidates
	(setq selected (ivy-read "Navigate to: " candidates))
	(message "selected=%s" selected)
	(when (string-match "^\\([^:]+\\):\\([0-9]+\\):\\(.*\\)" selected)
	  (let* ((file (match-string 1 selected))
		 (line-num (match-string 2 selected)))
	    (message "file=%s line-num=%s" file line-num)

	    (when (and file (file-exists-p file))
	      (xref-push-marker-stack (point-marker))
	      (find-file file)
	      (goto-char (point-min))
	      (forward-line (1- (string-to-number line-num)))
	      (xref-pulse-momentarily)
	      )
	    )
	  )
	)
      )))

;(provide 'my-codenav)

;;; my-codenav.el ends here
