#lang planet neil/sicp
(define (square x) (* x x))

;(define (add-complex z1 z2)
  ;(make-from-real-imag (+ (real-part z1) (real-part z2))
                       ;(+ (imag-part z1) (imag-part z2))))

;(define (sub-complex z1 z2)
  ;(make-from-real-imag (- (real-part z1) (real-part z2))
                       ;(- (imag-part z1) (imag-part z2))))

;(define (mul-complex z1 z2)
  ;(make-from-mag-ang (* (magnitude z1) (magnitude z2))
                     ;(+ (angle z1) (angle z2))))

;(define (div-complex z1 z2)
  ;(make-from-mag-ang (/ (magnitude z1) (magnitude z2))
                     ;(- (angle z1) (angle z2))))


;; Ben (rectangular)
;(define (real-part z) (car z))

;(define (imag-part z) (cdr z))

;(define (magnitude z)
  ;(sqrt (+ (square (real-part z)) (square (imag-part z)))))

;(define (angle z)
  ;(atan (imag-part z) (real-part z)))

;(define (make-from-real-imag x y) (cons x y))

;(define (make-from-mag-ang r a) 
  ;(cons (* r (cos a)) (* r (sin a))))


;; Alyssa (polar)

;(define (real-part z)
  ;(* (magnitude z) (cos (angle z))))

;(define (imag-part z)
  ;(* (magnitude z) (sin (angle z))))

;(define (magnitude z) (car z))

;(define (angle z) (cdr z))

;(define (make-from-real-imag x y) 
  ;(cons (sqrt (+ (square x) (square y)))
        ;(atan y x)))

;(define (make-from-mag-ang r a) (cons r a))


;;;SECTION 2.4.2

(define (attach-tag type-tag contents)
  (cons type-tag contents))

(define (type-tag datum)
  (if (pair? datum)
      (car datum)
      (error "Bad tagged datum -- TYPE-TAG" datum)))

(define (contents datum)
  (if (pair? datum)
      (cdr datum)
      (error "Bad tagged datum -- CONTENTS" datum)))

(define (rectangular? z)
  (eq? (type-tag z) 'rectangular))

(define (polar? z)
  (eq? (type-tag z) 'polar))

;; Ben (rectangular)

(define (real-part-rectangular z) (car z))

(define (imag-part-rectangular z) (cdr z))

(define (magnitude-rectangular z)
  (sqrt (+ (square (real-part-rectangular z))
           (square (imag-part-rectangular z)))))

(define (angle-rectangular z)
  (atan (imag-part-rectangular z)
        (real-part-rectangular z)))

(define (make-from-real-imag-rectangular x y)
  (attach-tag 'rectangular (cons x y)))

(define (make-from-mag-ang-rectangular r a) 
  (attach-tag 'rectangular
              (cons (* r (cos a)) (* r (sin a)))))

;; Alyssa (polar)

(define (real-part-polar z)
  (* (magnitude-polar z) (cos (angle-polar z))))

(define (imag-part-polar z)
  (* (magnitude-polar z) (sin (angle-polar z))))

(define (magnitude-polar z) (car z))

(define (angle-polar z) (cdr z))

(define (make-from-real-imag-polar x y) 
  (attach-tag 'polar
               (cons (sqrt (+ (square x) (square y)))
                     (atan y x))))

(define (make-from-mag-ang-polar r a)
  (attach-tag 'polar (cons r a)))


;; Generic selectors

(define (real-part z)
  (cond ((rectangular? z) 
         (real-part-rectangular (contents z)))
        ((polar? z)
         (real-part-polar (contents z)))
        (else (error "Unknown type -- REAL-PART" z))))

(define (imag-part z)
  (cond ((rectangular? z)
         (imag-part-rectangular (contents z)))
        ((polar? z)
         (imag-part-polar (contents z)))
        (else (error "Unknown type -- IMAG-PART" z))))

(define (magnitude z)
  (cond ((rectangular? z)
         (magnitude-rectangular (contents z)))
        ((polar? z)
         (magnitude-polar (contents z)))
        (else (error "Unknown type -- MAGNITUDE" z))))

(define (angle z)
  (cond ((rectangular? z)
         (angle-rectangular (contents z)))
        ((polar? z)
         (angle-polar (contents z)))
        (else (error "Unknown type -- ANGLE" z))))

;; same as before
(define (add-complex z1 z2)
  (make-from-real-imag (+ (real-part z1) (real-part z2))
                       (+ (imag-part z1) (imag-part z2))))

;; Constructors for complex numbers

(define (make-from-real-imag x y)
  (make-from-real-imag-rectangular x y))

(define (make-from-mag-ang r a)
  (make-from-mag-ang-polar r a))



(define (install-rectangular-package)
  ;; internal procedures
  (define (real-part z) (car z))
  (define (imag-part z) (cdr z))
  (define (make-from-real-imag x y) (cons x y))
  (define (magnitude z)
    (sqrt (+ (square (real-part z))
             (square (imag-part z)))))
  (define (angle z)
    (atan (imag-part z) (real-part z)))
  (define (make-from-mag-ang r a) 
    (cons (* r (cos a)) (* r (sin a))))

  ;; interface to the rest of the system
  (define (tag x) (attach-tag 'rectangular x))
  (put 'real-part '(rectangular) real-part)
  (put 'imag-part '(rectangular) imag-part)
  (put 'magnitude '(rectangular) magnitude)
  (put 'angle '(rectangular) angle)
  (put 'make-from-real-imag 'rectangular
       (lambda (x y) (tag (make-from-real-imag x y))))
  (put 'make-from-mag-ang 'rectangular
       (lambda (r a) (tag (make-from-mag-ang r a))))
  'done)

(define (install-polar-package)
  ;; internal procedures
  (define (magnitude z) (car z))
  (define (angle z) (cdr z))
  (define (make-from-mag-ang r a) (cons r a))
  (define (real-part z)
    (* (magnitude z) (cos (angle z))))
  (define (imag-part z)
    (* (magnitude z) (sin (angle z))))
  (define (make-from-real-imag x y) 
    (cons (sqrt (+ (square x) (square y)))
          (atan y x)))

  ;; interface to the rest of the system
  (define (tag x) (attach-tag 'polar x))
  (put 'real-part '(polar) real-part)
  (put 'imag-part '(polar) imag-part)
  (put 'magnitude '(polar) magnitude)
  (put 'angle '(polar) angle)
  (put 'make-from-real-imag 'polar
       (lambda (x y) (tag (make-from-real-imag x y))))
  (put 'make-from-mag-ang 'polar
       (lambda (r a) (tag (make-from-mag-ang r a))))
  'done)

;;footnote
;: (apply + (list 1 2 3 4))


(define (apply-generic op . args)
  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tags)))
      (if proc
          (apply proc (map contents args))
          (error
            "No method for these types -- APPLY-GENERIC"
            (list op type-tags))))))

;; Generic selectors

(define (real-part z) (apply-generic 'real-part z))
(define (imag-part z) (apply-generic 'imag-part z))
(define (magnitude z) (apply-generic 'magnitude z))
(define (angle z) (apply-generic 'angle z))


;; Constructors for complex numbers

(define (make-from-real-imag x y)
  ((get 'make-from-real-imag 'rectangular) x y))

(define (make-from-mag-ang r a)
  ((get 'make-from-mag-ang 'polar) r a))






(define (make-from-real-imag x y)
  (define (dispatch op)
    (cond ((eq? op 'real-part) x)
          ((eq? op 'imag-part) y)
          ((eq? op 'magnitude)
           (sqrt (+ (square x) (square y))))
          ((eq? op 'angle) (atan y x))
          (else
           (error "Unknown op -- MAKE-FROM-REAL-IMAG" op))))
  dispatch)

(define (apply-generic op arg) (arg op))

;; 2.75
(define (make-from-mag-ang x y)
    (define (dispatch op)
        (cond ((eq? op 'real-part)
                (* x (cos y)))
              ((eq? op 'imag-part)
                (* x (sin y)))
              ((eq? op 'magnitude)
                x)
              ((eq? op 'angle)
                y)
              (else
                (error "Unkonw op  -- MAKE-FROM-MAG-ANG" op))))
    dispatch)



;练习 2.76
;显式分派：
;这种策略在增加新操作时需要使用者避免命名冲突，而且每当增加新类型时，所有通用操作都需要做相应的改动，这种策略不具有可加性，因此无论是增加新操作还是增加新类型，这种策略都不适合。

;数据导向：数据导向可以很方便地通过包机制增加新类型和新的通用操作，因此无论是增加新类型还是增加新操作，这种策略都很适合。

;消息传递：消息传递将数据对象和数据对象所需的操作整合在一起，因此它可以很方便地增加新类型，但是这种策略不适合增加新操作，因为每次为某个数据对象增加新操作之后，这个数据对象已有的实例全部都要重新实例化才能使用新操作。

;; 2.73
(define (install-sum-package)

    ;;; internal procedures 
    (define (addend s)
        (car s))

    (define (augend s)
        (cadr s))

    (define (make-sum x y)
        (cond ((=number? x 0)
                y)
              ((=number? y 0)
                x)
              ((and (number? x) (number? y))
                (+ x y))
              (else
                (attach-tag '+ x y))))

    ;;; interface to the rest of the system
    (put 'addend '+ addend)
    (put 'augend '+ augend)
    (put 'make-sum '+ make-sum)

    (put 'deriv '+
        (lambda (exp var)
            (make-sum (deriv (addend exp) var)
                      (deriv (augend exp) var))))

'done)

(define (make-sum x y)
    ((get 'make-sum '+) x y))

(define (addend sum)
    ((get 'addend '+) (contents sum)))

(define (augend sum)
    ((get 'augend '+) (contents sum)))
