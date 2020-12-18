;; =====================================================================
;;                                   _       _ _         _
;;    ___ _ __ ___   __ _  ___ ___  (_)_ __ (_) |_   ___| |
;;   / _ \ '_ ` _ \ / _` |/ __/ __| | | '_ \| | __| / _ \ |
;;  |  __/ | | | | | (_| | (__\__ \ | | | | | | |_ |  __/ |
;;   \___|_| |_| |_|\__,_|\___|___/ |_|_| |_|_|\__(_)___|_|
;;
;; =====================================================================

;; Basic settings
(setq inhibit-startup-message t)
;;(setq initial-scratch-message "")
(fset 'yes-or-no-p 'y-or-n-p)
;;(global-hl-line-mode)
(setq ring-bell-function 'ignore)    ; disable visual and audio bell
(scroll-bar-mode 0)                 ; Disable scrollbar
(tooltip-mode 0)                  ; Disable tooltips
(tool-bar-mode 0)                   ; Disable toolbar
(menu-bar-mode 0)                   ; Disable menubar
(show-paren-mode 1)                  ; Highlight matching parenthesis

(column-number-mode t) ; Display column numbers

(global-display-line-numbers-mode t) ; Display line numbers
;; Disable line numbers for some modes
(dolist (mode '(org-mode-hook
                term-mode-hook
                shell-mode-hook
                eshell-mode-hook
	        	helpful-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

;; Set font (height is 1/10 pt)
(defvar jake/default-font-size 12)
(set-face-attribute 'default nil :font "Inconsolata" :height (* jake/default-font-size 10))

(set-face-attribute 'fixed-pitch nil :font "Inconsolata" :height (* jake/default-font-size 10))

(set-face-attribute 'variable-pitch nil :font "Cantarell" :height 120 :weight 'regular)

;; Make escape quit prompts
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

;; set colorscheme
;(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
;(load-theme 'atom-one-dark t)

;; save autosave and backup files in /tmp/
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

;; Automatically follow symlinks
(setq vc-follow-symlinks t)

;; remove trailing whitespace on save
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; ======================================================================
;; Packages

(require 'package)

(setq package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
			 ("melpa" . "https://melpa.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")))

(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

;; Ensure use-package is installed
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

(use-package which-key
  :diminish which-key-mode
  :config
  (which-key-mode)
  (setq which-key-idle-delay 1))

(use-package general
  :after which-key
  :config
  (general-override-mode 1)

  (general-create-definer jake/leader-key
    :keymaps '(normal visual insert motion emacs)
    :prefix "SPC" ;; in normal mode
    :global-prefix "C-SPC") ;; in any mode

  (jake/leader-key
   ""   nil
   "c"  (general-simulate-key "C-c" :which-key "user")
   "h"  (general-simulate-key "C-h" :which-key "help")
   "u"  (general-simulate-key "C-u" :which-key "C-u")
   "x"  (general-simulate-key "C-x" :which-key "C-x")

   ;; Package manager
   "lp" 'list-packages

   ;; File ops
   "f"  '(:ignore t :which-key "files")
   "ff" 'counsel-find-file

   ;; toggles
   "t"  '(:ignore t :which-key "toggles")
   "tt" '(counsel-load-theme :which-key "choose theme")

   ;; Quit ops
   "q"  '(:ignore t :which-key "quit emacs")
   "qq" 'kill-emacs
   "qz" 'delete-frame

   ;; Buffer ops
   "b"  '(:ignore t :which-key "buffer")
   "bb" 'switch-to-buffer
   "bd" 'kill-this-buffer
   "bq" 'kill-buffer-and-window
   "b." 'next-buffer
   "b," 'previous-buffer

   ;; Window ops
   "w"  '(:ignore t :which-key "window")
   "wm" 'maximize-window
   "ws" 'split-window-horizontally
   "wv" 'split-window-vertically
   "ww" 'other-window
   "wc" 'delete-window
   "wo" 'delete-other-windows
   )
  )

;;(use-package hydra)
;;(defhydra hydra-text-scale (:timeout 4)
;;  "scale text"
;;  ("j" text-scale-increase "in")
;;("k" text-scale-decrease "out")
;; ("f" nil "finished" :exit t))
;;(jake/leader-key
;;  "ts" '(hydra-text-scale/body :which-key "scale text"))

(use-package evil
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  (setq evil-want-C-u-scroll t)
  (setq evil-want-C-i-jump nil)
  :config
  (evil-mode 1)
  (define-key evil-insert-state-map (kbd "C-g") 'evil-normal-state)
  (evil-global-set-key 'motion "j" 'evil-next-visual-line)
  (evil-global-set-key 'motion "k" 'evil-previous-visual-line)
  (evil-set-initial-state 'messages-buffer-mode 'normal)
  (evil-set-initial-state 'dashboard-mode 'normal))

(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))

(use-package ivy
  :diminish
  :general
  ("C-c C-r" 'ivy-resume)
  ("C-x B" 'ivy-switch-buffer-other-window)
  :bind (
	 :map ivy-minibuffer-map
	 ("TAB" . ivy-alt-done)
	 ("C-l" . ivy-alt-done)
	 ("C-j" . ivy-next-line)
	 ("C-k" . ivy-previous-line)
	 :map ivy-switch-buffer-map
	 ("C-l" . ivy-done)
	 ("C-k" . ivy-previous-line)
	 ("C-d" . ivy-switch-buffer-kill)
	 :map ivy-reverse-i-search-map
	 ("C-k" . ivy-previous-line)
	 ("C-d" . ivy-reverse-i-search-kill))
  :custom
  (ivy-count-format "(%d/%d) ")
  (ivy-use-virtual-buffers t)
  :config
  (ivy-mode 1))

(use-package ivy-rich
  :after ivy
  :init (ivy-rich-mode 1))

(use-package counsel
  :after ivy
  :config (counsel-mode 1))

(use-package swiper
  :after ivy
  :general
  ("C-s" 'swiper))

(use-package helpful
  :custom
  (counsel-describe-function-function #'helpful-callable)
  (counsel-describe-variable-function #'helpful-variable)
  :bind
  ([remap describe-function] . counsel-describe-function)
  ([remap describe-command] . helpful-command)
  ([remap describe-variable] . counsel-describe-variable)
  ([remap describe-key] . helpful-key))

(use-package flycheck
  :defer 2
  :diminish
  :init (global-flycheck-mode)
  :custom
  (flycheck-display-errors-delay .3))

(use-package doom-themes
  :config (load-theme 'doom-one t))

(use-package doom-modeline
  :defer 0.1
  :config (doom-modeline-mode))

(use-package all-the-icons
  :if (display-graphic-p)
  :config (unless (find-font (font-spec :name "all-the-icons"))
	    (all-the-icons-install-fonts t)))

(use-package company
  :config
  (global-company-mode t))

(defun jake/org-font-setup ()
  ;; Replace list hyphen with dot
  (font-lock-add-keywords 'org-mode
                          '(("^ *\\([-]\\) "
                             (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "•"))))))

  ;; Set faces for heading levels
  (dolist (face '((org-level-1 . 1.2)
                  (org-level-2 . 1.1)
                  (org-level-3 . 1.05)
                  (org-level-4 . 1.0)
                  (org-level-5 . 1.1)
                  (org-level-6 . 1.1)
                  (org-level-7 . 1.1)
                  (org-level-8 . 1.1)))
    (set-face-attribute (car face) nil :font "Cantarell" :weight 'regular :height (cdr face)))

  ;; Ensure that anything that should be fixed-pitch in Org files appears that way
  (set-face-attribute 'org-block nil :foreground nil :inherit 'fixed-pitch)
  (set-face-attribute 'org-code nil   :inherit '(shadow fixed-pitch))
  (set-face-attribute 'org-table nil   :inherit '(shadow fixed-pitch))
  (set-face-attribute 'org-verbatim nil :inherit '(shadow fixed-pitch))
  (set-face-attribute 'org-special-keyword nil :inherit '(font-lock-comment-face fixed-pitch))
  (set-face-attribute 'org-meta-line nil :inherit '(font-lock-comment-face fixed-pitch))
  (set-face-attribute 'org-checkbox nil :inherit 'fixed-pitch))

(defun jake/org-mode-visual-fill ()
  (setq visual-fill-column-width 100
	visual-fill-colum-center-text t)
  (visual-fill-column-mode 1))

(use-package visual-fill-column
  :hook (org-mode . jake/org-mode-visual-fill))



(defun jake/org-mode-setup ()
  (org-indent-mode)
  (variable-pitch-mode 1)
  (visual-line-mode 1))

(use-package org
  :hook (org-mode . jake/org-mode-setup)
  :config
  (setq org-ellipsis " ▾"
	org-hide-emphasis-markers t))

(use-package org-bullets
  :after org
  :hook (org-mode . org-bullets-mode)
  :custom
  (org-bullets-bullet-list '("◉" "○" "●" "○" "●" "○" "●")))


(require 'org-tempo) ;; activate with `<py` then tab

(add-to-list 'org-structure-template-alist '("sh" . "src shell"))
(add-to-list 'org-structure-template-alist '("el" . "src emacs-lisp"))
(add-to-list 'org-structure-template-alist '("py" . "src python"))

;; ======================================================================
;; Auto Generated Config

(setq custom-file "~/.emacs.d/custom.el")
(load custom-file :noerror)
