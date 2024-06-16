
(cl:in-package :asdf)

(defsystem "servicebot-srv"
  :depends-on (:roslisp-msg-protocol :roslisp-utils )
  :components ((:file "_package")
    (:file "commandService" :depends-on ("_package_commandService"))
    (:file "_package_commandService" :depends-on ("_package"))
  ))