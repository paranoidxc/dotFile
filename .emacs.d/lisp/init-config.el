(setq tab-bar-close-button-show nil)       ;; hide tab close / X button
(setq tab-bar-new-button-show nil)       ;; hide tab close / X button
(setq tab-bar-tab-hints t)
(require 'init-vim-tab-bar)
(setq vim-tab-bar-mode t)
(global-set-key (kbd "M-1") (lambda () (interactive) (tab-bar-select-tab 1)))
(global-set-key (kbd "M-2") (lambda () (interactive) (tab-bar-select-tab 2)))
(global-set-key (kbd "M-3") (lambda () (interactive) (tab-bar-select-tab 3)))
(global-set-key (kbd "M-4") (lambda () (interactive) (tab-bar-select-tab 4)))
(global-set-key (kbd "M-5") (lambda () (interactive) (tab-bar-select-tab 5)))
(global-set-key (kbd "M-6") (lambda () (interactive) (tab-bar-select-tab 6)))
(global-set-key (kbd "M-7") (lambda () (interactive) (tab-bar-select-tab 7)))
(global-set-key (kbd "M-8") (lambda () (interactive) (tab-bar-select-tab 8)))
(global-set-key (kbd "M-9") (lambda () (interactive) (tab-bar-select-tab 9)))

(setq mycustom-file (expand-file-name "~/.emacs.d/lisp/custom.el"))
(load mycustom-file)

(setq custom-file (expand-file-name "~/.emacs.d/custom.el"))
(load custom-file 'no-error 'no-message)

; 自动加载外部修改过的文件
(global-auto-revert-mode 1)

;; 快速打开配置文件
(defun open-init-file()
  (interactive)
  (find-file "~/.emacs.d/init.el"))

;; 这一行代码，将函数 open-init-file 绑定到 <f2> 键上
(global-set-key (kbd "<f2>") 'open-init-file)

(provide 'init-config)
