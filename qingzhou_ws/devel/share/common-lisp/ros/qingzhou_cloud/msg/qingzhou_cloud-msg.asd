
(cl:in-package :asdf)

(defsystem "qingzhou_cloud-msg"
  :depends-on (:roslisp-msg-protocol :roslisp-utils )
  :components ((:file "_package")
    (:file "current_location" :depends-on ("_package_current_location"))
    (:file "_package_current_location" :depends-on ("_package"))
    (:file "qingzhou_cloud" :depends-on ("_package_qingzhou_cloud"))
    (:file "_package_qingzhou_cloud" :depends-on ("_package"))
    (:file "roadLine" :depends-on ("_package_roadLine"))
    (:file "_package_roadLine" :depends-on ("_package"))
    (:file "startstopCommand" :depends-on ("_package_startstopCommand"))
    (:file "_package_startstopCommand" :depends-on ("_package"))
    (:file "stoppoint" :depends-on ("_package_stoppoint"))
    (:file "_package_stoppoint" :depends-on ("_package"))
    (:file "trafficlight" :depends-on ("_package_trafficlight"))
    (:file "_package_trafficlight" :depends-on ("_package"))
  ))