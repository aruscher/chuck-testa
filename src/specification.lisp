(in-package #:chuck-testa)

(defparameter *suite-table* (make-hash-table))
(defparameter *active-suite* nil)

(defun register-suite (suite)
  (let ((suite-name (name suite)))
    (when (suite-registered-p suite-name)
      (warn "Suite ~a is already defined!" suite-name))
    (setf (gethash suite-name *suite-table*) suite)))

(defun suite-registered-p (name)
  (nth-value 1 (gethash name *suite-table*)))

(defun lookup-suite (name)
  (unless (suite-registered-p name)
    (error "Suite ~a is not defined!" name))
  (gethash name *suite-table*))

(defun activate-suite (name)
  (let ((suite (lookup-suite name)))
    (setf *active-suite* suite)))

(defmacro in-suite (name)
  `(activate-suite ',name))

(defmacro defsuite (args)
  (let ((suite (gensym "SUITE")))
    (print args)
    (destructuring-bind (name &key description in) (alexandria:ensure-list args)
      `(let ((,suite (make-instance 'test-suite :name ',name :description ,(or description ""))))
         (register-suite ,suite)
         (print ',in)
         ,(cond
            (in `(add-child ,suite (lookup-suite ',in)))
            (*active-suite* `(add-child ,suite *active-suite*)))))))
