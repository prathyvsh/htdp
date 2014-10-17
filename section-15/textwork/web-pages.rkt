;;A Web-page (short: WP) is a structure:
;; (make-wp h p) 
;; where h is a symbol and p is a (Web) document.
(define-struct wp (header body))

;;A (Web) document is either

;;empty

;;(cons s p)
;;where s is a symbol and p is a document

;;(cons w p)
;;where w is a Web page and p is a document
