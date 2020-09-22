;;;; chuck-testa.lisp

(in-package #:chuck-testa)

(defclass stupid-stack ()
  ((content :initform '() :accessor content)))

(defun push-element (element stack)
  (push element (content stack)))

(defun pop-element (stack)
  (pop (content stack)))

(defun number-of-element (stack)
  (list-length (content stack)))

;; ----------------------------------------

(defsuite stupid-stack-suite)

(in-suite stupid-stack-suite)

(defsuite other-suite)

(defsuite (other-suite-2 :in stupid-stack-suite))


(inspect (lookup-suite 'stupid-stack-suite))
