#|
-> means writes to
<- means reads from

hangman -> chosen-word
hangman -> status-word
hangman -> body-parts-left
hangman -> new-knowledge

hangman-guess <- chosen-word
hangman-guess <- -> status-word
hangman-guess <- -> body-parts-left
hangman-guess <- -> new-knowledge

reveal-list <- chosen-word
reveal-list <- status-word
reveal-list does nothing on body-parts-left
reveal-list -> new-knowledge

|#

