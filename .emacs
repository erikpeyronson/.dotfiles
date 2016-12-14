;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;AUTO GENERATED STUFF;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (labburn)))
 '(custom-safe-themes
   (quote
    ("4aee8551b53a43a883cb0b7f3255d6859d766b6c5e14bcb01bed572fcbef4328" "f57b3f1817b510d80a11d5ca859a0f09e6b0834ddf9a277b46c1e95fb40c6e58" "f69de3a2b9d54d49685e03debb4b102747491a624dfc172a94dee1455e69f01d" "2eccc1073f44cf1e0da01e20f3e7954cdd003ec18abfb24302f2b40cf6c1a78d" "877eeadc7d38ee4c4c232de6d707cc1d301bfb6c24844d2d6da62ccbce56cc3d" "7144ed173efe8b3f9306cc567eb231ebe6630dbeeaaf600b0c5e089317531f4c" default)))
 '(ecb-layout-name "left2")
 '(ecb-options-version "2.40")
 '(ecb-windows-width 0.15)
 '(inhibit-startup-screen t)
 '(package-selected-packages
   (quote
    (color-theme-sanityinc-solarized sublimity nurumacs labburn-theme ecb autopair))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;;;;;;;;;;;;;;;;
;;REPOSITORIES;;
;;;;;;;;;;;;;;;;

(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)
;;(add-to-list 'package-archives
;;             '("marmalade" . "http://marmalade-repo.org/packages/") t)
(package-initialize)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;list of packages to install;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defvar required-packages
  '(
    ecb
    autopair
    nurumacs
    smooth-scroll
    sublimity
    irony
    ;; sublimity-map
    ;; sublimity-attractive
    ;;sublimity-scroll
  ) "a list of packages to ensure are installed at launch.")

(require 'cl)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; method to check if all packages are installed;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;b
(defun packages-installed-p ()
  (loop for p in required-packages
        when (not (package-installed-p p)) do (return nil)
        finally (return t)))

; if not all packages are installed, check one by one and install the missing ones.
(unless (packages-installed-p)
  ; check for new packages (package versions)
  (message "%s" "Emacs is now refreshing its package database...")
  (package-refresh-contents)
  (message "%s" " done.")
  ; install the missing packages
  (dolist (p required-packages)
    (when (not (package-installed-p p))
      (package-install p))))

;;;;;;;;;;;;;;;;;
;;LOAD PACKAGES;;
;;;;;;;;;;;;;;;;;

(load "~/gitrepos/latextend-mode.el/latextend-mode.el")

(load "~/gitrepos/latextend-mode.el/latextend-insert.el")

;;ECB
;;(require 'ecb)
;;(ecb-activate)


;;Autopair
(require 'autopair)
;(autopair-global-mode)

;;nurumacs
;;(require 'nurumacs)

;;autostart minor modes
(global-linum-mode 1)
;(cua-mode)

;;Autofill for text mode
(add-hook 'text-mode-hook 'auto-fill-mode)
(setq-default fill-column 72)

;; diable toolbar by default
(tool-bar-mode -1)

;; disable menubar by default
(menu-bar-mode -1)

;;;;;;;;;;;;;;;;;;;;;;
;;;ARDUINO MODE;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;
(add-to-list 'load-path "~/.emacs.d/vendor/arduino-mode")
(setq auto-mode-alist (cons '("\\.\\(pde\\|ino\\)$" . arduino-mode) auto-mode-alist))
(autoload 'arduino-mode "arduino-mode" "Arduino editing mode." t)


;;;;;;;;;;;;;;;
;;keybindings;;
;;;;;;;;;;;;;;;

;; Insert some shift level 3 characters using C-M
(global-set-key (kbd "C-M-7") (lambda () (interactive) (insert "{")))
(global-set-key (kbd "C-M-8") (lambda () (interactive) (insert "[")))
(global-set-key (kbd "C-M-9") (lambda () (interactive) (insert "]")))
(global-set-key (kbd "C-M-0") (lambda () (interactive) (insert "}")))
(global-set-key (kbd "C-M-+") (lambda () (interactive) (insert "\\")))

;;Set backspace to ctrl+h
(global-set-key [(control ?h)] 'delete-backward-char)
(global-set-key (kbd "C-M-h") 'backward-kill-word)
;;C-X C-m compile
(global-set-key "\C-x\C-m" 'compile)

;; M-c M-x uncomment region
(global-set-key "\C-c\M-c" 'uncomment-region)

;;Compile command
(setq compile-command "g++ -std=c++17 -pedantic -Wall -Wextra -o")

;;C-x C-b used for buffer selection
(global-set-key (kbd "C-x C-b") 'bs-show)

;;ECB KEYBINDINGS
(global-set-key (kbd "<M-up>") 'ecb-goto-window-directories)
(global-set-key (kbd "<M-left>") 'ecb-goto-window-sources)
(global-set-key (kbd "<M-down>") 'ecb-goto-window-history)
(global-set-key (kbd "<M-down-down>") 'ecb-goto-window-methods)
(global-set-key (kbd "<M-right>") 'ecb-goto-window-edit-last)

;;indent using spaces instead of tabs
(setq-default indent-tabs-mode nil)

;;;;;;;;;;;;;;;;;;;;;;;
;;Major mode file extensions;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.tcc\\'" . c++-mode))

;;;;;;;;;;;;;;;;
;;;minor modes;;
;;;;;;;;;;;;;;;;

;; smooth scroll mode
(require 'smooth-scroll)
(smooth-scroll-mode 1);

;; Irony autocomplete
(add-hook 'c++-mode-hook 'irony-mode)
(add-hook 'c-mode-hook 'irony-mode)
(add-hook 'objc-mode-hook 'irony-mode)

;; replace the `completion-at-point' and `complete-symbol' bindings in
;; irony-mode's buffers by irony-mode's function
(defun my-irony-mode-hook ()
  (define-key irony-mode-map [remap completion-at-point]
    'irony-completion-at-point-async)
  (define-key irony-mode-map [remap complete-symbol]
    'irony-completion-at-point-async))
(add-hook 'irony-mode-hook 'my-irony-mode-hook)
(add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)


;; Sublimity
(add-to-list 'load-path "/path/to/.emacs.d/sublimity/")
(require 'sublimity)
(require 'sublimity-scroll)
(require 'sublimity-map)
(require 'sublimity-attractive)
;;(sublimity-mode 1)
;; (setq sublimity-attractive-centering-width nil)
;; (setq sublimity-map-size 21)
;; (sublimity-attractive-hide-bars)
;; (sublimity-attractive-hide-vertical-border)

;; color
(load-theme 'labburn t)


