;;; init-yasnippet.el -- support for yasnippet
;;; Commentary:
;;; Code:
(use-package yasnippet
  :ensure t
  :init (add-to-list 'load-path
                     "~/.emacs.d/snippet")
  :config
  (yas-global-mode 1)
  (use-package yasnippet-snippets
    :ensure t))


(provide 'init-yasnippet)
;;; init-yasnippet.el ends here
