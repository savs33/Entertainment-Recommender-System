
(deftemplate fav
   (slot favfr)) 

(defrule mango
   (fruit1 mango)
=>
   (assert (fav (favfr mango)))
   (printout t "Mango is my favourite fruit" crlf))

(defrule fruits
   (fruit1 ~mango)
=>
   (assert (fav (favfr orange))) 
   (printout t "Mango is not my fav fruit" crlf))
