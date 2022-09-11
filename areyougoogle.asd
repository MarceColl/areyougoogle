(asdf:defsystem #:areyougoogle
  :description "Are you google website"
  :author "marce@dziban.net"
  :license "MIT"
  :version "0.0.0"
  :serial t
  :depends-on (#:clog #:css-lite)
  :components ((:file "areyougoogle")))
