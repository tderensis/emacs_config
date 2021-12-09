(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(add-to-list 'package-archives '("elpa"  . "https://elpa.gnu.org/packages/"))
(package-initialize)

; Make sure use-package is installed before everything
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(require 'use-package)

(use-package zenburn-theme
  :ensure t)
(load-theme 'zenburn t)

(use-package rtags
  :ensure t)

(use-package helm-rtags
  :ensure t)

(use-package company-rtags
  :ensure t)

(use-package company
  :ensure t
  :init (add-hook 'after-init-hook 'global-company-mode)
  :bind ("C-;" . company-complete-common)
  :config
  (setq company-dabbrev-downcase 0)
  (setq company-idle-delay 1)
  (setq company-minimum-prefix-length 3)
  (setq company-backends '((company-rtags))))

; Save backups to a temporary location intead of in-place
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

; Set up tramp
(require 'tramp)
(setq tramp-default-method "plink")

;; Set up tab mode
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq c-default-style "linux")
(setq-default c-basic-offset 4)

(defun my-c++-mode-hook ()
  (c-set-offset 'innamespace [0])
  )

(add-hook 'c++-mode-hook 'my-c++-mode-hook)

(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(global-linum-mode 1) ; Enable line numbers
(setq column-number-mode t) ; Enable column numbers

; Delay updates to give Emacs a chance for other things
(setq linum-delay t)
; scrolling to always be a line at a time
(setq scroll-conservatively 10000)

; Enables highlight-parentheses-mode on all buffers:
(show-paren-mode 1)
(desktop-save-mode 1)

; Show trailing whitespace
(setq-default show-trailing-whitespace t)
(setq whitespace-line-column 80)
(setq whitespace-style '(face lines-tail))
(add-hook 'prog-mode-hook 'whitespace-mode)

; terminal specific options
(defun my-inhibit-global-linum-mode ()
  "Counter-act `global-linum-mode'."
  (add-hook 'after-change-major-mode-hook
            (lambda () (linum-mode 0))
            :append :local))

(defun my-inhibit-show-trailing-whitespace ()
  "Counter-act `show-trailing-whitespace'."
  (add-hook 'after-change-major-mode-hook
            (lambda () (setq show-trailing-whitespace nil))
            :append :local))

(add-hook 'term-mode-hook 'my-inhibit-global-linum-mode)
(add-hook 'term-mode-hook 'my-inhibit-show-trailing-whitespace)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("3b8284e207ff93dfc5e5ada8b7b00a3305351a3fb222782d8033a400a48eca48" default))
 '(package-selected-packages
   '(helm-gtags ggtags company-gtags company-mode zenburn-theme use-package)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(put 'upcase-region 'disabled nil)
