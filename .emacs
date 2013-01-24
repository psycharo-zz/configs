;; linum mode
(setq linum-format "%3d\u2502 ")

(setq column-number-mode t)
(ido-mode t)
(fset 'yes-or-no-p 'y-or-n-p)

;; decent scrolling
(setq scroll-step            1
      scroll-conservatively  10000)

;; copying to x
(setq x-select-enable-clipboard t)


;; configuration path
(add-to-list 'load-path "~/.emacs.d/")


;; make use of bash completion
(require 'bash-completion)
(bash-completion-setup)


;; python
(require 'python-mode)
(add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))
(add-hook 'python-mode-hook (lambda () (linum-mode t)))

(require 'autopair)

(require 'flymake)
(when (load "flymake" t) 
  (defun flymake-pyflakes-init () 
    (let* ((temp-file (flymake-init-create-temp-buffer-copy 
		       'flymake-create-temp-inplace)) 
	   (local-file (file-relative-name 
			temp-file 
			(file-name-directory buffer-file-name)))) 
      (list "pyflakes" (list local-file)))) 

  (add-to-list 'flymake-allowed-file-name-masks 
	       '("\\.py\\'" flymake-pyflakes-init))) 

(add-hook 'find-file-hook 'flymake-find-file-hook)


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
