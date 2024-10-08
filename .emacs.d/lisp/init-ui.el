(load-theme 'spacemacs-light t)

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


(set-face-attribute 'default nil :height 160 :weight 'regular)
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
(setq backup-inhibit-lock t)
;(setq auto-save-mode t)
;(desktop-save-mode 1)

(setq url-proxy-services '(("no_proxy" . "^\\(localhost\\|10\\..*\\|192\\.168\\..*\\)") ("http" . "127.0.0.1:7890") ("https" . "127.0.0.1:7890")))

;(with-proxy
;  (call-interactively #'all-the-icons-install-fonts))

(provide 'init-ui)
