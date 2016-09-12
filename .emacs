;;;;;;;;;;;;;;
;;REPOSITORIES
;;;;;;;;;;;;;;
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/") t)
(package-initialize)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;list of packages to install
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defvar required-packages
  '(
    ecb
    autopair
    nurumacs
  ) "a list of packages to ensure are installed at launch.")

(require 'cl)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; method to check if all packages are installed
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
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
;;;;;;;;;;;;;;;
;;LOAD PACKAGES
;;;;;;;;;;;;;;;

;;ECB
;(require 'ecb)
;(ecb-activate)
;;ECB KEYBINDINGS
(global-set-key (kbd "<M-left>") 'ecb-goto-window-sources)
(global-set-key (kbd "<M-right>") 'ecb-goto-window-edit1)

;;Autopair
(require 'autopair)
;(autopair-global-mode)

;;nurumacs
(require 'nurumacs)



;;autostart minor modes
(global-linum-mode 1)
(cua-mode)


;;Autofill for text mode
(add-hook 'text-mode-hook 'auto-fill-mode)

;;;;;;;;;;;;;;;;;;;;;;
;;;ARDUINO MODE;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;
(add-to-list 'load-path "~/.emacs.d/vendor/arduino-mode")
(setq auto-mode-alist (cons '("\\.\\(pde\\|ino\\)$" . arduino-mode) auto-mode-alist))
(autoload 'arduino-mode "arduino-mode" "Arduino editing mode." t)
;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;AUTO GENERATED STUFF;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ecb-options-version "2.40")
 '(inhibit-startup-screen t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;;keybindings

;;Set backspace to ctrl+h
(global-set-key [(control ?h)] 'delete-backward-char)

;;C-x C-m compile
(global-set-key "\C-x\C-m" 'compile)
;;default compile command
(setq compile-command "g++ -std=c++14 -Wall -o")

