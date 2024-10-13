;;; package --- Summary"

(require 'company)

(defvar mycompany-cache nil
  "Cache of tags file")

(defun tags-file-update-p (tags-file)
  ;; (message "tags-file=%s" tags-file)
  (let* (rlt
         old-mod-time
         file-mod-time)
    (cond
     ((not mycompany-cache)
      (setq rlt t))
     (t
      (setq old-mod-time
            (plist-get mycompany-cache 'modificationt-time))
      (setq file-mod-time
            (float-time (nth 5 (file-attributes tags-file))))
      (when (> (- file-mod-time old-mod-time) 4)
        (setq rlt t))))
    rlt))

(defun company-mytags-scan-project-root ()
  (let* ((root-dir (locate-dominating-file default-directory "TAGS"))
         (tags-file (concat root-dir "TAGS"))
         (all-content "")
         (regex
          "^[^\177\001]+\177\\(\[^\177\001]+\\)\001[0-9]+,[0-9]+$")
         (start 0)
         tag-name
         candidates)

    (when (or (not mycompany-cache) (tags-file-update-p tags-file))
      (setq mycompany-cache
            (plist-put
             mycompany-cache
             'modificationt-time
             (float-time (nth 5 (file-attributes tags-file)))))
      (when (file-exists-p tags-file)
        (setq all-content
              (with-temp-buffer
                (insert-file-contents tags-file)
                (buffer-string)))

        (while (string-match regex all-content start)
          (setq tag-name (match-string 1 all-content))
          ;; (message "tag-name=%s" tag-name)
          (push tag-name candidates)
          (setq start
                (+ start (length (match-string 0 all-content)))))) ; 0 整个匹配的串

      (setq candidates
            (delq nil (delete-dups (sort candidates 'string<))))

      (setq mycompany-cache
            (plist-put mycompany-cache 'candidates candidates)))))


(defun company-mytags-candidates (prefix)
  (let* ((i 0)
         (pattern "^")
         rlt)
    (company-mytags-scan-project-root)
    (while (< i (length prefix))
      (setq pattern (concat pattern (substring prefix i (1+ i)) ".*"))
      (setq i (1+ i)))
    ;; (message "pattern=%s" pattern)
    (dolist (item (plist-get mycompany-cache 'candidates))
      (when (string-match pattern item)
        (push item rlt)))
    rlt))


(defun company-mytags-prefix ()
  (company-grab-symbol))

(defun mycompany (command &optional arg &rest _ignored)
  (interactive (list 'interactive))
  (cl-case
   command
   (interactive (company-begin-backend 'company-mytags))
   (prefix (company-mytags-prefix))
   (candidates (company-mytags-candidates arg))))


(setq company-backends '(mycompany))
(provide 'mycompany)

;;; mycompany.el ends here
