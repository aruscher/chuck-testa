(in-package #:chuck-testa)

(defparameter *assertion-results* nil)

(defmacro with-assertion-results (&body body)
  `(let ((*assertion-results* nil))
     ,@body
     *assertion-results*))

(defmacro true (expression)
  (let ((result (gensym "RESULT")))
    `(let ((,result (make-instance 'assertion-result
                                   :origin '(true ,expression))))
       (setf (value ,result) ,expression)
       (push ,result *assertion-results*)
       ,result)))

(defmacro false (expression)
  (let ((result (gensym "RESULT")))
    `(let ((,result (make-instance 'assertion-result
                                   :origin '(false ,expression))))
       (setf (value ,result) (not ,expression))
       (push ,result *assertion-results*)
       ,result)))
