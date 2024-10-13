;;; package --- Summary"
;;; Commentary:

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

(defun my-single-or-double-quote-range (count beg end type inclusive)
  (let* ((s-range (evil-select-quote ?' beg end type count inclusive))
	 (d-range (evil-select-quote ?\" beg end type count inclusive))
	 (beg (min (nth 0 s-range) (nth 0 d-range)))
	 (end (max (nth 1 s-range) (nth 1 d-range))))
    (setf (nth 0 s-range) beg)
    (setf (nth 1 s-range) end)
    s-range))

(evil-define-text-object
  my-evil-a-single-or-double-quote (count &optional beg end type) "Select a single-quoted expression."
  :extend-selection nil
  (my-single-or-double-quote-range count beg end type t))

(evil-define-text-object
 my-evil-inner-single-or-double-quote (count &optional beg end type) "Select 'inner' single-quoted expression."
 :extend-selection nil
 (my-single-or-double-quote-range count beg end type nil))
 

(define-key evil-outer-text-objects-map "t" 'my-evil-a-textobj)
(define-key evil-inner-text-objects-map "t" 'my-evil-inner-textobj)

(define-key evil-outer-text-objects-map "i" #'my-evil-a-single-or-double-quote)
(define-key evil-inner-text-objects-map "i" #'my-evil-inner-single-or-double-quote)

(provide 'my-evil-textobj)
;;; my-evil-textobj ends here
