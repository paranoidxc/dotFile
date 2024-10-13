;;; package --- Summary"
(require 'evil)

(defun my-skip-white-space ()
  (let* (b)
    (save-excursion
      (goto-char (line-beginning-position))
      (setq b (point))
      (while (and (< b e)
                  ;; 9 tab 32 space
                  (memq (following-char) '(9 32)))
        (forward-char))
      (setq b (point)))))

(evil-define-text-object
 my-evil-a-textobj (count &optional beg end type) "Select a word."
 (let* (b
        (e (line-end-position)))
   (setq b (my-skip-white-space))
   (list b e)))


(evil-define-text-object
 my-evil-inner-textobj
 (count &optional beg end type)
 "Select inner word."
 (let* (b
        (e (line-end-position)))
   (setq b (my-skip-white-space))

   (setq b
   (save-excursion
     (goto-char b)
     (while (and (< b e) (not (eq (following-char) 61)))
       (forward-char))
     (cond
      ((eq (point) e) b) ;; 找不到等号
      (t (1+ (point))))))
   (list b e)))


(define-key evil-outer-text-objects-map "t" 'my-evil-a-textobj)
(define-key evil-inner-text-objects-map "t" 'my-evil-inner-textobj)

(provide 'my-evil-textobj)
;;; my-evil-textobj ends here
