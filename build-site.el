;; Set the package installation directory so that packages aren't stored in the
;; ~/.emacs.d/elpa path.
(require 'package)
(setq package-user-dir (expand-file-name "./.packages"))
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))

;; Initialize the package system
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

;; Install dependencies
(package-install 'htmlize)
(package-install 'ox-pandoc)
(package-install 'org-ref)
(package-install 'ov)


;; (url-copy-file "https://raw.githubusercontent.com/emacsmirror/org-contrib/master/lisp/ox-extra.el" "./.packages/ox-extra.el" t)
;; (url-copy-file "https://raw.githubusercontent.com/jkitchin/jmax/master/org-colored-text.el"
;; 	       "./.packages/org-colored-text.el" t)

(add-to-list 'load-path "./.packages")
(add-to-list 'load-path "./extra-packages")

;; Load the publishing system
(require 'ox-publish)
(require 'ox-pandoc)
(require 'org-ref)
(require 'org-colored-text)
(require 'ox-extra)
(ox-extras-activate '(ignore-headlines))

;; Setup Inline-js
(add-to-list 'org-src-lang-modes '("inline-js" . javascript))
(defvar org-babel-default-header-args:inline-js
  '((:results . "html")
    (:exports . "results")))
(defun org-babel-execute:inline-js (body _params)
  (format "<script type=\"text/javascript\">\n%s\n</script>" body))

;; Setup Inline-css
(add-to-list 'org-src-lang-modes '("inline-css" . css))
(defvar org-babel-default-header-args:inline-css
  '((:results . "html")
    (:exports . "results")))
(defun org-babel-execute:inline-css (body _params)
  (format "<style type=\"text/css\">\n%s\n</style>" body))

;; Customize the HTML output
(setq org-html-validation-link nil
      org-html-head-include-scripts nil
      org-html-head-include-default-style nil
      org-html-prefer-user-labels t
      org-html-head ""
      org-html-postamble t
      org-html-postamble-format '(("en"
				   "<div id=\"footer\">\n \
				   <ul>\n<li><a href=\"/~nidish/sitemap.html\" title=\"Sitemap\">Sitemap</a></li>\n \
				   <li><a href=\"mailto:nidish@iitm.ac.in\" title=\"Email me at nidish@iitm.ac.in !\">Contact</a></li>\n \
				   <li><a href=\"/~nidish/personal.html#blog-creation\" title=\"See my notes on building it\"> \
				   Like this CSS?</a></li>\n \
				   </ul>\n </div>\n\n \
				   <p class=\"creator\">Created using %c.</p>\n \
				   <p class=\"date\">Last updated: %d.</p>\n\n"
				   ))
      org-html-doctype "html5"
      org-html-html5-fancy nil
      org-confirm-babel-evaluate nil
      org-export-babel-evaluate t
      org-export-use-babel t
      org-publish-use-timestamps-flag t
      org-ref-insert-cite-function (lambda () (org-cite-insert nil))
      )

(setq org-latex-preview-process-default 'dvisvgm)

;; Define the publishing project
(setq org-publish-project-alist
      (list
       (list "ViND Lab Site"
	     :recursive t
	     :base-directory "./content"
	     :publishing-directory "./public"
	     :publishing-function 'org-html-publish-to-html
	     :with-author t
	     :with-creator t
	     :with-toc t
	     :with-date t
	     :section-numbers nil
	     :time-stamp-file nil
	     :auto-sitemap t
	     :sitemap-style 'tree
	     )
       (list "css-js-media"
	     :recursive t
	     :base-directory "./content/"
	     :publishing-directory "./public"
	     :base-extension "css\\|js\\|svg\\|png\\|jpg\\|jpeg\\|gif\\|pdf\\|mp3\\|ogg\\|swf\\|bib\\|ico\\|hdf\\|edp\\|stl"
	     :publishing-function 'org-publish-attachment
	     :exclude "ltximg/*"
	     )
       ))

;; Generate the site output
(org-publish-all t)
