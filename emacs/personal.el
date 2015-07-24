;; Save all temp files to /tmp/
(setq backup-directory-alist
                `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
                `((".*" ,temporary-file-directory t)))
;; SMLNJ setup
(autoload 'sml-mode "sml-mode" "Major mode for editing SML." t)
(autoload 'run-sml "sml-proc" "Run an inferior SML process." t)
;; Auto do sml-mode
(add-to-list 'auto-mode-alist '("\\.\\(sml\\|sig\\)\\'" . sml-mode))
(setq sml-program-name "sml")

;; Smartscan <https://github.com/mickeynp/smart-scan> setup
(package-install 'smartscan)
(load-theme 'gruvbox t)
(defun fontify-frame (frame)
  (set-frame-parameter frame 'font "Input-18"))
;; Fontify the current frame
(fontify-frame nil)
(push 'fontify-frame after-make-frame-functions)

;; Flycheck ALL THE THINGS
(add-hook 'after-init-hook #'global-flycheck-mode)


;; Python
(add-hook 'python-mode-hook (lambda ()
                              (require 'sphinx-doc)
                              (sphinx-doc-mode t)))
(load-theme 'gruvbox)
(provide 'personal)
