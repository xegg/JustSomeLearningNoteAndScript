;;1.3
(define (find-big-two a b c)
  (cond ((< a b c ) (+ b c))
        ((< b a c ) a c)
        ((< c b a ) (+ b a))))

;;1.5
(define p
  (p))

(define (= x 0)
  (if (= x 0)
    0
    y))

(define (square x)
     (* x x))

(define (sqrt-iter guess x)
  (if (good-enough? guess x)
    guess
    (sqrt-iter (improve guess x) x)))

(define (good-enough? guess x)
  (< (abs (- (square guess) x)) 0.001)) 
(define (improve guess x)
  (average guess (/ x guess)))

(define (average x y)
  (/ (+ x y) 2))

(define (sqrt x)
  (sqrt-iter 1.0 x))


;;1.6
(define (new-if predicate then-clause else-clause)
  (cond (predicate then-clause)
        (t else-clause)))

(define sqrt-iter (guess x)
  (new-if (good-enough? guess )
    guess
    (sqrt-iter (improve guess x) x)))

;;1.7
(define sqrt-iter (new-guess old-guess x)
  (if (good-enough? new-guess old-guess x)
    new-guess
    (sqrt-iter (improve new-guess x) new-guess x)))

(define good-enough? (old-guess new-guess)
  (< (abs (- old-guess new-guess)) 0.001))

;;1.9
(define + (a b)
  (if (= a 0)
    b
    (inc (+ (dec a) b))))

(define (A x y)
  (cond ((= y 0) 0)
        ((= x 0) (* 2 y))
        ((= y 1) 2)
        (t (A (-x 1)
              (A x (- y 1))))))
