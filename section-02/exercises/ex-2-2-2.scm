;dollar->euro: number -> number
;Converts dollar to euro
;Uses rates on 6 June 2014
;Source: http://oanda.com
(define (dollar->euro dollar)
  (* dollar 0.73450))

;Tests
(dollar->euro 1)
(dollar->euro 20)
(dollar->euro 50)
