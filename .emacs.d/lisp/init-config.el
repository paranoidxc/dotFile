(setq tab-bar-close-button-show nil) ;; hide tab close / X button
(setq tab-bar-new-button-show nil) ;; hide tab close / X button
(setq tab-bar-tab-hints t)
(require 'init-vim-tab-bar)
(setq vim-tab-bar-mode t)
(global-set-key
 (kbd "M-1")
 (lambda ()
   (interactive)
   (tab-bar-select-tab 1)))
(global-set-key
 (kbd "M-2")
 (lambda ()
   (interactive)
   (tab-bar-select-tab 2)))
(global-set-key
 (kbd "M-3")
 (lambda ()
   (interactive)
   (tab-bar-select-tab 3)))
(global-set-key
 (kbd "M-4")
 (lambda ()
   (interactive)
   (tab-bar-select-tab 4)))
(global-set-key
 (kbd "M-5")
 (lambda ()
   (interactive)
   (tab-bar-select-tab 5)))
(global-set-key
 (kbd "M-6")
 (lambda ()
   (interactive)
   (tab-bar-select-tab 6)))
(global-set-key
 (kbd "M-7")
 (lambda ()
   (interactive)
   (tab-bar-select-tab 7)))
(global-set-key
 (kbd "M-8")
 (lambda ()
   (interactive)
   (tab-bar-select-tab 8)))
(global-set-key
 (kbd "M-9")
 (lambda ()
   (interactive)
   (tab-bar-select-tab 9)))

(setq my-find-file (expand-file-name "~/.emacs.d/lisp/my-find.el"))
(load my-find-file)

(setq custom-file (expand-file-name "~/.emacs.d/custom.el"))
(load custom-file 'no-error 'no-message)

; 自动加载外部修改过的文件
(global-auto-revert-mode 1)

;; 快速打开配置文件
(defun open-init-file ()
  (interactive)
  (find-file "~/.emacs.d/init.el"))

;; 这一行代码，将函数 open-init-file 绑定到 <f2> 键上
(global-set-key (kbd "<f2>") 'open-init-file)


; When t (the default), the user is asked before every code
;      block evaluation.  When ‘nil’, the user is not asked.  When
;      set to a function, it is called with two arguments (language
;      and body of the code block) and should return t to ask and
;      ‘nil’ not to ask.
(setq org-confirm-babel-evaluate nil)
(setq elisp-autofmt-python-bin "python3")

;; 设置垃圾回收参数
(setq gc-cons-threshold most-positive-fixnum)
(setq gc-cons-percentage 0.6)

(defun mymsg ()
  (interactive)
  (message "ECHO"))


;(setq key-chord-two-keys-delay 0.5)
;(local-set-key (kbd ",ff") 'mymsg)
;(key-chord-define evil-insert-state-map "jj" 'evil-normal-state)
;(key-chord-mode 1)


;(define-key key-translation-map (kbd "A") (kbd "M-g A"))
;(global-set-key (kbd "M-g A") 'mymsg)

(global-set-key "\C-ca" 'org-agenda)

;(global-set-key "M-x C-c ff" 'my-find-file)
;(global-set-key (kbd "M-x ,ff")
;(defalias 'ff 'my-find-file)
;(defalias 'fp 'my-find-file)

(define-prefix-command 'my-leader)
;(global-set-key (kbd ",") 'my-leader)
;(global-set-key (kbd ",,") (lambda() ( (interactive) (insert ",")))
;(global-set-key (kbd ", ff") (lambda () (interactive) (my-find-file)))

;(global-set-key (kbd ", 1") 'winum-select-window-1)
;(global-set-key (kbd ", 2") 'winum-select-window-2)
;(global-set-key (kbd ", 3") (lambda () (interactive) (winum-select-window-3)))
;(global-set-key (kbd ", 4") (lambda () (interactive) (winum-select-window-4)))

;(keymap-set evil-motion-state-map "," 'my-leader)
(keymap-set evil-normal-state-map "," 'my-leader)
(evil-define-key nil my-leader
    ;; add your bindings here:
    "ff"  'my-find-grep-combine
    "fd"  'dirvish
    ;; "B"  'project-switch-to-buffer
    ;; "pf" 'project-find-file
    ;; "ps" 'project-shell-command
    ;; etc.
    )

(setq winum-keymap
    (let ((map (make-sparse-keymap)))
      (define-key map (kbd "M-0") 'winum-select-window-0-or-10)
      (define-key map (kbd "M-1") 'winum-select-window-1)
      (define-key map (kbd "M-2") 'winum-select-window-2)
      (define-key map (kbd "M-3") 'winum-select-window-3)
      (define-key map (kbd "M-4") 'winum-select-window-4)
      (define-key map (kbd "M-5") 'winum-select-window-5)
      (define-key map (kbd "M-6") 'winum-select-window-6)
      (define-key map (kbd "M-7") 'winum-select-window-7)
      (define-key map (kbd "M-8") 'winum-select-window-8)
      map))
(require 'winum)
(winum-mode)



(provide 'init-config)
