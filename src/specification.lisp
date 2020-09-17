(in-package #:chuck-testa)

(defparameter *test-suite-table*
  (make-hash-table))

(defparameter *test-case-table*
  (make-hash-table))

(defgeneric register (testable))

(defmethod register :before ((testable testable))
  (with-slots (name) testable
    (when (or (gethash name *test-suite-table*)
              (gethash name *test-case-table*))
      (warn "Override ~a" name))))

(defmethod register ((test-case test-case))
  (setf (gethash (name test-case) *test-case-table*)
        test-case))

(defmethod register ((test-suite test-suite))
  (setf (gethash (name test-suite) *test-suite-table*)
        test-suite))

(defmacro suite (args)
  (destructuring-bind (name &key description) (alexandria:ensure-list args)
    `(register (make-instance 'test-suite
                     :name ',name
                     :description ,(or description "")))))

(defmacro test-case (args &body body)
  (destructuring-bind (name &key description) (alexandria:ensure-list args)
    (let ((test-lambda (apply #'build-test-lambda nil body)))
      `(register (make-instance 'test-case
                       :name ',name
                       :description ,(or description "")
                       :expression ',test-lambda
                       :test-lambda ,test-lambda)))))

(defun build-test-lambda (args &rest body)
  `(lambda ,args
     (with-assertion-results
       ,@body)))

