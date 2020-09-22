(in-package #:chuck-testa)

(defparameter *suite-table* (make-hash-table))
(defparameter *active-suite* nil)

(defun register-suite (suite)
  (let ((suite-name (name suite)))
    (when (lookup-suite suite-name)
      (warn "Suite ~a is already defined!" suite-name))
    (setf (gethash suite-name *suite-table*) suite)))

(defun lookup-suite (name)
  (gethash name *suite-table*))

(defun activate-suite (name)
  (let ((suite (lookup-suite name)))
    (unless suite
      (error "Suite ~a is not defined!" name))
    (setf *active-suite* suite)))

(defmacro in-suite (name)
  `(activate-suite ',name))

(defmacro defsuite (args)
  (let ((suite (gensym "SUITE"))
        (in-suite (gensym "IN-SUITE")))
    (destructuring-bind (name &key description in) (alexandria:ensure-list args)
      `(let ((,suite
              (make-instance 'test-suite
                             :name ',name
                             :description ,(or description "")))
             (,in-suite (or (lookup-suite ',in) *active-suite*)))
         (register-suite ,suite)
         (when ,in-suite
           (add-child ,suite ,in-suite))))))
