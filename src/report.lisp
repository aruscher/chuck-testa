(in-package #:chuck-testa)

(defparameter *report-stream* t)

(defun report (result)
  (format *report-stream* "Test Results~&")
  (format *report-stream* "============~&")
  (report-result result))

(defgeneric report-result (result &optional indent))

(defmethod report-result ((result suite-result) &optional (indent 0))
  (with-slots (origin value child-results) result
    (format *report-stream* "~VT SUITE ~a => ~a~&" indent (name origin) value)
    (dolist (child-result child-results)
      (report-result child-result (+ indent 2)))))

(defmethod report-result ((result test-case-result) &optional (indent 0))
  (with-slots (origin value assertion-results) result
    (format *report-stream* "~VT CASE ~a => ~a~&" indent (name origin) value)
    (dolist (assertion-result assertion-results)
      (report-result assertion-result (+ indent 2)))))

(defmethod report-result ((result assertion-result) &optional (indent 0))
  (with-slots (origin value) result
    (format *report-stream* "~VT ~a => ~a~&" indent origin value)))
