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
  
(load-theme 'timu-spacegrey t)
(customize-set-variable 'timu-spacegrey-flavour 'dark)

(use-package smart-mode-line
  :init
  (setq sml/no-confirm-load-theme t
	sml/theme 'respectful)
  (sml/setup))

(set-face-attribute 'default nil :height 170 :weight 'regular)
(setq default-frame-alist '(
							(left . 0)
							(width . 0)
							(fullscreen . maximized)))

(setq make-backup-files nil)
(setq auto-save-mode nil)
(setq auto-save-default nil)
(setq backup-inhibit-lock t)

(provide 'init-ui)
