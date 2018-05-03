;;; packages.el --- haskell-ide-engine packages for Spacemacs layer
;;
;; Copyright (c) 2018 Irreverent Pixel Feats
;;
;; Author: Dom De Re <domdere@irreverentpixelfeats.com>
;; URL: https://github.com/irreverentpixelfeats/spacemacs-hie
;;
;; This file is not part of GNU Emacs.
;;
;; Completely lifted from here: https://gist.github.com/puffnfresh/dc9842076d261c95f798
;;; License: BSD3

;; List of all packages to install and/or initialize. Built-in packages
;; which require an initialization must be listed explicitly in the list.
(setq hie-packages '(
  company-lsp
  (flycheck-haskell :toggle (configuration-layer/package-usedp 'flycheck))
  haskell-snippets
  haskell-mode
  lsp-haskell
  lsp-ui
  lsp-mode
  ))

;; List of packages to exclude.
(setq hie-excluded-packages '())

;; For each package, define a function ipf/init-<package-name>
;;
;; (defun ipf/init-my-package ()
;;   "Initialize my package"
;;   )
;;
;; Often the body of an initialize function uses `use-package'
;; For more info on `use-package', see readme:
;; https://github.com/jwiegley/use-package

;; (defun hie/post-init-company ()
;;  (spacemacs|add-company-hook lsp-mode)
;;)

(defun hie/init-company-lsp ()
  (use-package company-lsp)
)

(defun hie/init-flycheck-haskell ()
  (use-package flycheck-haskell
    :commands flycheck-haskell-configure
    :init (add-hook 'flycheck-mode-hook 'flycheck-haskell-configure)
  )
)

(defun hie/init-haskell-mode ()
  (use-package haskell-mode)
)

(defun hie/init-haskell-snippets ()
  ;; manually load the package since the current implementation is not lazy
  ;; loading friendly (funny coming from the haskell mode :-))
  (use-package haskell-snippets)
  (setq haskell-snippets-dir
        (configuration-layer/get-elpa-package-install-directory
         'haskell-snippets)
  )

  (defun haskell-snippets-initialize ()
    (let ((snip-dir (expand-file-name "snippets" haskell-snippets-dir)))
      (add-to-list 'yas-snippet-dirs snip-dir t)
      (yas-load-directory snip-dir))
  )

  (with-eval-after-load 'yasnippet (haskell-snippets-initialize))
)

(defun hie/init-company-lsp ()
  (use-package company-lsp)
)

(defun hie/init-lsp-mode ()
  (use-package lsp-mode)
)

(defun hie/init-lsp-ui ()
  (use-package lsp-ui)
)

(defun hie/init-lsp-haskell ()
  (use-package lsp-haskell
    :config
    (add-hook 'lsp-mode-hook 'lsp-ui-mode)
    (add-hook 'haskell-mode-hook #'lsp-haskell-enable)
    (add-hook 'haskell-mode-hook 'flycheck-mode)
  )
)
