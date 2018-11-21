(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(package-initialize)


;; for mac
(when (eq system-type 'darwin)
  (setq mac-option-modifier 'meta)
  (setq mac-command-modifier 'super)
  (add-hook 'window-setup-hook 'toggle-frame-fullscreen t)
  ;; sets fn-delete to be right-delete
  (global-set-key [kp-delete] 'delete-char)
  (global-set-key (kbd "<s-escape>") 'toggle-frame-fullscreen)
  (global-set-key (kbd "s-v") 'yank)
  (global-set-key (kbd "s-c") 'kill-ring-save)
  (blink-cursor-mode 0)
  )

;; we like killing other buffers
(defun kill-other-buffers ()
  "Kill all buffers but the current one.
Don't mess with special buffers."
  (interactive)
  (dolist (buffer (buffer-list))
    (unless (or (eql buffer (current-buffer)) (not (buffer-file-name buffer)))
      (kill-buffer buffer))))

;; we hate bars
;(tool-bar-mode -1)
;(scroll-bar-mode -1)
(global-linum-mode t)
(column-number-mode t)
(setq inhibit-startup-screen t)

;; we like zenburn
(load-theme 'zenburn t)
;; we like helm
(require 'helm)
(require 'helm-config)
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "M-y") 'helm-show-kill-ring)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-set-key (kbd "C-x b") 'helm-mini)
(setq helm-buffers-fuzzy-matching t
      helm-recentf-fuzzy-match    t)
;; we like lean helm
(setq helm-display-header-line nil)
(set-face-attribute 'helm-source-header nil :height 0.1)
(helm-autoresize-mode t)
(setq helm-autoresize-max-height 20)
(setq helm-autoresize-min-height 20)
(setq helm-split-window-in-side-p t)

(setq-default
 whitespace-line-column 100
 whitespace-style       '(face lines-tail))

;; we like projectile
(helm-projectile-on)
(projectile-mode t)
(setq projectile-globally-ignored-file-suffixes
      '(".jpg" ".png" ".gif" ".pdf"  ".aux" ".log" ".DS_Store" ".svn-base" "#" "~" ".aux~" ".bbl"))
(setq projectile-keymap-prefix (kbd "C-c p"))


;; We like shorter shorcuts
;; (global-set-key (kbd "C-^") 'enlarge-window)
;; (global-set-key (kbd "M-[") 'shrink-window-horizontally)
;; (global-set-key (kbd "M-]") 'enlarge-window-horizontally)
(add-hook 'python-mode-hook 'anaconda-mode)
(add-hook 'python-mode-hook 'blacken-mode)


(setq helm-ag-base-command "ag --nogroup --nocolor --vimgrep")
;; we want flyspell
(add-hook 'LaTeX-mode-hook (lambda ()
			     (flyspell-mode t)
			     (wc-mode t)
			     (auto-fill-mode t)))

;; bugfix for emacs
(with-eval-after-load 'python
  (defun python-shell-completion-native-try ()
    "Return non-nil if can trigger native completion."
    (let ((python-shell-completion-native-enable t)
          (python-shell-completion-native-output-timeout
           python-shell-completion-native-try-output-timeout))
      (python-shell-completion-native-get-completions
       (get-buffer-process (current-buffer))
       nil "_"))))

(defun run-latexmk ()
  (interactive)
  (let ((TeX-save-query nil)
        (TeX-process-asynchronous nil)
        (master-file (TeX-master-file)))
    (TeX-save-document "")
    (TeX-run-TeX "latexmk"
         (TeX-command-expand "latexmk -pdf %t" 'TeX-master-file)
         master-file)
    (if (plist-get TeX-error-report-switches (intern master-file))
        (TeX-next-error t)
      (minibuffer-message "latexmk done"))))

(custom-set-variables
 '(package-selected-packages
   (quote
    (blacken yaml-mode  helm-pydoc anaconda-mode helm-ag zenburn-theme helm-projectile helm))))
(custom-set-faces
 )

(put 'set-goal-column 'disabled nil)
