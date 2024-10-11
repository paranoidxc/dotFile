;;; package --- Summary;

(defun clear-messages-buffer ()
  (interactive)
  (let ((inhibit-read-only t))
    (with-current-buffer "*Messages*"
      (erase-buffer))))


(provide 'init-handy)
;;; company-mytags.el ends here
