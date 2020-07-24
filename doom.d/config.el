;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Tim Deeb-Swihart"
      user-mail-address "tim@deebswih.art")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

(after! lsp
  (setq lsp-file-watch-ignored
        '(
          "[/\\\\]\\.direnv$"
          "[/\\\\]\\.gems$"
                                        ; SCM tools
          "[/\\\\]\\.git$"
          "[/\\\\]\\.hg$"
          "[/\\\\]\\.bzr$"
          "[/\\\\]_darcs$"
          "[/\\\\]\\.svn$"
          "[/\\\\]_FOSSIL_$"
                                        ; IDE tools
          "[/\\\\]\\.idea$"
          "[/\\\\]\\.vscode$"
          "[/\\\\]\\.ensime_cache$"
          "[/\\\\]\\.eunit$"
          "[/\\\\]node_modules$"
          "[/\\\\]\\.fslckout$"
          "[/\\\\]\\.tox$"
          "[/\\\\]\\.stack-work$"
          "[/\\\\]\\.bloop$"
          "[/\\\\]\\.metals$"
          "[/\\\\]target$"
          "[/\\\\]dist$"
                                        ; Autotools output
          "[/\\\\]\\.deps$"
          "[/\\\\]build-aux$"
          "[/\\\\]autom4te.cache$"
          "[/\\\\]\\.reference$"

                                        ; Assorted state dirs
          "[/\\\\]\\.terraform$"
          "[/\\\\]\\.vagrant$"
          "[/\\\\]vendor$"
          ))
  )


;; Yank-pop
(after! hydra
  (defhydra hydra-yank-pop ()
    "yank"
    ("C-y" yank nil)
    ("M-y" yank-pop nil)
    ("y" (yank-pop 1) "next")
    ("Y" (yank-pop -1) "prev")
    ("l" helm-show-kill-ring "list" :color blue))   ; or browse-kill-ring
  (global-set-key (kbd "M-y") #'hydra-yank-pop/yank-pop)
  (global-set-key (kbd "C-y") #'hydra-yank-pop/yank)

  (defhydra hydra-org ()
    "Org helpers"
    ("a" org-agenda)
    ("c" org-capture)
    ("s" org-schedule))

  (defhydra hydra-rg ()
    "ripgrep"
    ("d" 	rg-dwim)
    ("k" 	rg-kill-saved-searches)
    ("l" 	rg-list-searches)
    ("p" 	rg-project)
    ("r" 	rg)
    ("s" 	rg-save-search)
    ("S" 	rg-save-search-as-name)
    ("t" 	rg-literal))

  ;; Flycheck controls
  (defhydra hydra-flycheck (global-map "C-c e")
    "Compilation errors"
    ("h" flycheck-first-error)
    ("j" flycheck-next-error)
    ("k" flycheck-previous-error)
    ("l" (condition-case err
             (while t
               (flycheck-next-error))
           (user-error nil))
     nil :bind nil)
    ("q" nil            nil :color blue) )

  (defhydra hydra-windows (:exit t)
    "
^Focus^              ^Management^
---------------------------------------
_o_: other-window    _0_: delete-window
_h_: left            _1_: delete-other
_l_: right           _2_: vertical
_k_: up              _3_: horizontal
_j_: down            _f_: delete-frame
"
    ("o" other-window)
    ("h" windmove-left)
    ("l" windmove-right)
    ("j" windmove-down)
    ("k" windmove-up)
    ("0" delete-window :color blue)
    ("1" delete-other-windows)
    ("2" split-window-vertically)
    ("3" split-window-horizontally)
    ("f" delete-frame)
    )
  (global-set-key (kbd "C-c w") 'hydra-windows/body)

  (defhydra hydra-describe ()
    "
Describe:
_k_: key-binding
_f_: function
_v_: variable
_m_: mode
"
    ("k" describe-key)
    ("f" counsel-describe-function)
    ("v" counsel-describe-variable)
    ("m" describe-mode))

  ;; Buffer controls
  (defhydra hydra-buffer-menu (:color pink
                               :hint nil)
    "
^Mark^             ^Unmark^           ^Actions^          ^Search
^^^^^^^^-----------------------------------------------------------------
_m_: mark          _u_: unmark        _x_: execute       _R_: re-isearch
_s_: save          _U_: unmark up     _b_: bury          _I_: isearch
_d_: delete        ^ ^                _g_: refresh       _O_: multi-occur
_D_: delete up     ^ ^                _T_: files only: % -28`Buffer-menu-files-only
_~_: modified
"
    ("m" Buffer-menu-mark)
    ("u" Buffer-menu-unmark)
    ("U" Buffer-menu-backup-unmark)
    ("d" Buffer-menu-delete)
    ("D" Buffer-menu-delete-backwards)
    ("s" Buffer-menu-save)
    ("~" Buffer-menu-not-modified)
    ("x" Buffer-menu-execute)
    ("b" Buffer-menu-bury)
    ("g" revert-buffer)
    ("T" Buffer-menu-toggle-files-only)
    ("O" Buffer-menu-multi-occur :color blue)
    ("I" Buffer-menu-isearch-buffers :color blue)
    ("R" Buffer-menu-isearch-buffers-regexp :color blue)
    ("c" nil "cancel")
    ("v" Buffer-menu-select "select" :color blue)
    ("o" Buffer-menu-other-window "other-window" :color blue)
    ("q" quit-window "quit" :color blue))

  (define-key Buffer-menu-mode-map "." 'hydra-buffer-menu/body)

  ;; Projectile
  (defhydra hydra-projectile-other-window (:color teal)
    "projectile-other-window"
    ("f"  projectile-find-file-other-window        "file")
    ("g"  projectile-find-file-dwim-other-window   "file dwim")
    ("d"  projectile-find-dir-other-window         "dir")
    ("b"  projectile-switch-to-buffer-other-window "buffer")
    ("q"  nil                                      "cancel" :color blue))

  (defhydra hydra-projectile (:color teal
                              :hint nil)
    "
     PROJECTILE: %(projectile-project-root)

     Find...                 Search                 Buffers                 Management
---------------------------------------------------------------------------------
  _e_: file               _f_: rg                _i_: Ibuffer            _x_: remove known project
                          _m_: multi-occur       _b_: switch to buffer   _X_: cleanup known projects
_s-k_: Kill all buffers                                                  _p_: switch project
  _d_: dir                _`_: other-window

"
    ("f"   counsel-projectile-ag)
    ("b"   counsel-projectile-switch-to-buffer)
    ("d"   counsel-projectile-find-dir)
    ("e"   counsel-projectile-find-file)
    ("i"   projectile-ibuffer)
    ("s-k" projectile-kill-buffers)
    ("m"   projectile-multi-occur)
    ("p"   projectile-switch-project)
    ("x"   projectile-remove-known-project)
    ("X"   projectile-cleanup-known-projects)
    ("`"   hydra-projectile-other-window/body "other window")
    ("q"   nil "cancel" :color blue))

  (global-set-key (kbd "C-c p") 'hydra-projectile/body))

(after! magit-todos
  (setq magit-todos-require-colon nil
        magit-todos-update t
        magit-todos-depth 100
        magit-todos-nice nil
        magit-todos-keywords-list '("TODO" "XXX" "FIXME" "KLUDGE" "fixme" "todo")
        magit-todos-scanner 'magit-todos--scan-with-rg))


(after! rustic
  (setq rustic-lsp-server 'rust-analyzer)
  (setq lsp-rust-analyzer-server-command "~/.local/bin/rust-analyzer"))


(after! flycheck
  (push 'rustic-clippy flycheck-checkers))

(after! envrc
  (envrc-global-mode))

(setq avy-keys '(?a ?o ?e ?u ?i ?d ?h ?t ?n ?s))

; Some handy leader bindings from my old custom config
(map! :leader
      :desc "Switch to buffer" "d" #'switch-to-buffer
      :desc "Find file"        "e" #'counsel-find-file
      :desc "Window controls"  "t" #'hydra-windows/body
      :desc "Resume last ivy search" "r" #'ivy-resume
      )

(provide 'config.el)
;;; config.el ends here
