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
(setq ring-bell-function 'ignore)    ; disable visual and audio bell
(scroll-bar-mode -1)                 ; Disable scrollbar
;;(tooltip-mode -1)                  ; Disable tooltips
(tool-bar-mode -1)                   ; Disable toolbar
(menu-bar-mode -1)                   ; Disable menubar
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

;; ======================================================================
;; Packages

(require 'package)

(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("elpa" . "https://elpa.gnu.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")))

(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

;; Ensure use-package is installed
(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

(use-package which-key
  :diminish which-key-mode
  :config
  (which-key-mode 1)
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
   "c"  (general-simulate-key "C-c" :which-key "foo")
   "h"  (general-simulate-key "C-h")
   "u"  (general-simulate-key "C-u")
   "x"  (general-simulate-key "C-x")

   ;; Package manager
   "lp" 'list-packages

   ;; File ops
   "f"  '(:ignore t :which-key "files")
   "ff" 'find-file

   ;; Quit ops
   "q"  '(:ignore t :which-key "quit emacs")
   "qq" 'kill-emacs
   "qz" 'delete-frame

   ;; Buffer ops
   "b"  '(:ignore t :which-key "buffer")
   "bb" 'mode-line-other-buffer
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
   "wd" 'delete-window
   
   )

  )

(use-package evil
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  (setq evil-want-C-u-scroll t)
  :config
  (evil-mode 1)
  (define-key evil-insert-state-map (kbd "C-g") 'evil-normal-state))
 


(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))

  
  

;; ======================================================================
;; Auto Generated Config

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages '(general evil-collection evil use-package)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
