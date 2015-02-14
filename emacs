(add-to-list 'load-path "~/.emacs.d/evil-config/")

(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("org" . "http://orgmode.org/elpa/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")
                         ("melpa" . "http://melpa.milkbox.net/packages/")))

(package-initialize)

(defun require-package (package)
 (setq-default highlight-tabs t)
 "Install given PACKAGE."
 (unless (package-installed-p package)
  (unless (assoc package package-archive-contents)
   (package-refresh-contents))
  (package-install package)))

(require-package 'evil)
(require-package 'evil-leader)
(require-package 'evil-tabs)
(require-package 'paredit)
(require-package 'evil-paredit)
(require-package 'helm)
(require-package 'powerline-evil)
(require-package 'rainbow-delimiters)
(require-package 'clojure-mode)
(require-package 'color-theme-approximate)
(require-package 'ruby-mode)
(require-package 'autopair)
(require-package 'gruvbox-theme)
(require-package 'evil-nerd-commenter)
(require-package 'projectile)
(require-package 'helm-projectile)
(require-package 'helm-ag)
(require-package 'web-mode)
(require-package 'git-gutter+)
(require-package 'fringe-helper)
(require-package 'git-gutter-fringe+)

(require 'evil)
(require 'evil-leader)
(require 'evil-tabs)
(evil-mode 1)
(global-evil-tabs-mode t)

(helm-mode 1)

(setq evil-emacs-state-cursor '("red" box))
(setq evil-normal-state-cursor '("green" box))
(setq evil-visual-state-cursor '("orange" box))
(setq evil-insert-state-cursor '("red" bar))
(setq evil-replace-state-cursor '("red" bar))
(setq evil-operator-state-cursor '("red" hollow))

(global-evil-leader-mode)
(evil-leader/set-leader ",")
(setq evil-leader/in-all-states 1)

; (require 'evil-search-highlight-persist)
; (global-evil-search-highlight-persist t)

(evil-leader/set-key " " 'evil-search-highlight-persist-remove-all)

(define-key evil-normal-state-map " " 'helm-mini)

(require 'powerline)
(powerline-evil-vim-color-theme)
(display-time-mode t)

(custom-set-variables
 '(initial-frame-alist (quote ((fullscreen . maximized))))) ;; start maximized

; C-c as general purpose escape key sequence.
;;
(defun my-esc (prompt)
"Functionality for escaping generally.  Includes exiting Evil insert state and C-g binding. "
  (cond
  ;; If we're in one of the Evil states that defines [escape] key, return [escape] so as
  ;; Key Lookup will use it.
  ((or (evil-insert-state-p) (evil-normal-state-p) (evil-replace-state-p) (evil-visual-state-p)) [escape])
  ;; This is the best way I could infer for now to have C-c work during evil-read-key.
  ;; Note: As long as I return [escape] in normal-state, I don't need this.
  ;;((eq overriding-terminal-local-map evil-read-key-map) (keyboard-quit) (kbd ""))
  (t (kbd "C-g"))))
(define-key key-translation-map (kbd "C-c") 'my-esc)
;; Works around the fact that Evil uses read-event directly when in operator state, which
;; doesn't use the key-translation-map.
(define-key evil-operator-state-map (kbd "C-c") 'keyboard-quit)

;; Not sure what behavior this changes, but might as well set it, seeing the Elisp manual's
;; documentation of it.
;;(set-quit-char (kbd "C-c"))

(load-theme 'gruvbox t)

(color-theme-approximate-on)

(setq inhibit-startup-message t)
(tool-bar-mode -1)
(menu-bar-mode -99)
(scroll-bar-mode -1)

(require 'autopair)
(add-hook 'ruby-mode 'autopair-mode)

(show-paren-mode t)

(require 'rainbow-delimiters)
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)
(add-hook 'prog-mode-hook #'linum-mode)

(setq save-place-file "~/.emacs.d/saveplace")
(setq-default save-place t)
(require 'saveplace)

(add-hook 'emacs-lisp-mode-hook 'evil-paredit-mode)

(defun set-lein-repl ()
  (setq inferior-lisp-program "lein repl"))
(add-hook 'clojure-mode 'set-lein-repl)

(setq inferior-lisp-program "lein repl")

; Don't generate backups
(setq make-backup-files nil)

(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))

(require 'git-gutter+)
(global-git-gutter+-mode t)
(require 'git-gutter-fringe+)

(require 'evil-dvp)
