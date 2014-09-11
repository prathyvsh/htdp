#|
-> means writes to
<- means reads from

hangman -> chosen-word
hangman -> status-word
hangman -> body-parts-left

hangman-guess <- chosen-word
hangman-guess <- -> status-word
hangman-guess <- -> body-parts-left
|#
