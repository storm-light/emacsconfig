;; Set up package.el to work with MELPA
(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives		; even though elpa gnu packages is part of this list, it is not used
	     '("melpa" . "https://melpa.org/packages/"))
(package-initialize)
(package-refresh-contents)
;; use-package is built-in to emacs 27 so there's no need to require it

;; remove menu bar up top
(menu-bar-mode -1)

;; enable line number node (global minor mode)
(line-number-mode 1)

;; evil-mode
(use-package evil
  :ensure t
  :config (evil-mode))

;; doom modeline
(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1))

(use-package ivy
  :ensure t
  :init (ivy-mode 1))

(define-key ivy-minibuffer-map (kbd "M-j") 'next-line) ;allows easier movement within minibuffer when using ivy or swiper
(define-key ivy-minibuffer-map (kbd "M-k") 'previous-line)

(use-package which-key			;identifies commands corresponding to each completion of the prefix in the minibuffer
  :ensure t
  :init (which-key-mode))

(use-package general
  :ensure t)

;; (general-define-key			;investigate if ESC remains a prefix key in other contexts
;;  "ESC" 'keyboard-escape-quit
;;  "<escape>" 'keyboard-escape-quit)

(evil-define-key nil evil-normal-state-map "m" nil) ; double check this line for clarity, otherwise m is nonprefix key
(general-create-definer m-leader-def
  :prefix "m") 

(m-leader-def
 :keymaps 'normal
 "m" 'save-buffer
 "c" 'comment-dwim)
 
(general-create-definer f-leader-def
  :prefix "f") ;; need to unset f key in dired mode (evil uses it for something else)

(f-leader-def
 :keymaps 'normal    ; do ":keymaps 'normal' or if there's a specific mode-map, do ":states 'normal\n :keymaps '[whatever]-mode-map'"
 "f" 'find-file
 "d" 'dired
 "j" 'swiper)
		       
(general-create-definer g-leader-def
  :prefix "g") 

(g-leader-def
 :keymaps 'normal    ; do ":keymaps 'normal' or if there's a specific mode-map, do ":states 'normal\n :keymaps '[whatever]-mode-map'"
 "d" 'dired-jump)

;; (general-define-key
;;  :prefix "g"
;;  :states 'normal
;;  :keymaps 'override
;;  "d" 'dired
;;  )

;; (defun say-hello()
;;   (interactive)
;;   (message "HELLO WORLD")
;;   )

;; (global-set-key (kbd "<f6>") 'say-hello)

;; (defun my/test()
;;   (interactive "p")
;;   )

(defun my/basic-comment()
  (interactive)
  (save-excursion
    (beginning-of-line 1)
    (insert ";;")
    )
  )

(define-key emacs-lisp-mode-map (kbd "<f7>") 'my/basic-comment)
