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
    zenburn-theme
    yasnippet
    visible-mark
    tabbar
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
(require 'visible-mark)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                           functions                              ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Function used for toggeling comments
(defun comment-or-uncomment-region-or-line ()
    "Comments or uncomments the region or the current line if there's no active region."
    (interactive)
    (let (beg end)
        (if (region-active-p)
            (setq beg (region-beginning) end (region-end))
            (setq beg (line-beginning-position) end (line-end-position)))
        (comment-or-uncomment-region beg end)))


;; Minor mode to overwrite mode specific key-bindings
(defvar my-keys-minor-mode-map
  (let ((map (make-sparse-keymap)))
    (define-key map (kbd "C-c C-c") 'comment-or-uncomment-region-or-line)
    (define-key map (kbd "C-x C-<left>") 'tabbar-forward-group)
    (define-key map (kbd "C-x M-<right>") 'tabbar-backward-group)
    map)
  "my-keys-minor-mode keymap.")

(define-minor-mode my-keys-minor-mode
  "A minor mode so that my key settings override annoying major modes."
  :init-value t
  :lighter " my-keys")


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
(my-keys-minor-mode 1)
(global-visible-mark-mode 1)
(ido-mode 1)
(tabbar-mode 1)


;; Minor mode hooks
(add-hook 'text-mode-hook 'auto-fill-mode)
(add-hook 'latex-mode-hook 'latextend-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                           Keybindings                            ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; GLOBAL KEYBINDINGS
;; Use buffer selection instead of bs show for C-x C-v
(global-set-key (kbd "C-x C-b") 'bs-show)

;; Use pseudo vim keybind ö and j for switching ta
(global-set-key (kbd "C-x C-ö") 'tabbar-forward-tab)
(global-set-key (kbd "C-x C-j") 'tabbar-backward-tab)


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


(global-set-key (kbd "C-c c") 'comment-or-uncomment-region-or-line)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                             General                              ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Load color theme
(load-theme 'zenburn t)

;; ORG MODE
(setq org-log-done 'time)

;; Visible-mark
(setq visible-mark-max 10)

;; Enable windowmove keybindings S-<arrow> to move between windows
(windmove-default-keybindings)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("2bed8550c6f0a5ce635373176d5f0e079fb4fb5919005bfa743c71b5eed29d81" "ba9be9caf9aa91eb34cf11ad9e8c61e54db68d2d474f99a52ba7e87097fa27f5" "ac5584b12254623419499c3a7a5388031a29be85a15fdef9b94df2292d3e2cbb" "d606ac41cdd7054841941455c0151c54f8bff7e4e050255dbd4ae4d60ab640c1" "a0feb1322de9e26a4d209d1cfa236deaf64662bb604fa513cca6a057ddf0ef64" "ab04c00a7e48ad784b52f34aa6bfa1e80d0c3fcacc50e1189af3651013eb0d58" "04dd0236a367865e591927a3810f178e8d33c372ad5bfef48b5ce90d4b476481" "14f0fbf6f7851bfa60bf1f30347003e2348bf7a1005570fd758133c87dafe08f" "5cd0afd0ca01648e1fff95a7a7f8abec925bd654915153fb39ee8e72a8b56a1f" "f9574c9ede3f64d57b3aa9b9cef621d54e2e503f4d75d8613cbcc4ca1c962c21" default)))
 '(ecb-layout-window-sizes
   (quote
    (("left8"
      (ecb-directories-buffer-name 0.1308016877637131 . 0.30434782608695654)
      (ecb-sources-buffer-name 0.1308016877637131 . 0.2608695652173913)
      (ecb-methods-buffer-name 0.1308016877637131 . 0.2028985507246377)
      (ecb-history-buffer-name 0.1308016877637131 . 0.21739130434782608)))))
 '(ecb-options-version "2.50")
 '(ecb-source-path (quote (("/" "/"))))
 '(inhibit-startup-screen t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
