;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
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
    smooth-scroll
    zenburn-theme
    yasnippet
    ;; tabbar
    desktop+
    yaml-mode
    bash-completion
    auto-complete
    visible-mark
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


;; Require packages
(require 'ecb)
(require 'yasnippet)
;;(require 'visible-mark)

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

;; Activate modes with prefix C-c m
;; (progn
;;   (define-prefix-command 'my-mode-map)
;;   (define-key my-mode-map (kbd "v") 'visible-mark-mode)
;;   )
;; (global-set-key (kbd "C-c m"), my-mode-map)


;; Minor mode to overwrite mode specific key-bindings
(defvar my-keys-minor-mode-map
  (let ((map (make-sparse-keymap)))
    (define-key map (kbd "C-c C-c") 'comment-or-uncomment-region-or-line)
    ;; (define-key map (kbd "C-x C-<left>") 'tabbar-forward-group)
    ;; (define-key map (kbd "C-x C-<right>") 'tabbar-backward-group)
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
;; (menu-bar-mode -1)

;; File extension major modes
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.tcc\\'" . c++-mode))

;; Global Mior Modes
(global-linum-mode 1)
(yas-global-mode 1)
(my-keys-minor-mode 1)
(global-visible-mark-mode 1)
(ido-mode 1)
;; (tabbar-mode 1)

;; C/C++ settings
(setq c-default-style "bsd")
(setq c-basic-offset 2)
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode)) 

;; bash-autocomplete
;; (autoload 'bash-completion-dynamic-complete \"bash-completion\"
;;   \"BASH completion hook\")
;; (add-hook 'shell-dynamic-complete-functions
;; 	  'bash-completion-dynamic-complete)

(require 'bash-completion)
(bash-completion-setup)

;; Minor mode hooks
;;(add-hook 'text-mode-hook 'auto-fill-mode
;;(add-hook 'latex-mode-hook 'latextend-mode)

;;visible mark
(defface visible-mark-active ;; put this before (require 'visible-mark)
  '((((type tty) (class mono)))
    (t (:background "magenta"))) "")
(require 'visible-mark)
;; (global-visible-mark-mode 1)
;; (setq visible-mark-max 2)
(setq visible-mark-faces `(visible-mark-face1 visible-mark-face2))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                           Keybindings                            ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; GLOBAL KEYBINDINGS
;; Swap C-j and RET behavior
(global-set-key (kbd "C-j") 'newline-and-indent)
(global-set-key (kbd "RET") 'newline)
(global-set-key (kbd "C-c C-d") 'desktop+-load)

;; Use ibuffer instead of bs show for C-x C-b
(global-set-key (kbd "C-x C-b") 'ibuffer-other-window)

;; compile bound to C-c m
(global-set-key (kbd "C-c RET") 'compile)

;; Use pseudo vim keybind ö and j for switching ta
;; (global-set-key (kbd "C-x C-ö") 'tabbar-forward-tab)
;; (global-set-key (kbd "C-x C-j") 'tabbar-backward-tab)


;; Insert some shift level 3 characters using C-M
(global-set-key (kbd "C-M-7") (lambda () (interactive) (insert "{")))
(global-set-key (kbd "C-M-8") (lambda () (interactive) (insert "[")))
(global-set-key (kbd "C-M-9") (lambda () (interactive) (insert "]")))
(global-set-key (kbd "C-M-0") (lambda () (interactive) (insert "}")))
(global-set-key (kbd "C-M-+") (lambda () (interactive) (insert "\\")))

;;Fix emacs bugged ctrl+h bindings
(global-set-key (kbd "C-h") 'delete-backward-char)
(global-set-key (kbd "M-h") 'backward-kill-word)
(global-set-key (kbd "M-?") 'mark-paragraph)
(global-set-key (kbd "C-?") 'help-command)

(progn
  ;; define a prefix keymap
  (define-prefix-command 'my-mode-map)
  (define-key my-mode-map (kbd "v") 'visible-mark-mode)
  (define-key my-mode-map (kbd "<f7>") 'linum-mode)
  (define-key my-mode-map (kbd "<f8>") 'whitespace-mode)
  )

(global-set-key (kbd "C-c m") 'my-mode-map)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                             ECB                                  ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq ecb-layout-name "left8")
(setq ecb-compile-window-height 6)

;;ECB KEYBINDINGS
(global-set-key (kbd "<M-up>") 'ecb-goto-window-directories)
(global-set-key (kbd "<M-left>") 'ecb-goto-window-sources)
(global-set-key (kbd "<M-down>") 'ecb-goto-window-history)
(global-set-key (kbd "<M-down-down>") 'ecb-goto-window-methods)
(global-set-key (kbd "<M-right>") 'ecb-goto-window-edit-last)
(ecb-activate)



;; etc
(global-set-key (kbd "C-c c") 'comment-or-uncomment-region-or-line)
(global-set-key "\C-x\C-m" 'compile)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                             General                              ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Load color theme
(load-theme 'zenburn t)

;; ORG MODE
(setq org-log-done 'time)
(setq org-src-fontify-natively t) ;; Code highlighting in org mode

;; Visible-mark
(setq visible-mark-max 10)

;; Enable windowmove keybindings S-<arrow> to move between windows
(windmove-default-keybindings)

;; Save seesion on exit
;;(desktop-save-mode 1)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(custom-safe-themes
   (quote
    ("2bed8550c6f0a5ce635373176d5f0e079fb4fb5919005bfa743c71b5eed29d81" "ba9be9caf9aa91eb34cf11ad9e8c61e54db68d2d474f99a52ba7e87097fa27f5" "ac5584b12254623419499c3a7a5388031a29be85a15fdef9b94df2292d3e2cbb" "d606ac41cdd7054841941455c0151c54f8bff7e4e050255dbd4ae4d60ab640c1" "a0feb1322de9e26a4d209d1cfa236deaf64662bb604fa513cca6a057ddf0ef64" "ab04c00a7e48ad784b52f34aa6bfa1e80d0c3fcacc50e1189af3651013eb0d58" "04dd0236a367865e591927a3810f178e8d33c372ad5bfef48b5ce90d4b476481" "14f0fbf6f7851bfa60bf1f30347003e2348bf7a1005570fd758133c87dafe08f" "5cd0afd0ca01648e1fff95a7a7f8abec925bd654915153fb39ee8e72a8b56a1f" "f9574c9ede3f64d57b3aa9b9cef621d54e2e503f4d75d8613cbcc4ca1c962c21" default)))
 '(ecb-auto-expand-tag-tree (quote all))
 '(ecb-compilation-buffer-names
   (quote
    (("*Calculator*")
     ("*vc*")
     ("*vc-diff*")
     ("*Apropos*")
     ("*Occur*")
     ("*shell*")
     ("\\*[cC]ompilation.*\\*" . t)
     ("\\*i?grep.*\\*" . t)
     ("*JDEE Compile Server*")
     ("*Help*")
     ("*Backtrace*")
     ("*Compile-log*")
     ("*bsh*")
     ("*Messages*")
     ("*Ibuffer*")
     ("*scratch*")
     ("*Completions*"))))
 '(ecb-compile-window-height 5)
 '(ecb-compile-window-temporally-enlarge (quote both))
 '(ecb-compile-window-width (quote edit-window))
 '(ecb-enlarged-compilation-window-max-height (quote half))
 '(ecb-eshell-buffer-sync nil)
 '(ecb-eshell-buffer-sync-delay 10)
 '(ecb-fix-window-size (quote width))
 '(ecb-key-map
   (quote
    ("C-c ."
     (t "fh" ecb-history-filter)
     (t "fs" ecb-sources-filter)
     (t "fm" ecb-methods-filter)
     (t "fr" ecb-methods-filter-regexp)
     (t "ft" ecb-methods-filter-tagclass)
     (t "fc" ecb-methods-filter-current-type)
     (t "fp" ecb-methods-filter-protection)
     (t "fn" ecb-methods-filter-nofilter)
     (t "fl" ecb-methods-filter-delete-last)
     (t "ff" ecb-methods-filter-function)
     (t "p" ecb-nav-goto-previous)
     (t "n" ecb-nav-goto-next)
     (t "lc" ecb-change-layout)
     (t "lr" ecb-redraw-layout)
     (t "lw" ecb-toggle-ecb-windows)
     (t "lt" ecb-toggle-layout)
     (t "s" ecb-window-sync)
     (t "r" ecb-rebuild-methods-buffer)
     (t "a" ecb-toggle-auto-expand-tag-tree)
     (t "x" ecb-expand-methods-nodes)
     (t "h" ecb-show-help)
     (t "gl" ecb-goto-window-edit-last)
     (t "g1" ecb-goto-window-edit1)
     (t "g2" ecb-goto-window-edit2)
     (t "gc" ecb-goto-window-compilation)
     (t "gd" ecb-goto-window-directories)
     (t "gs" ecb-goto-window-sources)
     (t "gm" ecb-goto-window-methods)
     (t "gh" ecb-goto-window-history)
     (t "ga" ecb-goto-window-analyse)
     (t "gb" ecb-goto-window-speedbar)
     (t "md" ecb-maximize-window-directories)
     (t "ms" ecb-maximize-window-sources)
     (t "mm" ecb-maximize-window-methods)
     (t "mh" ecb-maximize-window-history)
     (t "ma" ecb-maximize-window-analyse)
     (t "mb" ecb-maximize-window-speedbar)
     (t "e" eshell)
     (t "o" ecb-toggle-scroll-other-window-scrolls-compile)
     (nil "C-." ecb-toggle-compile-window)
     (nil "C-'" ecb-toggle-compile-window-height)
     (t "," ecb-cycle-maximized-ecb-buffers)
     (t "." ecb-cycle-through-compilation-buffers))))
 '(ecb-layout-window-sizes
   (quote
    (("left8"
      (ecb-directories-buffer-name 0.1276595744680851 . 0.36231884057971014)
      (ecb-sources-buffer-name 0.1276595744680851 . 0.21739130434782608)
      (ecb-methods-buffer-name 0.1276595744680851 . 0.18840579710144928)
      (ecb-history-buffer-name 0.1276595744680851 . 0.21739130434782608)))))
 '(ecb-mouse-click-destination (quote left-top))
 '(ecb-new-ecb-frame nil)
 '(ecb-options-version "2.50")
 '(ecb-primary-secondary-mouse-buttons (quote mouse-1--C-mouse-1))
 '(ecb-source-path
   (quote
    ("/" "/home/erik" "/usr/include"
     ("~/Dropbox/Programming/c++" "c++")
     ("~/Dropbox/Programming/ansible" "ansible")
     ("~/Dropbox/Programming/arduino-1.8.2" "arduino")
     ("~/Dropbox/Programming/elisp" "elisp")
     ("~/Dropbox/Programming/c++/imagecrawler" "imagecrawler")
     ("/" "/"))))
 '(ecb-tip-of-the-day nil)
 '(ecb-type-tag-expansion
   (quote
    ((default "class" "interface" "group" "namespace")
     (c-mode "struct" "enum"))))
 '(ido-enable-flex-matching nil)
 '(ido-everywhere t)
 '(inhibit-startup-screen t)
 '(visible-mark-max 2)
 '(yas-also-auto-indent-first-line t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; stuff that needs some time
(ecb-hide-ecb-windows)
(ecb-toggle-compile-window)


;; (setq-default tab-width 2)

