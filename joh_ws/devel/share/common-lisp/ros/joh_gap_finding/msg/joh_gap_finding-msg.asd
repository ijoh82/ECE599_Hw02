
(cl:in-package :asdf)

(defsystem "joh_gap_finding-msg"
  :depends-on (:roslisp-msg-protocol :roslisp-utils )
  :components ((:file "_package")
    (:file "gaps" :depends-on ("_package_gaps"))
    (:file "_package_gaps" :depends-on ("_package"))
  ))