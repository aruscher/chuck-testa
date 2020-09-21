(in-package #:chuck-testa)

(defgeneric run (testable))

(defmethod run ((test-suite test-suite))
  (let ((result (make-instance 'suite-result :origin test-suite)))
    (setf (child-results result)
          (mapcar #'run (reverse (childs test-suite))))
    (setf (value result)
          (every #'identity
                 (mapcar #'value (child-results result))))
    result))

(defmethod run ((test-case test-case))
  (let ((result (make-instance 'test-case-result :origin test-case)))
    (setf (assertion-results result)
          (funcall (test-lambda test-case)))
    (setf (value result)
          (every #'identity
                 (mapcar #'value (assertion-results result))))
    result))
