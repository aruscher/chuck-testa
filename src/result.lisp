(in-package #:chuck-testa)

(defclass result ()
  ())

(defclass suite-result (result)
  ())

(defclass test-case-result (result)
  ())

(defclass assertion-result (result)
  ())
