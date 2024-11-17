;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;                             ;;;;
;;;; LISP PROGRAMMING ASSIGNMENT ;;;;
;;;; --------------------------- ;;;;
;;;; BY:  ETHAN BARRY            ;;;;
;;;; ON:  11.13.2024             ;;;;
;;;; FOR: COSC 5340/4340.060     ;;;;
;;;;                             ;;;;
;;;; THIS LISP FILE CONTAINS A   ;;;;
;;;; RECURSIVE-DESCENT PARSER    ;;;;
;;;; FOR A (VERY) SMALL SUBSET   ;;;;
;;;; OF THE ENGLISH LANGUAGE.    ;;;;
;;;;                             ;;;;
;;;; THE FUNCTIONS ARE DEFINED   ;;;;
;;;; FIRST, AND TESTED AT THE    ;;;;
;;;; END OF THE FILE.            ;;;;
;;;;                             ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; FUNCTION DEFINITIONS ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;; A FUNCTION THAT TESTS MEMBERSHIP OF `ATM` IN `LST`.
(DEFUN IS-MEMBER(ATM LST)
       (IF (NULL LST)                                 ;; IF EMPTY,
           NIL                                        ;; RETURN NIL.
           (IF (EQUAL (CAR LST) ATM)                  ;; ELSE, IF ATM = (CAR LST)
               T                                      ;; RETURN T
               (IS-MEMBER ATM (CDR LST)))))           ;; ELSE, RETURN RECURSIVE CALL

;;;; IS `ATM` AN ARTICLE?
(DEFUN ARTICLE(ATM)
       (IS-MEMBER ATM '(A AN THE)))

;;;; IS `ATM` AN ADJECTIVE?
(DEFUN ADJECTIVE(ATM)
       (IS-MEMBER ATM '(GREYHOUND SMALL LIGHT BIG MORE LESS HIGH LOW TALL SHORT NEAR FAR WIDE NARROW RED GREEN BLUE YELLOW WHITE BLACK GOOD AMERICAN LARGE)))

;;;; IS `ATM` A NOUN?
(DEFUN NOUN(ATM)
       (IS-MEMBER ATM '(COMPUTERS DOG GREYHOUND TURTLES BOY APPLE BUSSES WHITETAIL PEOPLE SKUNK)))

;;;; IS `ATM` A VERB?
(DEFUN VERB(ATM)
       (IS-MEMBER ATM '(RUNS RUN DRIVE SMELLS JUMPS WORK)))

;;;; IS `ATM` AN ADVERB?
(DEFUN ADVERB(ATM)
       (IS-MEMBER ATM '(FAST SLOW VERY EXTREMELY HIGH HARD GOOD)))

;;;; SYNTACTICALLY VALIDATES A SENTENCE, ACCORDING TO THE SIMPLE GRAMMAR
;;;; GIVEN IN THE ASSIGNMENT DOCUMENT AND SPECIFICATION.
(DEFUN SENTENCE(LST)
       (IF (ARTICLE (CAR LST))                        ;; IF FIRST WORD IS AN ARTICLE,
           (RESTOFSENTENCE (CDR LST))                 ;; THEN CALL RESTOFSENTENCE ON THE TAIL,
           (RESTOFSENTENCE LST)))                     ;; ELSE CALL IT ON THE WHOLE LIST.

;;;; ANOTHER LAYER IN OUR LITTLE RECURSIVE-DESCENT SENTENCE PARSER.
(DEFUN RESTOFSENTENCE(LST)
       (IF (ADJECTIVE (CAR LST))                      ;; IF FIRST WORD IS AN ADJECTIVE,
           (RESTOFSENTENCE (CDR LST))                 ;; THEN CALL RESTOFSENTENCE ON THE TAIL,
           (SHORTSENTENCE LST)))                      ;; ELSE CALL SHORTSENTENCE ON THE LIST.

;;;; PARSES SENTENCES OR FRAGMENTS BEGINNING WITH NOUNS.
(DEFUN SHORTSENTENCE(LST)
       (IF (NOUN (CAR LST))                           ;; IF FIRST WORD IS A NOUN,
           (SENTENCEEND (CDR LST))                    ;; LOOK FOR THE END OF THE SENTENCE,
           NIL))                                      ;; ELSE REJECT.

;;;; PARSES THE VERB AND ADVERBS.
(DEFUN SENTENCEEND(LST)
       (IF (VERB (CAR LST))                           ;; IF FIRST WORD IS A VERB,
           (MODADVERB (CDR LST))                      ;; LOOK FOR MODIFYING ADVERBS.
           NIL))                                      ;; ELSE REJECT.

;;;; PARSE MODIFYING ADVERBS.
(DEFUN MODADVERB(LST)
       (IF (NULL LST)                                 ;; IF LIST IS EMPTY,
           T                                          ;; RETURN T, I.E. ACCEPT.
           (IF (ADVERB (CAR LST))                     ;; ELSE, IF AN ADVERB REMAINS,
               (MODADVERB (CDR LST))                  ;; RECURSIVELY CALL SELF,
               NIL)))                                 ;; ELSE REJECT.

;;;;;;;;;;;;;;;;;;;;;;;;
;;;; SENTENCE TESTS ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;

;;;; THESE SHOULD BE ACCEPTED (10 TESTS).
(SENTENCE '(A GREYHOUND DOG RUNS VERY FAST))
(SENTENCE '(TURTLES RUN SLOW))
(SENTENCE '(BUSSES DRIVE FAST))
(SENTENCE '(THE SMALL LIGHT WHITETAIL JUMPS EXTREMELY HIGH))
(SENTENCE '(AN APPLE SMELLS GOOD))
(SENTENCE '(A SKUNK SMELLS))
(SENTENCE '(PEOPLE WORK))
(SENTENCE '(COMPUTERS RUN))
(SENTENCE '(LARGE AMERICAN PEOPLE WORK VERY HARD))
(SENTENCE '(THE DOG RUNS VERY VERY VERY FAST))

;;;; THESE SHOULD BE REJECTED (3 TESTS).
(SENTENCE '(THE DOG AND SKUNK RUN))
(SENTENCE '(BUSSES DRIVE FAST AND MOVE PEOPLE))
(SENTENCE '(A A SKUNK WORK))
