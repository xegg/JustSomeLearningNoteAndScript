#lang sicp

(define (cube a)
  (* a a a))

(define (sum-integer a b)
  (if (> a b)
      0
      (+ a (sum-integer (+ a 1) b))))

(define (sum-cubes a b)
  (if (> a b)
      0
      (+ (cube a) (sum-cubes (+ a 1) b))))

(define (pi-sum a b)
  (if  (> a b)
       0
       (+ (/ 1.0 (* a (+ a 2))) (pi-sum (+ a 4) b))))

(define (sum term a next b)
  (if (> a b)
      0
      (+ (term a)
         (sum term (next a) next b))))

(define (inc n) (+ n 1))
(define (sum-cubes1 a b)
  (sum cube a inc b))

(define (identity x) x)

(define (sum-integers a b)
  (sum identity inc b))

(define (pi-sum1 a b)
  (define (pi-term x)
    (/ 1.0 (* x (+ x 2))))
  (define (pi-next x)
    (+ x 4))
    (sum pi-term a pi-next b))

(define (integral f a b dx)
  (define (add-dx x) (+ x dx))
  (* (sum f (+ a (/ dx 2.0)) add-dx b)
     dx))

(lambda (x) (+ x 4))

(define (pi-sum2 a b)
  (sum (lambda (x) (/ 1.0 (* x (+ x 2))))
       a
       (lambda (x) (+ x 4))
       b))

(define (integral2 f a b dx)
  (* (sum f
          (+ a (/ dx 2.0))
          (lambda (x) (+ x dx))
          b)
     dx))

;; 1.29
(define (factor k)
  (cond ((or (= k 0) (= k n))
         1)
        ((odd? k)
         (else
          2))))

(define (integral3 f a b n)
  (define h
    (/ (- b a) n))
  (define (y k)
    (f (+ a (* k h))))
  (* (sum f
          ())
     (/ h 3)

(define (f x y)
  (define (f-helper a b)
    (+ (* x (square a))
       (* y b)
       (* a b)))
    (f-helper (+ 1 (* x y))
              (- 1 y)))

(define (f2 x y)
  (let ((a (+ 1 (* x y)))
        (b (- y)))
    (+ (* x (square a))
       (* y b)
       (* a b))))

;; 1.34
(define (square n) (* n n))
(define (f1 g)
  (g 2))
(f1 (lambda (z) (* z (+ z 1))))

;;(f1 f1)
;;(f1 (lambda (g) (g 2)))
;;((lambda (g) (g 2) 2))

(define (average a b) (/ (+ a b) 2))

(define (search f neg-point pos-point)
  (let ((midpoint (average neg-point pos-point)))
    (if (close-enough? neg-point pos-point)
        midpoint
        (let ((test-value (f midpoint)))
          (cond ((positive? test-value)
                 (search f neg-point midpoint))
                 ((negative? test-value)
                  (search f midpoint pos-point))
                (else midpoint))))))

(define (close-enough? x y)
  (< (abs (- x y)) 0.001))
 
(define (half-interval-method f a b)
  (let ((a-value (f a))
        (b-value (f b)))
    (cond ((and (negative? a-value) (positive? b-value))
           (search f a b))
          ((and (negative? b-value) (positive? a-value))
           (search f b a))
          (else
           (display "Values are not of opposite sign")))))
;;(half-interval-method sin 2.0 4.0)
;;(half-interval-method  (lambda (x) (- (* x x x) (* 2 x) 3)) 1.0 2.0)

(define tolerance 0.00001)

(define (fixed-point f first-guess)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2)) tolerance))
  (define (try guess)
    (let ((next (f guess)))
      (if (close-enough? guess next)
          next
          (try next))))
  (try first-guess))

;;(fixed-point cos 1.0)

(define (sqrt x)
  (fixed-point (lambda (y) (/ x y))
               1.0))

(define (sqrt1 x)
  (fixed-point (lambda (y) (average y (/ x y)))
               1.0))
;; 1.35
;;(fixed-point (lambda (x) (+ 1 (/ 1 x))) 1.0)




