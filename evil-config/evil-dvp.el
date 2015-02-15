; dhtn remaps
(define-key evil-normal-state-map "d" 'evil-backward-char)
(define-key evil-normal-state-map "D" 'evil-delete-line)
(define-key evil-normal-state-map "h" 'evil-next-line)
(define-key evil-normal-state-map "t" 'evil-previous-line)
(define-key evil-normal-state-map "n" 'evil-forward-char)

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
(define-key evil-motion-state-map "j" 'evil-delete)

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
(evil-leader/set-key "-" 'helm-find-files)
(evil-leader/set-key "b" 'helm-buffers-list)

(require 'helm-ag)
(evil-leader/set-key "/" 'helm-ag)

(define-key evil-normal-state-map (kbd "C-h") 'evil-next-buffer)
(define-key evil-normal-state-map (kbd "C-t") 'evil-prev-buffer)

(evil-leader/set-key "S" 'paredit-splice-sexp)
(evil-leader/set-key "W" 'paredit-wrap-round)
(evil-leader/set-key ">" 'paredit-forward-slurp-sexp)
(evil-leader/set-key "<" 'paredit-forward-barf-sexp)

(define-key evil-window-map "-" 'split-window-vertically)
(define-key evil-window-map "\\" 'split-window-horizontally)

(define-key evil-normal-state-map "u" 'undo-tree-undo)
(define-key evil-normal-state-map "\C-r" 'undo-tree-redo)

(eval-after-load 'dired
  '(progn
     ;; use the standard Dired bindings as a base
     (evil-make-overriding-map dired-mode-map 'normal t)
     (evil-define-key 'normal dired-mode-map
       "d" 'evil-backward-char
       "h" 'evil-next-line
       "t" 'evil-previous-line
       "n" 'evil-forward-char
       "H" 'dired-goto-file
       "T" 'dired-do-kill-lines
              "r" 'dired-do-redisplay)))

(provide 'evil-dvp)
