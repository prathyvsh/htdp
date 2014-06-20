(define (reply s)
  (cond
    [(symbol=? s 'GoodMorning) 'Hi]
    [(symbol=? s 'HowAreYou?) 'Fine]
    [(symbol=? s 'GoodAfternoon) 'INeedANap]
    [(symbol=? s 'GoodEvening) 'BoyAmITired]))

(symbol=? (reply 'GoodMorning) 'Hi)
(symbol=? (reply 'HowAreYou?) 'Fine)
(symbol=? (reply 'GoodAfternoon) 'INeedANap)
(symbol=? (reply 'GoodEvening) 'BoyAmITired)
