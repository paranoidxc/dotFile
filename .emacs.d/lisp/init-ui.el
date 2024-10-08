; (use-package gruvbox-theme
;              :init (load-theme 'gruvbox-dark-soft t))

;(load-theme 'dracula t)

; (use-package timu-macos-theme
;    :ensure t
;    :config
;    (load-theme 'timu-macos t))
;
; (load-theme 'timu-macos t)
; (customize-set-variable 'timu-macos-flavour 'dark)
; (customize-set-variable 'timu-macos-scale-org-document-title 1.8)
; (customize-set-variable 'timu-macos-scale-org-document-info 1.4)
; (customize-set-variable 'timu-macos-scale-org-level-1 1.8)
; (customize-set-variable 'timu-macos-scale-org-level-2 1.4)
; (customize-set-variable 'timu-macos-scale-org-level-3 1.2)

 ; (use-package timu-spacegrey-theme
 ;   :ensure t
 ;   :config
 ;   (load-theme 'timu-spacegrey-dark t))

;(load-theme 'timu-spacegrey t)
;(customize-set-variable 'timu-spacegrey-flavour "light")

;(load-theme 'timu-macos t)
;(customize-set-variable 'timu-macos-flavour "light")

;(load-theme 'dracula t)

;(use-package mindre-theme
;    :ensure t
;    :custom
;    (mindre-use-more-bold nil)
;    (mindre-use-faded-lisp-parens t)
;    :config
;    (load-theme 'mindre t))

;(setq mindre-use-more-bold t
;      mindre-use-more-fading t
;      mindre-use-faded-lisp-parens t
;      mindre-faded-lisp-parens-modes '(emacs-lisp-mode lisp-mode scheme-mode racket-mode))


(load-theme 'spacemacs-light t)
;(customize-set-variable 'spacemacs-macos-flavour "light")


(use-package smart-mode-line
  :init
  (setq sml/no-confirm-load-theme t
	sml/theme 'respectful)
  (sml/setup))


(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-item 10)

;; 这个快捷键绑定可以用之后的插件 counsel 代替
(global-set-key (kbd "C-x C-r") 'recentf-open-files)


(set-face-attribute 'default nil :height 240 :weight 'regular)
; (setq default-frame-alist '(
;  							(left . 0)
;  							(width . 0)
;  							(fullscreen . maximized)))
(global-hl-line-mode 1)
(set-frame-font "MesloLGS NF" nil t)

; 关闭自动生产的备份文件
(setq make-backup-files nil)
; 关闭自动生产的保存文件
(setq auto-save-default nil)
;(setq backup-inhibit-lock t)
;(setq auto-save-mode t)
;(desktop-save-mode 1)

(setq url-proxy-services '(("no_proxy" . "^\\(localhost\\|10\\..*\\|192\\.168\\..*\\)") ("http" . "127.0.0.1:7890") ("https" . "127.0.0.1:7890")))

;(with-proxy
;  (call-interactively #'all-the-icons-install-fonts))

(provide 'init-ui)
