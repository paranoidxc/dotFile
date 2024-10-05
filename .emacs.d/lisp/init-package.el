
(use-package restart-emacs)

(use-package benchmark-init
  :init (benchmark-init/activate)
  :hook (after-init . benchmark-init/deactivate))

(use-package emacs
  :config (defalias 'yes-or-no-p 'y-or-n-p))

(use-package emacs
  :config
  (setq display-line-numbers-type 'relative)
  (global-display-line-numbers-mode t))


(use-package crux
  :bind ("C-c k" . crux-smart-kill-line))

(use-package hungry-delete
  :bind (("C-c DEL" . hungry-delete-backward))
  :bind (("C-c d" . hungry-delete-forward)))

(use-package drag-stuff
  :bind (("<M-up>" . drag-stuff-up))
  :bind (("<M-down>" . drag-stuff-down)))


(use-package ivy 
  :defer 1 
  :demand 
  :hook (after-init . ivy-mode) 
  :config 
  (ivy-mode 1) 
  (setq ivy-use-virtual-buffers t 
        ivy-initial-inputs-alist nil 
        ivy-count-format "%d/%d " 
        enable-recursive-minibuffers t 
        ivy-re-builders-alist '((t . ivy--regex-ignore-order))))

(use-package counsel 
  :after (ivy) 
  :bind (("M-x" . counsel-M-x) 
         ("C-x C-f" . counsel-find-file) 
         ("C-c f" . counsel-recentf)
         ("C-c g" . counsel-git))) 

(use-package swiper 
  :after ivy 
  :bind (("C-s" . swiper) 
         ("C-r" . swiper-isearch-backward)) 
  :config (setq swiper-action-recenter t 
                swiper-include-line-number-in-search t))



(use-package company 
  :config 
  (setq company-dabbrev-code-everywhere t 
        company-dabbrev-code-modes t 
        company-dabbrev-code-other-buffers 'all 
        company-dabbrev-downcase nil 
        company-dabbrev-ignore-case t 
        company-dabbrev-other-buffers 'all 
        company-require-match nil 
        company-minimum-prefix-length 2 
        company-show-numbers t 
        company-tooltip-limit 20 
        company-idle-delay 0 
        company-echo-delay 0 
        company-tooltip-offset-display 'scrollbar 
        company-begin-commands '(self-insert-command)) 
  (push '(company-semantic :with company-yasnippet) company-backends) 
  :hook ((after-init . global-company-mode)))


(use-package flycheck 
  :hook (after-init . global-flycheck-mode))

(use-package crux 
  :bind (("C-a" . crux-move-beginning-of-line) 
         ("C-c ^" . crux-top-join-line)
         ("C-x ," . crux-find-user-init-file)
         ("C-S-d" . crux-duplicate-current-line-or-region)
         ("C-S-k" . crux-smart-kill-line)))

(use-package which-key 
  :defer nil 
  :config (which-key-mode))

(use-package ivy-posframe
 :init
	(setq ivy-posframe-display-functions-alist '((t . ivy-posframe-display-at-point)))
	;;(setq ivy-posframe-display-functions-alist '((t . ivy-posframe-display)))
	;;(setq ivy-posframe-display-functions-alist '((t . ivy-posframe-display-at-frame-center)))
	;;(setq ivy-posframe-display-functions-alist '((t . ivy-posframe-display-at-window-center)))
	;;(setq ivy-posframe-display-functions-alist '((t . ivy-posframe-display-at-frame-bottom-left)))
	;;(setq ivy-posframe-display-functions-alist '((t . ivy-posframe-display-at-window-bottom-left)))
	;;(setq ivy-posframe-display-functions-alist '((t . ivy-posframe-display-at-frame-top-center)))
)
(ivy-posframe-mode 1)

(use-package ace-window 
    :bind (("M-o" . 'ace-window)))


(setenv "PATH" (concat (getenv "PATH") ":/usr/local/go/bin:/Users/xc/go/bin:/usr/local/bin:/Users/xc/.emacs.d/.cache/lsp/npm/intelephense/bin"))

(use-package lsp-mode
  :init
  ;; set prefix for lsp-command-keymap (few alternatives - "C-l", "C-c l")
  (setq lsp-keymap-prefix "C-l")
  :hook (;; replace XXX-mode with concrete major-mode(e. g. python-mode)
         (go-mode . lsp-deferred)
         (php-mode . lsp-deferred)
         (c-mode . lsp-deferred)
         ;; if you want which-key integration
         (lsp-mode . lsp-enable-which-key-integration))
  :commands (lsp lsp-deferred))

;; optionally
(use-package lsp-ui :commands lsp-ui-mode)
;; if you are helm user
(use-package helm-lsp :commands helm-lsp-workspace-symbol)
;; if you are ivy user
(use-package lsp-ivy :commands lsp-ivy-workspace-symbol)
(use-package lsp-treemacs :commands lsp-treemacs-errors-list)

;; optionally if you want to use debugger
(use-package dap-mode)
;; (use-package dap-LANGUAGE) to load the dap adapter for your language

(setq lsp-go-analyses '((shadow . t)
                        (simplifycompositelit . :json-false)))

(setq dired-dwim-target t)
;(setq dired-listing-switches "-ahh"
; 	  dired-auto-revert-buffer t)
;(keymap-set dired-mode-map "C-b" dired-up-directory)
;(keymap-set dired-mode-map "C-f" dired-find-file)
;(keymap-set dired-mode-map "x" dired-do-flagged-delete)
(setq dirvish-attributes
      ;;'(vc-state subtree-state all-the-icons collapse git-msg file-time file-size))
      '(vc-state subtree-state vscode-icon collapse git-msg file-time file-size))
;(setq dirvish-attributes '(all-the-icons file-size))

;(setq dirvish-attributes
;      '(vscode-icon))
(setq dirvish-icon-size 16)

(dirvish-override-dired-mode)


(use-package dirvish
  :init
  (dirvish-override-dired-mode)
  :custom
  (dirvish-quick-access-entries ; It's a custom option, `setq' won't work
    '(("h" "~/"                       "Home")
      ("d" "~/Desktop"                "Desktop")
      ("p" "~/projects"               "projects")))

  :config
  (setq dirvish-attributes
    '(vc-state nerd-icons subtree-state collapse git-msg file-size))
;  (setq dirvish-subtree-state-style 'nerd)
;  (setq delete-by-moving-to-trash t)
 
  ; (setq dirvish-path-separators (list
  ;                                (format "  %s " (nerd-icons-codicon "nf-cod-home"))
  ;                                (format "  %s " (nerd-icons-codicon "nf-cod-root_folder"))
  ;                                (format " %s " (nerd-icons-faicon "nf-fa-angle_right"))))

  :bind ; Bind `dirvish|dirvish-side|dirvish-dwim' as you see fit
  (("C-c f" . dirvish-fd)
   :map dirvish-mode-map ; Dirvish inherits `dired-mode-map'
   ("a"   . dirvish-quick-access)
   ("f"   . dirvish-file-info-menu)
   ("y"   . dirvish-yank-menu)
   ("N"   . dirvish-narrow)
   ("^"   . dirvish-history-last)
   ("h"   . dirvish-history-jump) ; remapped `describe-mode'
   ("s"   . dirvish-quicksort)    ; remapped `dired-sort-toggle-or-edit'
   ("v"   . dirvish-vc-menu)      ; remapped `dired-view-file'
   ("TAB" . dirvish-subtree-toggle)
   ("M-f" . dirvish-history-go-forward)
   ("M-b" . dirvish-history-go-backward)
   ("M-l" . dirvish-ls-switches-menu)
   ("M-m" . dirvish-mark-menu)
   ("M-t" . dirvish-layout-toggle)
   ("M-s" . dirvish-setup-menu)
   ("M-e" . dirvish-emerge-menu)
   ("M-j" . dirvish-fd-jump)))


(setq dirvish-use-header-line 'global)    ; make header line span all panes
(setq dirvish-header-line-height '(25 . 35))
(setq dirvish-mode-line-height 25) ; shorthand for '(25 . 25)
(setq dirvish-header-line-format
      '(:left (path) :right (free-space))
      dirvish-mode-line-format
      '(:left (sort file-time " " file-size symlink) :right (omit yank index)))

(use-package dired-subtree
    :ensure t
    :after dired
    :bind (:map dired-mode-map
        ("<tab>" . dired-subtree-toggle)))



; (use-package dirvish
;   :init
;   (dirvish-override-dired-mode)
;   :custom
;   (dirvish-quick-access-entries ; It's a custom option, `setq' won't work
;    '(("h" "~/"                          "Home")
;      ("d" "~/Downloads/"                "Downloads")
;      ("m" "/mnt/"                       "Drives")
;      ("t" "~/.local/share/Trash/files/" "TrashCan")))
;   :config
;   ;; (dirvish-peek-mode) ; Preview files in minibuffer
;   ;; (dirvish-side-follow-mode) ; similar to `treemacs-follow-mode'
;   (setq dirvish-mode-line-format
;         '(:left (sort symlink) :right (omit yank index)))
;   (setq dirvish-attributes
;         '(all-the-icons file-time file-size collapse subtree-state vc-state git-msg))
;   (setq delete-by-moving-to-trash t)
;   (setq dired-listing-switches
;         "-l --almost-all --human-readable --group-directories-first --no-group")
;   :bind ; Bind `dirvish|dirvish-side|dirvish-dwim' as you see fit
;   (("C-c f" . dirvish-fd)
;    :map dirvish-mode-map ; Dirvish inherits `dired-mode-map'
;    ("a"   . dirvish-quick-access)
;    ("f"   . dirvish-file-info-menu)
;    ("y"   . dirvish-yank-menu)
;    ("N"   . dirvish-narrow)
;    ("^"   . dirvish-history-last)
;    ("h"   . dirvish-history-jump) ; remapped `describe-mode'
;    ("s"   . dirvish-quicksort)    ; remapped `dired-sort-toggle-or-edit'
;    ("v"   . dirvish-vc-menu)      ; remapped `dired-view-file'
;    ("TAB" . dirvish-subtree-toggle)
;    ("M-f" . dirvish-history-go-forward)
;    ("M-b" . dirvish-history-go-backward)
;    ("M-l" . dirvish-ls-switches-menu)
;    ("M-m" . dirvish-mark-menu)
;    ("M-t" . dirvish-layout-toggle)
;    ("M-s" . dirvish-setup-menu)
;    ("M-e" . dirvish-emerge-menu)
;    ("M-j" . dirvish-fd-jump)))




(projectile-mode +1)
(define-key projectile-mode-map (kbd "M-p") 'projectile-command-map)

(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1))

; (use-package doom-modeline
;   :ensure t
;   :hook (after-init . doom-modeline-mode))



(use-package vim-tab-bar
  :ensure t
  :commands vim-tab-bar-mode
  :hook
  (after-init . vim-tab-bar-mode))
(setq tab-bar-close-button-show t)       ;; hide tab close / X button

;;----------
;tab bar settings
(global-set-key (kbd "M-{") 'tab-bar-switch-to-prev-tab)
(global-set-key (kbd "M-}") 'tab-bar-switch-to-next-tab)
(global-set-key (kbd "M-t") 'tab-bar-new-tab)
(global-set-key (kbd "M-w") 'tab-bar-close-tab)
;;----------

(provide 'init-package)
