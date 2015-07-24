;; (Shamelessly based on chrisdone's emacs config)
;; Standard libraries needed
(require 'cl)

;; Packages to laod
(defvar packages
  '(better-defaults
    company
    company-jedi
    flycheck
    flycheck-pylama
    god-mode
    helm
    helm-projectile
    magit
    markdown-mode
    projectile
    rainbow-delimeters
    rust-mode
    smartscan
    smartparens
    sml-mode
    with-editor)
  "Packages whose location follows the
  packages/package-name/package-name.el format.")

(defvar configs
  '("global"
    "god"
    "golang"
    "haskell"
    "markdown"
    "rust"
    "python")
  "Configuration files that follow the config/foo.el path
  format.")

;; Load packages
(loop for name in packages
      do (progn (unless (fboundp name)
                  (add-to-list 'load-path
                               (concat (file-name-directory (or load-file-name
                                                                (buffer-file-name)))
                                       "packages/"
                                       (symbol-name name)))
                  (require name))))
;; Load configurations
(loop for name in configs
      do (load (concat (file-name-directory load-file-name)
                       "config/"
                       name ".el")))

;; font and color
(defun fontify-frame (frame)
  (set-frame-parameter frame 'font "Input-18"))
(fontify-frame nil)
(push 'fontify-frame after-make-frame-functions)
(load-theme 'gruvbox t)
(global-smartscan-mode 1)
;; Mode initializations
(add-hook 'after-init-hook #'global-flycheck-mode)
(god-mode)
