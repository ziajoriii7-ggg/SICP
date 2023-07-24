; # 1.1 SOLUTION: Below is a sequence of expressions. What is
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



; 1.2 SOLUTION: Translate a expression [given in the book] into prefix form
(/ (+ 5 4 (- 2 (- 3 (+ 6 (/ 4 5)))))
   (* 3 (- 6 2) (- 2 7)))
;-37/150



; 1.3 SOLUTION: Define a procedure that takes three numbers
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



; 1.4 SOLUTION: Observe that our model of evaluation allows for
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



; 1.5 SOLUTION: Ben Bitdiddle has invented a test to determine whether the
; interpreter he is faced with is using applicative-order evaluation or
; normal-order evaluation. He defines the following two procedures

(define (p) (p))
(define (test x y)
  (if (= x 0) 0 y))

  (test 0 (p))

; What behavior will Ben [1] observe with an interpreter that uses applicative-order
; evaluation? What behavior will he [2] observe with an interpreter that uses
; normal-order evaluation? Explain your answer. 

; Description of behavior

; [1] APPLICATIVE ORDER:
; The loop gets run as an infinite loop recursively(*1), it doesn't get a
; numerical value at the end since it evaluates itself as ´p´, without
; any exit condition.
; Since it first calls the arguments aka: call-by-value / llamada por valor.
; it's using an applicative order [evaluation]:
; 1. It evaluates 0 on ´test´, it's a simple eval so it doesn't go further.
; 2. It calls the value of ´(p)´ p calls itself on define, it goes on an infinite loop*1.

; Additional Notes (// theory):
; + (*1): When the program will not terminate (this case because there's not exit,
;       p on itself), the program will encounter a runtime error. This is called a
;       "Stack Overflow / Desbordamiento de pila" porque supera su tamaño asignado
;       debido a las llamada excesivas de (a) funciones (b) sus variables locales.
;       "SO" usualmente ocurre cuando:
;           1. hay una recursión infinita, defining itself 
;           2. o cuando hay llamadas con funciones sin condiciones de escape / terminación adecuadas.

; [2] NORMAL ORDER:
; An interpreter with Normal Order behavior would not call the evaluation until the
; the values are needed(*2). So when _line 5_ ´test´ is called it will check if x is 0
; so it will just give 0 as in _line 3_

; CODE GIVEN (// for reading accesibility purposes only XD):
; 1 |  (define (p) (p))
; 2 |  (define (test x y)
; 3 |    (if (= x 0) 0 y))
; 4 |
; 5 |  (test 0 (p))

  (test 0 (p))
; Additional Notes (// theory):
; + (*2): This behavior is known as "Lazy Evaluation".

; 1.6 SOL:
; 
  