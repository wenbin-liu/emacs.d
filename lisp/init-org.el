(use-package org-modern
  :ensure t
  :hook (org-mode . org-modern-mode)
  )

(setq org-log-done t
      org-hide-emphasis-markers t
      org-catch-invisible-edits 'show
      org-export-coding-system 'utf-8
      org-pretty-entities t
      )

(with-eval-after-load 'org
  (org-babel-do-load-languages
   'org-babel-load-languages
   (seq-filter
    (lambda (pair)
      (locate-library (concat "ob-" (symbol-name (car pair)))))
    '((R . t)
      (ditaa . t)
      (dot . t)
      (emacs-lisp . t)
      (gnuplot . t)
      (haskell . nil)
      (latex . t)
      (ledger . t)
      (ocaml . nil)
      (octave . t)
      (plantuml . t)
      (python . t)
      (ruby . t)
      (screen . nil)
      (sh . t) ;; obsolete
      (shell . t)
      (sql . t)
      (ipython . t)
      (sqlite . t)))))

;;; org-ref

(use-package org-ref
  ;; :config
  ;; (defun my/org-ref-open-pdf-at-point ()
  ;;   "Open the pdf for bibtex key under point if it exists."
  ;;   (interactive)
  ;;   (let* ((results (org-ref-get-bibtex-key-and-file))
  ;;          (key (car results))
  ;;          (pdf-file (car (bibtex-completion-find-pdf key))))
  ;;     (if (file-exists-p pdf-file)
  ;;         (org-open-file pdf-file)
  ;;       (message "No PDF found for %s" key))))
  ;; (setq org-ref-open-pdf-function 'my/org-ref-open-pdf-at-point)
  :ensure t
  :init
  (with-eval-after-load 'ox
    (defun my/org-ref-process-buffer--html (backend)
      "Preprocess `org-ref' citations to HTML format.

Do this only if the export backend is `html' or a derivative of
that."
      ;; `ox-hugo' is derived indirectly from `ox-html'.
      ;; ox-hugo <- ox-blackfriday <- ox-md <- ox-html
      (when (org-export-derived-backend-p backend 'html)
        (org-ref-process-buffer 'html)))
    (add-to-list 'org-export-before-parsing-hook #'my/org-ref-process-buffer--html))
  )


;;; Latex Setting
(setq org-latex-compiler "xelatex")
;;(setq org-latex-pdf-process (list "latexmk -pdflatex=xelatex -shell-escape -bibtex -f -pdf %f"))
;; (setq org-latex-pdf-process (list "latexmk -xelatex -gg -shell-escape -bibtex -f -pdf %b.tex"))
(setq org-latex-pdf-process (list "latexmk -pdflatex='%latex -shell-escape -interaction nonstopmode' -pdf -output-directory=%o %f"))

;;odt export settings
(setq org-latex-to-mathml-convert-command
      "latexmlmath \"%i\" --presentationmathml=%o")



;;; org-roam
;;;
(use-package org-roam
  :ensure t
  :init
  (setq org-roam-directory "~/Documents/org-roam")
  (setq org-roam-db-location "~/Documents/org-roam/org-roam.db")
  (setq org-roam-tag-sources '(prop vanilla))
  (setq org-roam-v2-ack t)
  :bind (("C-c n l" . org-roam-buffer-toggle)
         ("C-c n f" . org-roam-node-find)
         ("C-c n g" . org-roam-graph)
         ("C-c n i" . org-roam-node-insert)
         ("C-c n c" . org-roam-capture)
         ;; Dailies
         ("C-c n j" . org-roam-dailies-capture-today))
  :config
  (org-roam-db-autosync-mode)
  (setq org-id-track-globally t)
  (setq org-roam-capture-templates '(
                                     ("d" "default" plain "%?"
                                      :target (file+head "%<%Y%m%d%H%M%S>-${slug}.org"
                                                         "#+title: ${title}\n")
                                      :unnarrowed t)
                                     ("e" "encryption" plain "%?"
                                      :target (file+head "%<%Y%m%d%H%M%S>-${slug}.org.gpg"
                                                         "#+title: ${title}\n")
                                      :unnarrowed )))
  )


;;; org-roam-bibtex
(use-package org-roam-bibtex
  :ensure t
  :after org-roam
  )


;;;ox-hugo
(use-package ox-hugo
  :ensure t          ;Auto-install the package from Melpa (optional)
  :after ox)



;;; pretty entities



;; Olivetti
;; Look & Feel for long-form writing

;; Set the body text width
;; (setq olivetti-body-width 80)

;; Enable Olivetti for text-related mode such as Org Mode
;; (add-hook 'text-mode-hook 'olivetti-mode)


(use-package org-crypt
  :config
  (org-crypt-use-before-save-magic)
  (setq org-tags-exclude-from-inheritance '("crypt"))
  (setq org-crypt-key nil)
  )
;; GPG key to use for encryption
;; Either the Key ID or set to nil to use symmetric encryption.


;; org-babel
(use-package ob-ipython
  :ensure t
  :config
  (setq org-confirm-babel-evaluate nil)   ;don't prompt me to confirm everytime I want to evaluate a block
  (add-hook 'org-babel-after-execute-hook 'org-display-inline-images 'append) ;;; display/update images in the buffer after I evaluate
  )


;; org-download
(use-package org-download
  :ensure t
  :init
  (add-hook 'dired-mode-hook 'org-download-enable))



(provide 'init-org)
;;; init-org.el ends here
