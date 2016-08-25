#lang sicp

(define (add-rat x y)
  (make-rat (+ (* (numer x) (denom y))
               (* (numer y) (denom y)))
            (* (denom x) (denom y))))

(define (sub-rat x y)
    (make-rat (- (* (numer x) (denom y))
                 (* (numer y) (denom x)))
              (* (denom x) (denom y))))

(define (mul-rat x y)
    (make-rat (* (numer x) (numer y))
              (* (denom x) (denom y))))

(define (div-rat x y)
    (make-rat (* (numer x) (denom y))
              (* (denom x) (numer y))))

(define (equal-rat? x y)
    (= (* (numer x) (denom y))
       (* (numer y) (denom x))))



(define (make-rat n d) (cons n d))
(define (numer x) (car x))
(define (denom x) (cdr x))

(define (print-rat x)
    (newline)
    (display (numer x))
    (display "/")
    (display (denom x)))


(define (gcd a b)
  ( if (= b 0)
       a
       (gcd b (remainder a b))))

(define (make-rat1 n d)
    (let ((g (gcd n d)))
         (cons (/ n g) (/ d g))))

(define one-half (make-rat 1 2))
(define one-third (make-rat 1 3))

;; 2.1
(define (make-rat2 n d)
    (if (< d 0)
        (cons (- n) (- d))
        (cons n d)))

(define (numer1 x)
  (let ((g (gcd (car x) (cdr x))))
    (/ (car x) g)))

(define (denom1 x)
  (let ((g (gcd (car x) (cdr x))))
    (/ (cdr x) g)))

;;2.2
(define (make-segment start-point end-point)
    (cons start-point end-point))

(define (start-segment seg)
    (car seg))

(define (end-segment seg)
    (cdr seg))

(define (make-point x y)
    (cons x y))

(define (x-point p)
    (car p))

(define (y-point p)
    (cdr p))

(define (midpoint-segment seg)
    (let ((start (start-segment seg))
          (end (end-segment seg)))
        (make-point (average (x-point start)
                             (x-point end))
                    (average (y-point start)
                             (y-point end)))))

(define (average x y)
    (/ (+ x y)
       2.0))

(define (print-point p)
    (newline)
    (display "(")
    (display (x-point p))
    (display ",")
    (display (y-point p))
    (display ")"))

;; 2.3
(define (perimeter-rectangle r)
    (let ((length (length-of-rectangle r))
          (width (width-of-rectangle r)))
        (* 2 
           (+ length width))))

(define (area-rectangle r)
    (* (length-of-rectangle r)
       (width-of-rectangle r)))


(define (make-rectangle length-1 length-2 width-1 width-2)
    (cons (cons length-1 length-2)
          (cons width-1 width-2)))


(define (length-1-rectangle r)
    (car (car r)))

(define (length-2-rectangle r)
    (cdr (car r)))

(define (width-1-rectangle r)
    (car (cdr r)))

(define (width-2-rectangle r)
    (cdr (cdr r)))

(define (print-rectangle r)
    (let ((l1 (length-1-rectangle r))
          (l2 (length-2-rectangle r))
          (w1 (width-1-rectangle r))
          (w2 (width-2-rectangle r)))

        (newline)
        (display "Length 1:")
        (print-point (start-segment l1))
        (print-point (end-segment l1))

        (newline)
        (display "Length 2:")
        (print-point (start-segment l2))
        (print-point (end-segment l2))

        (newline)
        (display "Width 1:")
        (print-point (start-segment w1))
        (print-point (end-segment w1))

        (newline)
        (display "Width 2:")
        (print-point (start-segment w2))
        (print-point (end-segment w2))))

(define (length-of-rectangle r)
    (let ((length (length-1-rectangle r)))
        (let ((start (start-segment length))
              (end (end-segment length)))
            (- (x-point end)
               (x-point start)))))

(define (width-of-rectangle r)
    (let ((width (width-1-rectangle r)))
        (let ((start (start-segment width))
              (end (end-segment width)))
            (- (y-point end)
               (y-point start)))))

(define (make-rectangle1 length width)
    (cons length width))

(define (length-rectangle r)
    (car r))

(define (width-rectangle r)
    (cdr r))

(define (length-of-rectangle1 r)
    (let ((length (length-rectangle r)))
        (let ((start (start-segment length))
              (end (end-segment length)))
            (- (x-point end)
               (x-point start)))))

(define (width-of-rectangle1 r)
    (let ((width (width-rectangle r)))
        (let ((start (start-segment width))
              (end (end-segment width)))
            (- (y-point end)
               (y-point start)))))
;;;
(define (cons1 x y)
    (define (dispatch m)
        (cond ((= m 0) x)
              ((= m 1) y)))
     dispatch)
(define (car z) (z 0))
(define (cdr z) (z 1))


;; 2.4
(define (cdr1 z)
    (z (lambda (p q) q)))

;; 2.5
(define (cons2 x y)
    (* (expt 2 x)
       (expt 3 y)))


(define (car2 z)
    (if (= 0 (remainder z 2))
        (+ 1 (car (/ z 2)))
        0))

(define (cdr2 z)
    (if (= 0 (remainder z 3))
        (+ 1 (cdr (/ z 3)))
        0))

;; 2.6
(define zero
  (lambda (f) (lambda (x) x)))

(define (one-1 n)
  (lambda (f) (lambda (x) (f ((n f) x)))))

;;(add-1 zero)
;;(add-1 (lambda (f) (lambda (x) x)))
;;(lambda (f) (lambda (x) (f (((lambda (f) (lambda (x) x)) f) x))))
;;(lambda (f) (lambda (x) (f ((lambda (x) x) x))))
;;(lambda (f) (lambda (x) (f x)))

(define one (lambda (f) (lambda (x) (f x))))

(define +
    (lambda (m)
        (lambda (n)
            (lambda (f)
                (lambda (x)
                    (m f (n f x)))))))


(define (add-interval x y)
  (make-interval (+ (lower-bound x) (lower-bound y))
                 (+ (upper-bound x) (upper-bound y))))

(define (mul-interval x y)
  (let ((p1 (* (lower-bound x) (lower-bound y)))
        (p2 (* (lower-bound x) (upper-bound y)))
        (p3 (* (upper-bound x) (lower-bound y)))
        (p4 (* (upper-bound x) (upper-bound y))))
    (make-interval (min p1 p2 p3 p4)
                   (max p1 p2 p3 p4))))

(define (div-interval x y)
  (mul-interval x
                (make-interval (/ 1.0 (upper-bound y))
                               (/ 1.0 (lower-bound y)))))

;; 2.7
(define (make-interval a b) (cons a b))

(define (upper-bound x)
    (max (car x) (cdr x)))

(define (lower-bound x)
    (min (car x) (cdr x)))
;;2.8
(define (sub-interval x y)
    (make-interval (- (lower-bound x) (upper-bound y))
                   (- (upper-bound x) (lower-bound y))))

;; 2.10
(define (div-interval1 x y)
    (if (> (* (lower-bound y) (upper-bound y)) 0)
        (mul-interval x
                      (make-interval (/ 1.0 (upper-bound y))
                                     (/ 1.0 (lower-bound y))))
        (error "dividing by an interval containing zero" y)))

;; 2.11
(define (mul-interval1 x y)
    (if (> (lower-bound x) 0)
        (if (> (lower-bound y) 0)
            (make-interval (* (lower-bound x) (lower-bound y))
                           (* (upper-bound x) (upper-bound y)))
            (if (> (upper-bound y) 0)
                (make-interval (* (upper-bound x) (lower-bound y))
                               (* (upper-bound x) (upper-bound y)))
                (make-interval (* (upper-bound x) (lower-bound y))
                               (* (lower-bound x) (upper-bound y)))))
        (if (> (upper-bound x) 0)
            (if (> (lower-bound y) 0)
                (make-interval (* (lower-bound x) (upper-bound y))
                               (* (upper-bound x) (upper-bound y)))
                (if (> (upper-bound y) 0)
                    (make-interval (min (* (upper-bound x) (lower-bound y))
                                        (* (lower-bound x) (upper-bound y)))
                                   (max (* (lower-bound x) (lower-bound y))
                                        (* (upper-bound x) (upper-bound y))))
                    (make-interval (* (upper-bound x) (lower-bound y))
                                   (* (lower-bound x) (lower-bound y)))))
            (if (> (lower-bound y) 0)
                (make-interval (* (lower-bound x) (upper-bound y))
                               (* (upper-bound x) (lower-bound y)))
                (if (> (upper-bound y) 0)
                    (make-interval (* (upper-bound x) (upper-bound y))
                                   (* (upper-bound x) (lower-bound y)))
                    (make-interval (* (lower-bound x) (lower-bound y))
                                   (* (upper-bound x) (upper-bound y))))))))

;; 2.12
(define (make-center-width c w)
    (make-interval (- c w) (+ c w)))

(define (center i)
    (/ (+ (lower-bound i) (upper-bound i)) 2))

(define (width i)
    (/ (- (upper-bound i) (lower-bound i)) 2))

(define (make-center-percent c p)
    (make-center-width c (* c p)))

(define (percent i)
    (/ (width i) (center i)))