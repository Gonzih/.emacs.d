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
(require-package 'helm)
(require-package 'powerline-evil)
(require-package 'rainbow-mode)
(require-package 'rainbow-delimiters)
(require-package 'clojure-mode)
(require-package 'color-theme-approximate)

(require 'evil)

(evil-mode 1)

(setq evil-emacs-state-cursor '("red" box))
(setq evil-normal-state-cursor '("green" box))
(setq evil-visual-state-cursor '("orange" box))
(setq evil-insert-state-cursor '("red" bar))
(setq evil-replace-state-cursor '("red" bar))
(setq evil-operator-state-cursor '("red" hollow))

(global-evil-leader-mode)
(evil-leader/set-leader " ")
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

; dhtn
(define-key evil-normal-state-map "d" 'evil-backward-char)
(define-key evil-normal-state-map "D" 'evil-delete-line)
(define-key evil-normal-state-map "h" 'evil-next-line)
(define-key evil-normal-state-map "t" 'evil-previous-line)
(define-key evil-normal-state-map "d" 'evil-backward-char)

(define-key evil-motion-state-map "d" 'evil-backward-char)
(define-key evil-motion-state-map "D" 'evil-window-top)
(define-key evil-motion-state-map "h" 'evil-next-line)
(define-key evil-motion-state-map "t" 'evil-previous-line)
(define-key evil-motion-state-map "n" 'evil-forward-char)


(define-key evil-normal-state-map "j" 'evil-delete)

(define-key evil-motion-state-map "l" 'evil-search-next)
(define-key evil-motion-state-map "L" 'evil-search-previous)

(define-key evil-motion-state-map ":" 'evil-ex)

(define-key evil-motion-state-map "_" 'evil-first-non-blank)
(define-key evil-motion-state-map "-" 'evil-end-of-line)

;; C-c as general purpose escape key sequence.
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

(load-theme 'misterioso t)

(color-theme-approximate-on)

(setq inhibit-startup-message t)
(tool-bar-mode -1)
(menu-bar-mode -99)
(scroll-bar-mode -1)
