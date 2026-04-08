(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (and custom-file
           (file-exists-p custom-file))
  (load custom-file nil :nomessage))

(load "~/.emacs.d/crafted-emacs/modules/crafted-init-config")

(defun crafted-emacs-load-modules (modules)
  "Initialize crafted-emacs modules.

MODULES is a list of module names without the -packages or 
-config suffixes.  Note that any user-provided packages should be
added to `package-selected-packages' before invoking this
function."
  (dolist (m modules)
    (require (intern (format "crafted-%s-packages" m)) nil :noerror))
  (package-install-selected-packages :noconfirm)
  (dolist (m modules)
    (require (intern (format "crafted-%s-config" m)) nil :noerror)))

;; Any extra packages in addition to the ones added by crafted-emacs
;; modules go here before we call `crafted-emacs-load-modules'.
(customize-set-variable 'package-selected-packages '(ef-themes magit))

(crafted-emacs-load-modules '(defaults completion ui ide))
