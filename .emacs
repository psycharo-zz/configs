
(tool-bar-mode nil)
(setq line-number-mode t)
(setq column-number-mode t)
(ido-mode t)
(fset 'yes-or-no-p 'y-or-n-p)

(add-to-list 'load-path "~/.emacs.d/")

;; pig
(require 'pig-mode)
(add-hook 'pig-mode-common-hook (lambda () (linum-mode t)))


;; markdown
(autoload 'markdown-mode "markdown-mode.el" "Major mode for editing Markdown files" t) 
(setq auto-mode-alist (cons '("\\.md" . markdown-mode) auto-mode-alist))

;; linum mode
;; enable/disable
(global-set-key (kbd "<f6>") 'linum-mode)

;; C++
(add-hook 'c-mode-common-hook (lambda () (linum-mode t)))
(add-hook 'c-mode-common-hook (lambda () (tabbar-mode t)))
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.c\\'" . c++-mode))