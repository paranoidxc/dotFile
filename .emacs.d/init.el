(add-to-list 'load-path (expand-file-name (concat user-emacs-directory "lisp")))


;(load (expand-file-name ("/~/.emacs.d/custom.el")))
(load "/Users/xc/.emacs.d/lisp/custom.el")

(require 'init-const)
(require 'init-kbd)
(require 'init-startup)
(require 'init-elpa)
(require 'init-package)
(require 'init-ml)
;(require 'custom)

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

(require 'init-ui)


