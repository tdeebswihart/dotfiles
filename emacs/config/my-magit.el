(require 'magit)

(with-eval-after-load 'info
  (info-initialize)
  (add-to-list 'Info-directory-list
	       "~/.emacs.d/packages/magit/Documentation/"))

(provide 'my-magit)
