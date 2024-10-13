;;; package --- Summary"
;;; Commentary"

(defun before-save-hook-setup ()
  (when (string-match "el$" buffer-file-name)
    (elisp-autofmt-buffer)
    (message "elisp-autofmt-buffer called")))


(defun after-save-hook-setup ()
  (message "buffer-line-name=%s" buffer-file-name)
  (message "my after-save-hook-setup called")
  ; (local-set-key (kbd "M-;") 'comment-dwim)
  )


(add-hook 'after-save-hook 'after-save-hook-setup)
(add-hook 'before-save-hook 'before-save-hook-setup)

(provide 'init-hook)

;;; init-hook.el ends here
