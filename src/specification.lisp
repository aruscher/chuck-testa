(in-package #:chuck-testa)

(defparameter *test-suite-table*
  (make-hash-table))

(defparameter *test-case-table*
  (make-hash-table))

(defgeneric register (testable))

(defmethod register :before ((testable testable))
  (with-slots (name) testable
    (when (resolve-testable name)
      (warn "Override ~a" name))))

(defmethod register ((test-case test-case))
  (setf (gethash (name test-case) *test-case-table*)
        test-case))

(defmethod register ((test-suite test-suite))
  (setf (gethash (name test-suite) *test-suite-table*)
        test-suite))

(defun resolve-testable (name)
  (or (gethash name *test-suite-table*)
              (gethash name *test-case-table*)))

(defmacro suite (args)
  (let ((test-suite (gensym "TEST-SUITE"))
        (in-suite (gensym "IN-SUITE")))
    (destructuring-bind (name &key description in) (alexandria:ensure-list args)
      `(let ((,test-suite (make-instance 'test-suite
                                         :name ',name
                                         :description ,(or description ""))))
         (register ,test-suite)
         ,(when in
            `(let ((,in-suite (gethash ',in *test-suite-table*)))
               (if ,in-suite
                   (add-child ,test-suite ,in-suite)
                   (warn "Can't find suite ~a" ',in))))))))

(defmacro build-test-lambda (args &rest body)
  `(lambda ,args
     (with-assertion-results
       ,@body)))

(defmacro test-case (args &body body)
  (let ((test-case (gensym "TEST-CASE"))
        (in-suite (gensym "IN-SUITE")))
    (destructuring-bind (name &key in description) (alexandria:ensure-list args)
      `(let ((,test-case (make-instance 'test-case
                                        :name ',name
                                        :description ,(or description "")
                                        :test-lambda (build-test-lambda nil ,@body))))
         (register ,test-case)
         ,(when in
            `(let ((,in-suite (gethash ',in *test-suite-table*)))
               (if ,in-suite
                   (add-child ,test-case ,in-suite)
                   (warn "Can't find suite ~a" ',in))))))))

