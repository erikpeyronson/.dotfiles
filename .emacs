;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;AUTO GENERATED STUFF;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (tango-dark)))
 '(custom-safe-themes
   (quote
    ("877eeadc7d38ee4c4c232de6d707cc1d301bfb6c24844d2d6da62ccbce56cc3d" "7144ed173efe8b3f9306cc567eb231ebe6630dbeeaaf600b0c5e089317531f4c" default)))
 '(ecb-layout-name "left2")
 '(ecb-options-version "2.40")
 '(ecb-windows-width 0.15))
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
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/") t)
(package-initialize)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;list of packages to install;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defvar required-packages
  '(
    ecb
    autopair
    nurumacs
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

;;ECB
;;(require 'ecb)
;;(ecb-activate)


;;Autopair
(require 'autopair)
;(autopair-global-mode)

;;nurumacs
(require 'nurumacs)

;;autostart minor modes
(global-linum-mode 1)
;(cua-mode)

;;Autofill for text mode
(add-hook 'text-mode-hook 'auto-fill-mode)

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
;;C-X C-m compile
(global-set-key "\C-x\C-m" 'compile)

;;Compile comman
(setq compile-command "g++ -std=c++17 -pedantic -Wall -Wextra -o")

;;C-x C-b used for buffer selection
(global-set-key (kbd "C-x C-b") 'bs-show)

;;ECB KEYBINDINGS
(global-set-key (kbd "<M-up>") 'ecb-goto-window-directories)
(global-set-key (kbd "<M-left>") 'ecb-goto-window-sources)
(global-set-key (kbd "<M-down>") 'ecb-goto-window-history)
(global-set-key (kbd "<M-down-down>") 'ecb-goto-window-methods)
(global-set-key (kbd "<M-right>") 'ecb-goto-window-edit-last)


(put 'set-goal-column 'disabled nil)







