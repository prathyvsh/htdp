(define-struct posn (x y))
(define point (make-posn 10 20))
(posn-x point)
(posn-y point)


(define-struct entry (name zip phone))
(define phonebook (make-entry 'PeterLee 15270 '606-7771))

(entry-name phonebook)
(entry-zip phonebook)
(entry-phone phonebook)

(define-struct star (last first instrument sales))

(make-star 'Friedman 'Dan 'ukelele 19004)
(make-star 'Talcott 'Carolyn 'banjo 80000)
(make-star 'Harper 'Robert 'bagpipe 27860)
