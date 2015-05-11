;;; packages.el --- web Layer packages File for Spacemacs
;;
;; Copyright (c) 2012-2014 Sylvain Benner
;; Copyright (c) 2014-2015 Sylvain Benner & Contributors
;;
;; Author: Sylvain Benner <sylvain.benner@gmail.com>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3
(defvar web-packages
  '(
    livescript-mode
    jade-mode
    nvm
    )
  "List of all packages to install and/or initialize. Built-in packages
which require an initialization must be listed explicitly in the list.")

(defvar web-excluded-packages '()
  "List of packages to exclude.")

(defun web/init-livescript-mode ()
  (use-package livescript-mode
    :defer t
    :init
    (progn
      (add-to-list 'auto-mode-alist '("\\.ls\\'" . livescript-mode))
      (evil-leader/set-key-for-mode 'livescript-mode "mc" 'livescript-compile-buffer)
      (evil-leader/set-key-for-mode 'livescript-mode "mC" 'livescript-compile-region)
      (evil-leader/set-key-for-mode 'livescript-mode "mr" 'livescript-repl)
      (add-hook 'livescript-mode-hook '(lambda ()
                                         (setq livescript-command "lsc"))
                ))))

(defun web/init-jade-mode ()
  (use-package jade-mode
    :defer t
    :init
    (progn
      (add-to-list 'auto-mode-alist '("\\.jade\\'" . jade-mode)))))

(defun web/init-nvm ()
  (use-package nvm
    :defer t
    :init
    (progn

      (defun do-nvm-use (version)
        (interactive "sVersion: ")
        (nvm-use version)
        (exec-path-from-shell-copy-env "PATH"))

      (defun run-node (cwd)
        (interactive "DDirectory: ")
        (unless (executable-find "node")
          (call-interactively 'do-nvm-use))
        (let ((default-directory cwd))
          (pop-to-buffer (make-comint (format "node-repl-%s" cwd) "node" nil "--interactive"))))
      )))

(defun web/init-npm ()
  (use-package npm
    :defer t
    :init
    (progn
      (evil-leader/set-key-for-mode '(js2-mode livescript-mode jade-mode) "ni" 'npm-install)
      (evil-leader/set-key-for-mode '(js2-mode livescript-mode jade-mode) "nn" 'npm-new)
      (evil-leader/set-key-for-mode '(js2-mode livescript-mode jade-mode) "nd" 'npm-dependency)
      (evil-leader/set-key-for-mode '(js2-mode livescript-mode jade-mode) "ne" 'npm-nodemon-exec)
      (evil-leader/set-key-for-mode '(js2-mode livescript-mode jade-mode) "np" 'npm-publish)
      (evil-leader/set-key-for-mode '(js2-mode livescript-mode jade-mode) "nt" 'npm-test)
      (evil-leader/set-key-for-mode '(js2-mode livescript-mode jade-mode) "nv" 'npm-version))))


(defun web/post-init-flycheck ()
  (add-hook 'livescript-mode-hook 'flycheck-mode))
