;;; flycheck-pylama.el --- Support pylama in flycheck

;; Copyright (C) 2015 Tim Swihart <chronon@me.com>
;;
;; Author: Tim Swihart <chronon@me.com>
;; Created: 24 July 2015
;; Version: 0.1
;; Package-Requires: ((flycheck "0.18"))

;;; Commentary:

;; This package adds support for pylama to flycheck. To use it, add
;; to your init.el:

;; (require 'flycheck-pylama)
;; (add-hook 'python-mode-hook 'flycheck-mode)

;; If you want to use pylama you probably don't want pylint or
;; flake8. To disable those checkers, add the following to your
;; init.el:

;; (add-to-list 'flycheck-disabled-checkers 'python-flake8)
;; (add-to-list 'flycheck-disabled-checkers 'python-pylint)

;;; License:

;; This file is not part of GNU Emacs.
;; However, it is distributed under the same license.

;; GNU Emacs is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 3, or (at your option)
;; any later version.

;; GNU Emacs is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to the
;; Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
;; Boston, MA 02110-1301, USA.

;;; Code:
(require 'flycheck)

(flycheck-define-checker python-pylama
  "A Python syntax and style checker using the pylama utility.

See URL `http://pypi.python.org/pypi/pylama'."
  :command ("pylama" source-inplace)
  :error-patterns
  ((error line-start (file-name) ":" line ":" (message) line-end))
  :modes python-mode)

(add-to-list 'flycheck-checkers 'python-pylama)

(provide 'flycheck-pylama)
;;; flycheck-pylama.el ends here
