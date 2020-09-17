(require 'package)

;; Package manager repos
(add-to-list 'package-archives '("gnu" . "https://elpa.gnu.org/packages/"))
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/"))
(setq package-enable-at-startup nil)
(package-initialize)

;; Ensure use-package is installed
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(eval-when-compile
  (require 'use-package))

;; enable evil
(use-package evil
  :ensure t
  :init
  (evil-mode 1))

;; Configure helm
(use-package helm
  :ensure t)
(require 'helm-config)

(setq helm-split-window-inside-p t
      helm-move-to-line-cycle-in-source t)
(helm-mode 1)
(global-set-key (kbd "C-x b") 'helm-buffers-list)
(define-key evil-ex-map "b" 'helm-buffers-list)
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "M-c") 'helm-calcul-expression)
(global-set-key (kbd "M-y") 'helm-show-kill-ring)
(global-set-key (kbd "C-s") 'helm-occur)
(global-set-key (kbd "C-x r b") 'helm-bookmarks)
(global-set-key (kbd "C-x C-f") 'helm-find-files)

;; flycheck
(use-package flycheck
    :ensure t
    :init (global-flycheck-mode))

;; Configure elpy
;; installed python packages:
;; ipython, black, jedi, flake8,
(use-package blacken
    :ensure t)

(use-package elpy
    :ensure t
    :init (elpy-enable)
    :config
    (setq python-shell-interpreter "ipython"
	  python-shell-interpreter-args "-i --simple-prompt"))

;; Theme
(menu-bar-mode 0)
(tool-bar-mode 0)
(global-display-line-numbers-mode)
(setq ring-bell-function 'ignore) ;; disable bell
(setq inhibit-startup-screen t)

;; set colorscheme
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
(load-theme 'atom-one-dark t)
;; Start emacs window maximized
(add-to-list 'default-frame-alist '(fullscreen . maximized))

(setq auto-save-default nil)
(setq make-backup-files nil)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages '(helm evil use-package)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
