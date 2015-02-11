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

(require 'evil)
(evil-mode 1)

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
(autopair-global-mode)
(show-paren-mode t)

(require 'rainbow-delimiters)
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)
(add-hook 'prog-mode-hook #'linum-mode)

(setq save-place-file "~/.emacs.d/saveplace")
(setq-default save-place t)
(require 'saveplace)

(add-hook 'emacs-lisp-mode-hook 'evil-paredit-mode)

; dhtn remaps
(define-key evil-normal-state-map "d" 'evil-backward-char)
(define-key evil-normal-state-map "D" 'evil-delete-line)
(define-key evil-normal-state-map "h" 'evil-next-line)
(define-key evil-normal-state-map "t" 'evil-previous-line)
(define-key evil-normal-state-map "d" 'evil-backward-char)

(define-key evil-motion-state-map "d" 'evil-backward-char)
(define-key evil-motion-state-map "h" 'evil-next-line)
(define-key evil-motion-state-map "t" 'evil-previous-line)
(define-key evil-motion-state-map "n" 'evil-forward-char)

(define-key evil-motion-state-map "k" 'evil-find-char-to)
(define-key evil-motion-state-map "K" 'evil-find-char-to-backward)

(define-key evil-window-map "d" 'evil-window-left)
(define-key evil-window-map "D" 'evil-window-move-far-left)
(define-key evil-window-map "h" 'evil-window-down)
(define-key evil-window-map "H" 'evil-window-move-very-bottom)
(define-key evil-window-map "t" 'evil-window-up)
(define-key evil-window-map "T" 'evil-window-move-very-top)
(define-key evil-window-map "n" 'evil-window-right)
(define-key evil-window-map "N" 'evil-window-move-far-right)

(define-key evil-normal-state-map "j" 'evil-delete)

(define-key evil-motion-state-map "l" 'evil-search-next)
(define-key evil-motion-state-map "L" 'evil-search-previous)

(define-key evil-motion-state-map ";" 'evil-ex)

(define-key evil-motion-state-map "_" 'evil-first-non-blank)
(define-key evil-motion-state-map "-" 'evil-end-of-line)

(global-set-key (kbd "C-q") 'execute-extended-command)

(evil-define-key 'normal evil-paredit-mode-map
  (kbd "j") 'evil-paredit-delete
  (kbd "d") 'evil-backward-char
  (kbd "c") 'evil-paredit-change
  (kbd "y") 'evil-paredit-yank
  (kbd "D") 'evil-paredit-delete-line
  (kbd "C") 'evil-paredit-change-line
  (kbd "S") 'evil-paredit-change-whole-line
  (kbd "Y") 'evil-paredit-yank-line
  (kbd "X") 'paredit-backward-delete
  (kbd "x") 'paredit-forward-delete)

(define-key evil-normal-state-map "gcc" 'evilnc-comment-or-uncomment-lines)

(projectile-global-mode)
(setq projectile-completion-system 'helm)
(helm-projectile-on)

(evil-leader/set-key "p" 'helm-projectile-find-file)
(evil-leader/set-key "-" 'dired)
(evil-leader/set-key "e" 'lisp-eval-defun)

(define-key evil-normal-state-map (kbd "C-h") 'evil-next-buffer)
(define-key evil-normal-state-map (kbd "C-t") 'evil-prev-buffer)

(define-key evil-window-map "-" 'split-window-vertically)
(define-key evil-window-map "\\" 'split-window-vertically)

(defun set-lein-repl ()
  (setq inferior-lisp-program "lein repl"))
(add-hook 'emacs-lisp-mode-hook 'set-lein-repl)
