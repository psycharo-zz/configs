;; packages
;; (package-initialize)
;; (setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
;; 			 ("marmalade" . "http://marmalade-repo.org/packages/")
;; 			 ("melpa" . "http://melpa.milkbox.net/packages/")))
;; el-get
(add-to-list 'load-path "~/.emacs.d/el-get/el-get/")
(require 'el-get)
(el-get 'sync)


;; helm config
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-set-key (kbd "C-x b") 'helm-mini)
(global-set-key (kbd "C-x C-b") 'helm-mini)
(global-set-key (kbd "M-y") 'helm-show-kill-ring)

(require 'helm-config)
(setq helm-autoresize-max-height 30)
(setq helm-autoresize-min-height 30)
(helm-mode t)
(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action)


;; ui

;; by default 
(setq-default fill-column 100)
;; ain't noone got time for that
(menu-bar-mode -1)
(tool-bar-mode -1)
(setq inhibit-startup-message t
      ring-bell-function 'ignore)
(blink-cursor-mode 0)                          
(setq-default cursor-type 'bar)
(fset 'yes-or-no-p 'y-or-n-p)


(setq mouse-wheel-scroll-amount '(1 ((shift) . 1)) ;; one line at a time
      mouse-wheel-follow-mouse 't) ;; scroll window under mouse

;; multi-term is awesome
(require 'multi-term)
(global-set-key (kbd "<f2>") 'multi-term)
;; it meant for emacs to follow current terminal path. but does this actually work?
(defadvice term-send-input (after update-cwd)
  (let* ((pid (process-id (get-buffer-process (current-buffer))))
	 (cwd (shell-command-to-string
	       (format "lsof -p %d -Fn | awk 'NR==2{print}' | sed \"s/n\\//\\//\" |  tr -d '\n'" pid))))
    (cd cwd)))
(ad-activate 'term-send-input)
(setq system-uses-terminfo nil)

;; making shorcuts work in the terminal
(setq term-bind-key-alist
      (list (cons "C-c C-c"   'term-interrupt-subjob)
	    (cons "C-x" 'term-send-raw)
	    (cons "M-f"       'term-send-forward-word)
	    (cons "M-b"       'term-send-backward-word)
	    (cons "C-c C-j"   'term-line-mode)
	    (cons "C-c C-k"   'term-char-mode)
	    (cons "M-DEL"     'term-send-backward-kill-word)
	    (cons "M-d"       'term-send-forward-kill-word)
	    (cons "<C-left>"  'term-send-backward-word)
	    (cons "<C-right>" 'term-send-forward-word)
	    (cons "C-r"       'term-send-reverse-search-history)
	    (cons "M-p"       'term-send-raw-meta)
	    (cons "M-y"       'term-send-raw-meta)
	    (cons "C-y"       'term-send-raw)))
;; END multi-term

;; nicer indicator bar (line)
(require 'powerline)
(powerline-vim-theme)

;; synchronize with osx copy-buffer
(defun copy-from-osx ()
  (shell-command-to-string "pbpaste"))
(defun paste-to-osx (text &optional push)
  (let ((process-connection-type nil))
    (let ((proc (start-process "pbcopy" "*Messages*" "pbcopy")))
      (process-send-string proc text)
      (process-send-eof proc))))
(setq interprogram-cut-function 'paste-to-osx
      interprogram-paste-function 'copy-from-osx)

;; various small stuff
(dolist (mode
         '(column-number-mode
	   electric-pair-mode
	   show-paren-mode)) 
  (funcall mode 1))

;; auto brackets
(electric-pair-mode t)
(setq electric-pair-pairs '(
                            (?\" . ?\")
                            (?\{ . ?\})
                            ) )
;; show brackets straight away
(setq show-paren-delay 0)

;; line numbers everywhere
(global-linum-mode t)
(setq linum-format "%d ")

;; AC (auto-complete)
(require 'auto-complete)
(require 'auto-complete-config)
(ac-config-default)
;; disable annoying ac-linum bug
(ac-linum-workaround)
(setq ac-quick-help-delay 1)
(setq ac-auto-start 1)
(setq ac-use-menu-map t)
;; use at most 100 suggestions
(setq ac-candidate-limit 50)
(define-key ac-menu-map "C-n" 'ac-next)
(define-key ac-menu-map "C-p" 'ac-previous)
(global-auto-complete-mode t)
;; END AC

;; yasnippet
;(require 'yasnippet)

;; global compilation
(global-set-key (kbd "s-b") 'compile)
(setq compilation-read-command nil)

;; C++ stuff
;; (require 'cpputils-cmake)
(setenv "LD_LIBRARY_PATH"
	"/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib/")


(require 'ac-helm)

(eval-after-load "helm-regexp"
    '(setq helm-source-moccur
           (helm-make-source "Moccur"
               'helm-source-multi-occur :follow 1)))

(defun my-helm-multi-occur ()
  "multi-occur in all buffers backed by files."
  (interactive)
  (helm-multi-occur
   (delq nil
         (mapcar (lambda (b)
                   (when (buffer-file-name b) (buffer-name b)))
                 (buffer-list)))))

(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))

(defun my:c-mode-hook ()
  (linum-mode t)

  ;; flycheck: on-the-fly syntax checking
  (require 'flycheck)
  (flycheck-mode t)
  (setq flycheck-clang-language-standard "c++11")  
  
  ;; clang-based code completion (doesn't work very well yet)  
  ;; (require 'irony)
  ;; (require 'ac-irony)
  ;; (irony-mode t)
  ;; (add-to-list 'ac-sources 'ac-source-irony)
  ;; (define-key irony-mode-map (kbd "M-RET") 'ac-complete-irony-async)
  

  (setq c-default-style "ellemtel")
  (setq-default c-basic-offset 2)
  ;; show fill column
  (fci-mode t)
  (setq fci-rule-column 100)
  ;; snippets
  ;(yas-global-mode t)
  ;; no offset for new string
  (c-set-offset 'substatement-open 0)

  ;; custom compile command
  (setq compile-command '"cd build ; cmake ../ -G Ninja; ninja ")
  ;; function arguments hints (+moo-complete)
  (require 'function-args)  
  (fa-config-default)
  ;; semantic for better completion (NOTE: too slow to use with ac-mode)
  (semantic-mode t)
  (semantic-add-system-include "/usr/local/include")
  (semantic-add-system-include "/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/include/c++/v1/")  

  ;;  (add-to-list 'ac-sources 'ac-source-semantic)
  ;; headers completion
  (require 'auto-complete-c-headers)
  (add-to-list 'ac-sources 'ac-source-c-headers)
  ;; TODO: this is only working for OSX
  (add-to-list 'achead:include-directories
	       '"/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/include/c++/v1/")

  (local-set-key (kbd "C-c C-o") 'ff-find-other-file)
  (local-set-key (kbd "C-c C-j") 'semantic-ia-fast-jump)
  (local-set-key (kbd "C-c C-h") 'helm-occur)
  (local-set-key (kbd "C-c C-f") 'my-helm-multi-occur)
  (setq find-file-wildcards 0)
  )


(add-hook 'c-mode-common-hook 'my:c-mode-hook)
(add-hook 'c++-mode-hook 'my:c-mode-hook)

;; this fixes enum class indents
(defun inside-class-enum-p (pos)
  "Checks if POS is within the braces of a C++ \"enum class\"."
  (ignore-errors
    (save-excursion
      (goto-char pos)
      (up-list -1)
      (backward-sexp 1)
      (looking-back "enum[ \t]+class[ \t]+[^}]+"))))

(defun align-enum-class (langelem)
  (if (inside-class-enum-p (c-langelem-pos langelem))
      0
    (c-lineup-topmost-intro-cont langelem)))

(defun align-enum-class-closing-brace (langelem)
  (if (inside-class-enum-p (c-langelem-pos langelem))
      '-
    '+))

(defun fix-enum-class ()
  "Setup `c++-mode' to better handle \"class enum\"."
  (add-to-list 'c-offsets-alist '(topmost-intro-cont . align-enum-class))
  (add-to-list 'c-offsets-alist
               '(statement-cont . align-enum-class-closing-brace)))

(add-hook 'c++-mode-hook 'fix-enum-class)

;; END C++ stuff


;; LaTeX stuff
(add-hook 'LaTeX-mode-hook '(flyspell-mode t))
;; END LaTeX stuff

;; X-only stuff
(when (window-system)
  (global-set-key (kbd "<s-escape>") 'toggle-frame-fullscreen)
  (scroll-bar-mode -1)
  (set-default-font "Menlo-12")
  (exec-path-from-shell-initialize)
  (setq x-select-enable-clipboard t)
  (setq linum-format "%d")
  )
(load-theme 'solarized-dark t)
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)
