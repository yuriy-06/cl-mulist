(in-package :asdf)

(defsystem :mulist
  :name "stk"
  :author "Vdovik Yuriy <babah.yuriy06@gmail.com>"
  :version "0.01"
  :maintainer "Vdovik Yuriy <babah.yuriy06@gmail.com>"
  :licence "MIT License"
  :description "Some function for engineering work"
:depends-on (:LispMathTranslator)
  :components ((:file "package")
               (:file "mulist"))
  :serial t)
  
