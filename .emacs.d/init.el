;;; package --- Summary
;;; Commentary

(add-to-list 'load-path (expand-file-name (concat user-emacs-directory "lisp")))

(require 'init-const)
(require 'init-kbd)
(require 'init-startup)
(require 'init-elpa)
(require 'init-package)
(require 'init-ml)
(require 'init-org)
(require 'init-ui)
(require 'init-config)
(require 'init-handy)

(provide 'init)
