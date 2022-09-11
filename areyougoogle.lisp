(defpackage #:areyougoogle
  (:use #:cl #:clog)
  (:export start-app
           start-server-app))

(in-package #:areyougoogle)

(defparameter style
  (css-lite:css
    (("html") (:height "100%"))
    (("body") (:height "100%"))
    ((".hidden")
     (:visibility "hidden" :opacity "0" :transition "visibility 0s 2s, opacity 2s linear"))))

(defparameter sentences
  '("I thought so..."
    "Kind of expected"
    "Are you telling me you are not at 100k requests per second?"
    "Maybe avoid k8s then"
    "Couple of servers should be fine..."
    "Really? Microservices?"))

(defun on-new-window (body)
  "On-new-window handler"
  (setf (title (html-document body)) "Are you at google scale?")
  (load-css (html-document body) "https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css")
  (with-connection-cache (body)
    (with-clog-create body
      (div (:class "container h-100")
           (style-block (:bind st))
           (div (:class "h-100 d-flex align-items-center justify-content-center flex-column")
                (div (:content "Are you at Google scale?" :class "h2"))
                (div (:class "d-flex flex-row justify-content-around" :style "width: 200px;")
                    (button (:bind b1 :content "Yes" :class "w-75 mr-4"))
                    (button (:bind b2 :content "No" :class "w-75 ml-4")))
                (div (:bind sassy :content "" :class "m-4 h3"))))

      (setf (inner-html st) style)
      (mapcar
       #'(lambda (btn)
           (let ((other (car (remove-if #'(lambda (i) (eq i btn)) (list b1 b2)))))
             (set-on-mouse-over btn
               #'(lambda (obj)
                   (setf (text obj) "No")
                   (setf (text other) "Yes")))
             (set-on-click btn
              #'(lambda (obj)
                  (remove-class sassy "hidden")
                  (setf (text obj) "No")
                  (setf (text other) "Yes")
                  (if (string= (text obj) "No")
                      (setf (text sassy) (nth (random (length sentences)) sentences))
                      (setf (text sassy) "I doubt it"))
                  (add-class sassy "hidden")))))
       (list b1 b2)))))

(defun start-app ()
  (initialize 'on-new-window)
  (open-browser))

(defun start-server-app ()
  (initialize 'on-new-window)
  (sleep 1))
