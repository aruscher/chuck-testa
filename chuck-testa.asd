;;;; chuck-testa.asd

(asdf:defsystem #:chuck-testa
  :description "Describe chuck-testa here"
  :author "Your Name <your.name@example.com>"
  :license  "Specify license here"
  :version "0.0.1"
  :serial t
  :pathname "src/"
  :depends-on ("alexandria")
  :components ((:file "package")
               (:file "testable")
               (:file "specification")
               (:file "chuck-testa")))
