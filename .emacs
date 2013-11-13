(package-initialize)
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")
                         ("melpa" . "http://melpa.milkbox.net/packages/")))
;; theme
(setq inhibit-startup-message t)
(menu-bar-mode -1)

;; (require 'smooth-scroll)
;; (smooth-scroll-mode t)
;; (setq auto-window-vscroll nil)
(setq ring-bell-function 'ignore)

;; nicer scrolling
(setq scroll-step            1
      scroll-conservatively  10000)

(setq mouse-wheel-scroll-amount '(1 ((shift) . 1) ((control) . nil)))
;;(setq mouse-wheel-progressive-speed nil)
(setq-default cursor-type 'bar) 
(blink-cursor-end)


;; for gui mode
(when window-system
  (load-theme 'solarized-dark t)
  (tool-bar-mode -1)
  (scroll-bar-mode -1)
  (set-default-font "Menlo-12")
  (exec-path-from-shell-initialize)
  )


;; mouse support in terminal
(unless window-system
  (require 'mouse)
  (xterm-mouse-mode t)
  (global-set-key [mouse-4] '(lambda ()
                              (interactive)
                              (scroll-down 1)))
  (global-set-key [mouse-5] '(lambda ()
                              (interactive)
                              (scroll-up 1)))
  (defun track-mouse (e))
  (setq mouse-sel-mode t)
)

;; (setq linum-format "%3d\u2502 ")
(require 'auto-complete)
(require 'auto-complete-config)
(ac-config-default)
;;(global-auto-complete-mode t)

(define-key ac-complete-mode-map "\C-n" 'ac-next)
(define-key ac-complete-mode-map "\C-p" 'ac-previous)
;; (setq ac-auto-start 3)
(setq ac-auto-start nil)

(require 'auto-complete-config)

(require 'ac-math)
(add-to-list 'ac-modes 'LaTeX-mode)   ; make auto-complete aware of `latex-mode`
(defun ac-latex-mode-setup ()         ; add ac-sources to default ac-sources
  (auto-complete-mode t)
  (setq ac-sources (append '(ac-source-math-unicode 
			     ac-source-math-latex 
			     ac-source-latex-commands) ac-sources))
  )
(add-hook 'LaTeX-mode-hook 'ac-latex-mode-setup)



;; tex support 
(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq TeX-save-query nil)
(setq TeX-PDF-mode t)
;;(require 'latex-pretty-symbols)
(setq TeX-electric-sub-and-superscript t)
;; dirty hack to scroll pages 
(fset 'doc-prev "\C-xo\C-x[\C-xo")
(fset 'doc-next "\C-xo\C-x]\C-xo")
(global-set-key (kbd "M-[") 'doc-prev)
(global-set-key (kbd "M-]") 'doc-next)

(setq load-path (cons (expand-file-name "~/.emacs.d/elpa/cmake-mode-20110824") load-path))
(require 'cmake-mode)
(setq auto-mode-alist
      (append '(("CMakeLists\\.txt\\'" . cmake-mode)
                ("\\.cmake\\'" . cmake-mode))
              auto-mode-alist))

(setq column-number-mode t)
(ido-mode t)
(fset 'yes-or-no-p 'y-or-n-p)

;; decent scrolling
(setq scroll-step            1
      scroll-conservatively  10000)

;; copying to x
(setq x-select-enable-clipboard t)

;; make use of bash completion
(require 'bash-completion)
(bash-completion-setup)

;; python
(require 'python-mode)
(add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))
(add-hook 'python-mode-hook (lambda () (linum-mode t)))

(require 'autopair)

;; linum mode
;; enable/disable
(global-set-key (kbd "<f6>") 'linum-mode)

;; C++
(require 'auto-complete-clang-async)

(defun my-c-mode-common-hook ()
  (flymake-mode t)
  (linum-mode t)
  (cppcm-reload-all)
  (setq ac-sources '(ac-source-clang-async))
  (ac-clang-launch-completion-process)
  (setq c-basic-offset 4)
  (c-set-offset 'substatement-open 0)
)
(add-hook 'c-mode-common-hook 'my-c-mode-common-hook)
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.c\\'" . c++-mode))



;; switch between headers
(global-set-key (kbd "<f4>") 'ff-find-other-file)


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes (quote ("d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879" "e16a771a13a202ee6e276d06098bc77f008b73bbac4d526f160faa2d76c1dd0e" "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" default))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )




