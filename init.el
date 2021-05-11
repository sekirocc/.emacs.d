;; load emacs 24's package system. Add MELPA repository.
(define-key special-event-map [config-changed-event] #'ignore)

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)
(add-to-list 'package-archives '("melpa-stable" . "http://melpa-stable.milkbox.net/packages/") t)
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)

;; (setq url-proxy-services
;;    '(("no_proxy" . "^\\(localhost\\|10\\..*\\|192\\.168\\..*\\)")
;;      ("http" . "192.168.31.60")
;;      ("https" . "192.168.31.60")))

(setq  x-meta-keysym 'super
       x-super-keysym 'meta)


(require 'expand-region)
(global-set-key (kbd "C-=") 'er/expand-region)


;; (setq evil-want-C-u-scroll t)
;; (require 'evil)
;; (evil-mode 1)



(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("bffa9739ce0752a37d9b1eee78fc00ba159748f50dc328af4be661484848e476" default))
 '(package-selected-packages
   '(expand-region easy-kill multiple-cursors powerline projectile evil-easymotion evil-collection evil helm-rg helm-ag use-package helm fzf neotree spacemacs-theme sublime-themes company lsp-mode golden-ratio-scroll-screen go-mode))
 '(spacemacs-theme-custom-colors '((bg1 . "#171421"))))
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
(load-theme 'spacemacs-dark t)



(global-whitespace-mode 1)
(setq whitespace-style '(face trailing tabs tab-mark))
(set-face-attribute 'whitespace-space nil :background nil :foreground "gray30")
(setq whitespace-display-mappings
        ;; all numbers are unicode codepoint in decimal. e.g. (insert-char 182 1)
        '(
          (space-mark 32 [183] [46]) ; SPACE 32 ? ?, 183 MIDDLE DOT ???, 46 FULL STOP ?.?
          (newline-mark 10 [182 10]) ; LINE FEED,
          (tab-mark 9 [707 9] [92 9]) ; tab
          ))


(global-set-key [f8] 'neotree-toggle)
(setq neo-theme (if (display-graphic-p) 'icons 'arrow))


(add-hook 'prog-mode-hook 'linum-mode)



(global-set-key (kbd "M-x") #'helm-M-x)
(global-set-key (kbd "C-x r b") #'helm-filtered-bookmarks)
(global-set-key (kbd "C-x C-f") #'helm-find-files)
(helm-mode 1)



(require 'golden-ratio-scroll-screen)
(global-set-key [remap scroll-down-command] 'golden-ratio-scroll-screen-down)
(global-set-key [remap scroll-up-command] 'golden-ratio-scroll-screen-up)



(defun move-and-recenter ()
  (interactive)
  (next-line)
  (recenter-top-bottom 0)
  )


(use-package lsp-mode
  :init
  (setq lsp-keymap-prefix "C-i"))



;; go-mode.el with lsp
(add-hook 'go-mode-hook 'lsp-deferred)

(require 'powerline)
(powerline-default-theme)



(projectile-mode 1)
(define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
;; make some use of the Super key
(define-key global-map [?\s-d] 'projectile-find-dir)
(define-key global-map [?\s-e] 'er/expand-region)
(define-key global-map [?\s-f] 'projectile-find-file)
(define-key global-map [?\s-g] 'projectile-grep)
(define-key global-map [?\s-j] 'prelude-top-join-line)
(define-key global-map [?\s-k] 'prelude-kill-whole-line)
(define-key global-map [?\s-l] 'goto-line)
(define-key global-map [?\s-m] 'magit-status)
(define-key global-map [?\s-o] 'prelude-open-line-above)
(define-key global-map [?\s-w] 'delete-frame)
(define-key global-map [?\s-x] 'exchange-point-and-mark)
(define-key global-map [?\s-p] 'projectile-switch-project)



(add-to-list 'default-frame-alist
             '(font . "Ubuntu Mono derivative Powerline-13.2"))



;;;_*======================================================================
;;;_* define a function to scroll with the cursor in place, moving the
;;;_* page instead
;; Navigation Functions
(defun scroll-down-in-place (n)
  (interactive "p")
  (previous-line n)
  (unless (eq (window-start) (point-min))
    (scroll-down n)))

(defun scroll-up-in-place (n)
  (interactive "p")
  (next-line n)
  (unless (eq (window-end) (point-max))
    (scroll-up n)))

(global-set-key "\M-n" 'scroll-up-in-place)
(global-set-key "\M-p" 'scroll-down-in-place)

;; (global-set-key (kbd "C-:") 'avy-goto-char)
(global-set-key (kbd "M-;") 'avy-goto-word-0)

(setq-default cursor-type 'bar) 
(set-cursor-color "#00ff00") 

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:background nil)))))


(require 'multiple-cursors)
(global-set-key (kbd "s-.") 'mc/mark-next-like-this)
(global-set-key (kbd "s-,") 'mc/mark-previous-like-this)
(global-set-key (kbd "s-/") 'mc/skip-to-next-like-this)
(global-set-key (kbd "C-c C-d") 'mc/mark-all-like-this)



