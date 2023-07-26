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

;

; 1.5 SOLUTION: Ben Bitdiddle has invented a test to determine whether the
; interpreter he is faced with is using applicative-order evaluation or
; normal-order evaluation. He defines the following two procedures

; COMMENTING OUT THE CODE SO THE REST CAN RUN
; (define (p) (p))
; (define (test x y)
;   (if (= x 0) 0 y))

;   (test 0 (p))

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

;  (test 0 (p))
; Additional Notes (// theory):
; + (*2): This behavior is known as "Lazy Evaluation".



; 1.6 SOL:
; # Exercise 1.6: Alyssa P. Hacker doesn’t see why if needs to
; be provided as a special form. “Why can’t I just define it as
; an ordinary procedure in terms of cond?” she asks. Alyssa’s
; friend Eva Lu Ator claims this can indeed be done, and she
; defines a new version of if

(define (new-if predicate then-clause else-clause) ; this code define the procedure new-if and it tales three arguments. 
  (cond (predicate then-clause)                    ; this procedure evaluates predicate if it's true it returns the value of ´then-clause´
        (else else-clause)))(newline)              ; if the predicate is not true it returns else-clause

; Eva demonstrates the program for Alyssa 

(new-if (= 2 3) 0 5)    ; The predicate ´(= 2 3)´ is false since 2 != 3. so ´else-clause´ is evaluated. In this case it returns 5.
; 5

(new-if (= 1 1) 0 5)    ; The predicate ´(= 1 1)´ is true since 1 = 1. so ´then-clause´ is evaluated. In this case it returns 0.
; 0

; Delighted, Alyssa uses new-if to rewrite the square-root program:|# 

; (define (sqrt-iter guess x)
;  (new-if (good-enough? guess x)
;          guess
;          (sqrt-iter (improve guess x) x)))|# 


; What happens when Alyssa attempts to use this to compute square roots? Explain.|# 

; So in this exercise Alyssa redefine the ´if´, which is a special form.
; A procedure on Scheme is a function that gets evaluated first

; A special form is a first-class object that takes arguments first and then does
; a lazy evaluation.

; Since Alyssa is redefining ´if´ (NORMAL ORDER) as a procedure ´new-if´ (APPLICATIVE ORDER)
; it goes on loop infinitely IF ´good-enough?´ were defined, but it's not?? // self-note, i need to review this later again

; since it's not defined it gives me off " good-enough?: unbound identifier in: good-enough?"
; if ´good-enough´ procedure was defined then ´new-if´ would go infinitely since ´new-if´
; is a procedure of eval first (APPLICATIVE ORDER) form unlike the special form
; ´if´ (NORMAL ORDER)


; Exercise 1.7: The good-enough? test used in computing square roots will not
; be very effective for finding the square roots of very small numbers. Also,
; in real computers, arithmetic operations are almost always performed with
; limited precision. This makes our test inadequate for very large numbers.
; Explain these statements, with examples showing how the test fails for
; small and large numbers. An alternative strategy for implementing good-enough?
; is to watch how guess changes from one iteration to the next and to stop when
; the change is a very small fraction of the guess. Design a square-root
; procedure that uses this kind of end test. Does this work better for small
; and large numbers?

(sqrt 12345678901234)
; 3513641.8288200633

(sqrt 9123456799955555555555555)
; 3020506050309.3774

(sqrt 0.0000000000552345235555)


; GENERAL OBSERVATIONS:
; + sqrt is very ineffective for tiny value because of the added decimals because of memory
; + so far very large numbers seem good? but i have seen different results on some SICP
; + blogs: https://www.timwoerner.de/posts/sicp/exercises/1/7/

; apparently ´good-enough?´ is not kenough to solve and the numerical values of very tiny
; numbers because of memory reasons. I remember asking this same question to ChatGPT
; because of Python (// self-note: i need to dig this up and solve it more accordingly / formally)

; SOL 1.8
; approximation of Newton's method to find the cuber root of x
; frac{{x/y^2} + 2y}/3

(define (cube-root x)
  (define (good-enough? guess x)
    (< (abs (- (cube guess) x)) 0.00001))         ; compare values

  (define (improve guess x)
    (/ (+ (/ x (* guess guess)) (* 2 guess)) 3))

  (define (cube x) (* x x x))                      ;define cube

  (define (sqrt-iter guess x)
    (if (good-enough? guess x)
        guess
        (sqrt-iter (improve guess x) x)))

  (sqrt-iter 1.0 x))

; TEST USAGE:
(display (cube-root 27))
; 3.0000000000000977
