;;;; chuck-testa.lisp

(in-package #:chuck-testa)

(suite foo123)

(test-case (fooo :in foo123)
  (true 123))

(suite (foo5 :in foo123))

(test-case (fooo2 :in foo5)
  (false 123))

(test-case (fooo3 :in foo123)
  (false 123))


