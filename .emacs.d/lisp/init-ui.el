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

(use-package smart-mode-line
  :init
  (setq sml/no-confirm-load-theme t
	sml/theme 'respectful)
  (sml/setup))

(set-face-attribute 'default nil :height 140 :weight 'regular)
; (setq default-frame-alist '(
;  							(left . 0)
;  							(width . 0)
;  							(fullscreen . maximized)))
(set-frame-font "MesloLGS NF" nil t) 

;(setq make-backup-files nil)
;(setq auto-save-default nil)
;(setq backup-inhibit-lock t)
;(setq auto-save-mode t)
;(desktop-save-mode 1)

(setq url-proxy-services '(("no_proxy" . "^\\(localhost\\|10\\..*\\|192\\.168\\..*\\)") ("http" . "127.0.0.1:7890") ("https" . "127.0.0.1:7890")))

;(with-proxy
;  (call-interactively #'all-the-icons-install-fonts))

(provide 'init-ui)
