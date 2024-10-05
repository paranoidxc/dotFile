(add-to-list 'load-path (expand-file-name (concat user-emacs-directory "lisp")))

(require 'init-const)
(require 'init-kbd)
(require 'init-startup)
(require 'init-elpa)
(require 'init-package)
;(require 'init-ml)
(require 'init-ui)




(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("b7cd95933faca2de39fcf0caa097d36b152ac6c42adc6591c22ed6c16a557dc1" "5a0ddbd75929d24f5ef34944d78789c6c3421aa943c15218bac791c199fc897d" "551320837bd87074e3de38733e0a8553618c13f7208eda8ec9633d59a70bc284" default))
 '(package-selected-packages
   '(projectile compile-multi-nerd-icons all-the-icons-dired vscode-dark-plus-theme all-the-icons-nerd-fonts dired-collapse vscode-icon dired-subtree all-the-icons pdf-tools dirvish php-mode dracula-theme company smart-mode-line restart-emacs sml-mode))
 '(scroll-bar-mode nil)
 '(tool-bar-mode nil)
 '(warning-suppress-log-types '((pdf-view)))
 '(warning-suppress-types '((pdf-view))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
