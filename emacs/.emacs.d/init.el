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
(setq ring-bell-function 'ignore)   ; disable visual and audio bell
(scroll-bar-mode 0)   ; Disable scrollbar
(tooltip-mode 0)       ; Disable tooltips
(tool-bar-mode 0)      ; Disable toolbar
(menu-bar-mode 0)      ; Disable menubar
(show-paren-mode 1)     ; Highlight matching parenthesis

(column-number-mode)                ; Display column numbers
(global-display-line-numbers-mode t)  ; Display line numbers

;; Disable line numbers for some modes
(dolist (mode '(org-mode-hook
                term-mode-hook
                shell-mode-hook
                eshell-mode-hook))
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
;; General Package settings
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

;; First time you load this config on a new machine run
;; M-x all-the-icons-install-fonts to get the fonts
(use-package all-the-icons)

(use-package doom-modeline
    :init (doom-modeline-mode 1))

(use-package doom-themes
    :init (load-theme 'doom-one t))

(use-package ivy
  :diminish
  :bind (("C-s" . swiper)
         :map ivy-minibuffer-map
         ("TAB" . ivy-alt-done)
         ("C-l" . ivy-alt-done)
         ("C-j" . ivy-next-line)
         ("C-k" . ivy-previous-line)
         :map ivy-switch-buffer-map
         ("C-k" . ivy-previous-line)
         ("C-l" . ivy-done)
         ("C-d" . ivy-switch-buffer-kill)
         :map ivy-reverse-i-search-map
         ("C-k" . ivy-previous-line)
         ("C-d" . ivy-reverse-i-search-kill))
  :config
  (ivy-mode 1))

(use-package ivy-rich
  :init (ivy-rich-mode 1))

(use-package counsel
  :bind (("M-x" . counsel-M-x)
	 ("C-x b" . counsel-ibuffer)
	 ("C-x C-f" . counsel-find-file)
	 :map minibuffer-local-map
	 ("C-r" . 'counsel-minibuffer-history)))

(use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 1))

(use-package helpful
  :custom
  (counsel-describe-function-function #'helpful-callable)
  (counsel-describe-variable-function #'helpful-variable)
  :bind
  ([remap describe-function] . counsel-describe-function)
  ([remap describe-command] . helpful-command)
  ([remap describe-variable] . counsel-describe-variable)
  ([remap describe-key] . helpful-key))

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

(use-package general
  :config
  (general-create-definer jake/leader-keys
			  :keymaps '(normal insert visual emacs)
			  :prefix "SPC" ;; in normal mode
			  :global-prefix "C-SPC") ;; in any mode
  (jake/leader-keys
   "t" '(:ignore t :which-key "toggles")
   "tt" '(counsel-load-theme :which-key "choose theme")
   "." '(counsel-find-file :which-key "find file")))

(use-package hydra)
(defhydra hydra-text-scale (:timeout 5)
  "scale text"
  ("j" text-scale-increase "in")
  ("k" text-scale-decrease "out")
  ("f" nil "finished" :exit t))
(jake/leader-keys
  "ts" '(hydra-text-scale/body :which-key "scale text"))

;; ======================================================================
;; Webdev package settings


;; ======================================================================
;; Move custome-set-variables/faces to a different file
(setq custom-file "~/.emacs.d/custom.el")
(load custom-file :noerror)
