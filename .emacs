;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;            Repositories and package initialization               ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Add melpa to repositories
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)
(package-initialize)

;; List of packages to install automatically at launch
(defvar required-packages
  '(
    ecb
    autopair
    smooth-scroll
    labburn-theme
    yasnippet
  ))

(require 'cl)

;; Check if packages are already installed
(defun packages-installed-p ()
  (loop for p in required-packages
        when (not (package-installed-p p)) do (return nil)
        finally (return t)))

;; if not all packages are installed, check one by one and install the
;; missing ones. 
(unless (packages-installed-p)
  ;; check for new packages (package versions)
  (message "%s" "Emacs is now refreshing its package database...")
  (package-refresh-contents)
  (message "%s" " done.")
  ;; install the missing packages
  (dolist (p required-packages)
    (when (not (package-installed-p p))
      (package-install p))))

;; Load individual files
(load "~/gitrepos/latextend-mode.el/latextend-mode.el")
(load "~/gitrepos/latextend-mode.el/latextend-resources.el")

;; Require packages
(require 'ecb)
(require 'yasnippet)
(require 'latextend-mode)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                             Modes                                ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Diable toolbar by default
(tool-bar-mode -1)

;; Disable menubar by default
(menu-bar-mode -1)

;; File extension major modes
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.tcc\\'" . c++-mode))

;; Global Mior Modes
(global-linum-mode 1)
(yas-global-mode 1)

;; Minor mode hooks
(add-hook 'text-mode-hook 'auto-fill-mode)
(add-hook 'latex-mode-hook 'latextend-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                           Keybindings                            ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; GLOBAL KEYBINDINGS

;; Insert some shift level 3 characters using C-M
(global-set-key (kbd "C-M-7") (lambda () (interactive) (insert "{")))
(global-set-key (kbd "C-M-8") (lambda () (interactive) (insert "[")))
(global-set-key (kbd "C-M-9") (lambda () (interactive) (insert "]")))
(global-set-key (kbd "C-M-0") (lambda () (interactive) (insert "}")))
(global-set-key (kbd "C-M-+") (lambda () (interactive) (insert "\\")))

;;Set delete-backward-char to ctrl+h
(global-set-key [(control ?h)] 'delete-backward-char)


;;ECB KEYBINDINGS
(global-set-key (kbd "<M-up>") 'ecb-goto-window-directories)
(global-set-key (kbd "<M-left>") 'ecb-goto-window-sources)
(global-set-key (kbd "<M-down>") 'ecb-goto-window-history)
(global-set-key (kbd "<M-down-down>") 'ecb-goto-window-methods)
(global-set-key (kbd "<M-right>") 'ecb-goto-window-edit-last)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                             General                              ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Load color theme
(load-theme 'labburn t)
