; #Exercises 1.1: Below is a sequence of expressions. What is
; the result printed by the interpreter in response to each expression?

#lang sicp

10
;10

(+ 5 3 4)
;12

(- 9 1)
;8

(/ 6 2)
;3

(+(* 2 4) (- 4 6))
;6

(define a 3)
(define b (+ a 1))
(+ a b (* a b))
;19

(= a b)
;#f falso

(if (and (> b a) (< b (* a b)))
    b
    a)
;4

(cond ((= a 4) 6)
      ((= b 4) (+ 6 7 a))
      (else 25))
;16

(+ 2 (if (> b a) b a))
;6

(* (cond ((> b a) a)
         ((< a b) b)
         (else -1))
   (+ a 1))
;12



; Exercise 1.2: Translate a expression [given in the book] into prefix form
(/ (+ 5 4 (- 2 (- 3 (+ 6 (/ 4 5)))))
   (* 3 (- 6 2) (- 2 7)))
;-37/150



; Exercise 1.3: Define a procedure that takes three numbers
; as arguments and return the sum of the squares of the two
; larger numbers.

(define (square x)
  (* x x))

(define (sum_of_square_of_two_largest_numbers a b c)
  (cond ((and (<= a b) (<= a c))
         (+ (square b) (square c))) ; a is excluded ->  sum of squares of b and c 
        
        ((and (<= b a) (<= b c))
         (+ (square a) (square c))) ; b is excluded ->  sum of squares of a and c  
  
        ((and (<= c a) (<= c b))
         (+ (square a) (square b))) ; c is excluded ->  sum of squares of a and b 
  ))
; Testing out the procedure above
(display (sum_of_square_of_two_largest_numbers 1 2 3)); 2^2 + 3^2
;13



; Exercise 1.4: Observe that our model of evaluation allows for
; combinations whose operators are compound expressions. Use this
; observation to describe the behavior of the following procedure

(define (a-plus-abs-b a b)
  (if (> b 0) + -) a b)

; description of above procedure:
; This procedure is defined by two paremeters a and b.

; if b is greater than 0 then its value remains positive
; if b is less than 0 then its value it adds it a - (minus),
; since the input value was already a negative two minuses converts b into a positive.

; this means that this procedure sums a and the absolute value of b.



; Exercise 1.5: Ben Bitdiddle has invented a test to determine whether the
; interpreter he is faced with is using applicative-order evaluation or
; normal-order evaluation. He defines the following two procedures

(define (p) (p))
(define (test x y)
  (if (= x 0) 0 y))

  (test 0 (p))

; What behavior will Ben observe with an interpreter that uses applicative-order
; evaluation? What behavior will he observe with an interpreter that uses
; normal-order evaluation? Explain your answer. 

; Description of behavior;
; The loop gets run as an infinite loop recursively, it doesn't get a
; numerical value at the end since it evaluates itself as ´p´, without
; any exit condition.
; Since it first calls the arguments aka: call-by-value / llamada por valor.
; it's using an applicative order [evaluation]:
; 1. It evaluates 0 on ´test´, it's a simple eval so it doesn't go further.
; 2. It calls the value of ´(p)´ p calls itself on define, it goes on an infinite loop



; To convert this applicative order procedure to a normal order we would have to
; change 

  