;; Latex Configuration

(setq TeX-auto-save t)
(setq TeX-parse-self t)

;;Outline Mode
(add-hook 'LaTeX-mode-hook 'outline-minor-mode)
(add-hook 'LaTeX-mode-hook (lambda () (local-set-key (kbd "<C-tab>") 'outline-toggle-children)))

;(eval-after-load 'latex '(define-key 'LaTeX-mode-map (kbd "<C-tab>") 'outline-toggle-children))



(setq TeX-electric-math (cons "$" "$"))
;; (setq LaTeX-electric-left-right-brace t)
(setq TeX-electric-sub-and-superscript t)
(add-hook  'TeX-mode-hook 'prettify-symbols-mode)

(setq TeX-source-correlate-mode t)
(setq TeX-source-correlate-start-server t)
(setq TeX-source-correlate-method 'synctex)
(setq TeX-view-program-list 
  '(("Sumatra PDF" ("\"d:/Program Files/SumatraPDF/SumatraPDF.exe\" -reuse-instance" 

                      (mode-io-correlate " -forward-search %b %n ") " %o"))))

(setq TeX-view-program-selection  

      '(((output-dvi style-pstricks) "dvips and start") (output-dvi "Yap") 

       (output-pdf "Sumatra PDF") (output-html "start")))



(setq TeX-command-force "LaTeX")
(setq TeX-clean-confirm t)

;; Add -shell-escape ;minted needs this
(setq-default TeX-engine 'xetex)
(eval-after-load "tex" 
  '(setcdr (assoc "LaTeX" TeX-command-list)
           '("%`%l%(mode) -shell-escape%' %t"
             TeX-run-TeX nil (latex-mode doctex-mode) :help "Run LaTeX")
           )
  )

;; Helm/Ivy-bibtex Setting
(autoload 'ivy-bibtex "ivy-bibtex" "" t)
;; ivy-bibtex requires ivy's `ivy--regex-ignore-order` regex builder, which
;; ignores the order of regexp tokens when searching for matching candidates.
;; Add something like this to your init file:
(setq ivy-bibtex-default-action 'ivy-bibtex-insert-citation)
(setq ivy-re-builders-alist
      '((ivy-bibtex . ivy--regex-ignore-order)
        (t . ivy--regex-plus)))

;; (helm-delete-action-from-source "Insert Citation" helm-source-bibtex)
;; (helm-add-action-to-source "Insert Citation" 'bibtex-completion-insert-citation helm-source-bibtex 0)
(setq bibtex-completion-library-path '("~/Documents/bib/pdf" ))
(setq bibtex-completion-notes-path "~/Documents/bib/notes")
(setq bibtex-completion-bibliography
      '("~/Documents/mybib.bib"))
(setq bibtex-completion-pdf-field "File")

;; RefTex Setting
(setq reftex-plug-into-AUCTeX t)
(add-hook 'LaTeX-mode-hook 'reftex-mode)
(setq reftex-default-bibliography '("~/Documents/mybib.bib"))
;;org-ref
;; (setq org-ref-completion-library 'org-ref-ivy-cite)
;; (require 'org-ref)
;; (setq reftex-default-bibliography '("c:/users/admin/Documents/mybib.bib"))

(provide 'init-latex)
;;; init-latex ends here
