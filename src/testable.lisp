(in-package #:chuck-testa)

(defclass testable ()
  ((name :initarg :name :initform (error "NAME required.") :reader name)
   (description :initarg :description :initform "" :reader description)
   (parent :initform nil :accessor parent)))

(defclass test-suite (testable)
  ((childs :initarg :childs :initform '() :accessor childs)))

(defgeneric add-child (testable suite))

(defmethod add-child ((testable testable) (suite test-suite))
  (push testable (childs suite))
  (setf (parent testable) suite))

(defclass test-case (testable)
  ((test-lambda :initarg :test-lambda :initform (error "TEST-LAMBDA required.") :reader test-lambda)
   (expression :initarg :expression :initform nil :reader expression)))

(defmethod initialize-instance :after ((test-case test-case) &key)
  (assert (functionp (test-lambda test-case))))
