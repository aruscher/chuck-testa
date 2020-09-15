;;;; chuck-testa.asd

(asdf:defsystem #:chuck-testa
  :description "Describe chuck-testa here"
  :author "Your Name <your.name@example.com>"
  :license  "Specify license here"
  :version "0.0.1"
  :serial t
  :pathname "src/"
  :components ((:file "package")
               (:file "testable")
               (:file "result")
               (:file "chuck-testa")))
