(in-package #:chuck-testa)

(defclass result ()
  ((origin :initarg :origin :initform (error "ORIGIN required.") :reader origin)
   (value :initform nil :accessor value)))

(defmethod print-object ((result result) stream)
  (print-unreadable-object (result stream :type t :identity t)
    (format stream "~a => ~a"
            (origin result)
            (value result))))

(defclass suite-result (result)
  ((child-results :initform '() :accessor child-results)))

(defclass test-case-result (result)
  ((assertion-results :initform '() :accessor assertion-results)))

(defclass assertion-result (result)
  ())


