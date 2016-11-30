#lang sicp

(define (memq item x)
  (cond ((null? x) false)
        ((eq? item (car x)) x)
        (else (memq item (cdr x)))))

;;(memq 'apple '(pear banana prune))

;;(memq 'apple '(x (apple sauce) y apple pear))
;; 2.53
;;(list 'a 'b 'c)
;;(list (list 'george))
;;(cdr '((x1 x2) (y1 y2)))
;;(cadr '((x1 x2) (y1 y2)))
;;(pair? (car '(a short list)))
;;(memq 'red '((red shoes) blue socks))
;;(memq 'red '(red shoes blue socks))

;;; 54-equal.scm

(define (equal? x y)
    (cond ((and (symbol? x) (symbol? y))
            (symbol-equal? x y))
          ((and (list? x) (list? y))
            (list-equal? x y))
          (else
            (display "Wrong type input x and y -- EQUAL?" x y))))

(define (symbol-equal? x y)
    (eq? x y))

(define (list-equal? x y)
    (cond ((and (null? x) (null? y))    ; 空表
            #t)
          ((or (null? x) (null? y))     ; 长度不同的表
            #f)
          ((equal? (car x) (car y))     ; 对比 car 部分
            (equal? (cdr x) (cdr y)))   ; 递归对比 cdr 部分
          (else
            #f)))

;; 2.55
;;根据 97 页的注释 100 ,符号 ' 在求值时会被替换成 quote 特殊形式,因此,求值:

;;(car ''abracadabra)
;;实际上就是求值：

;;(car '(quote abracadabra))
;;因此 car 取出的是第一个 quote 的 car 部分，而这个 car 部分就是 'quote ，所以返回值就是 quote ：


;;;SECTION 2.3.2

(define (deriv exp var)
  (cond ((number? exp) 0)
        ((variable? exp)
         (if (same-variable? exp var) 1 0))
        ((sum? exp)
         (make-sum (deriv (addend exp) var)
                   (deriv (augend exp) var)))
        ((product? exp)
         (make-sum
           (make-product (multiplier exp)
                         (deriv (multiplicand exp) var))
           (make-product (deriv (multiplier exp) var)
                         (multiplicand exp))))
        ((exponentiation? exp)                                    ; 新增
            (let ((n (exponent exp))                                ;
                  (u (base exp)))                                   ;
                (make-product                                       ;
                    n                                               ;
                    (make-product                                   ;
                        (make-exponentiation                        ;
                            u                                       ;
                            (- n 1))                                ;
                        (deriv u var)))))  
        (else
         (display "unknown expression type -- DERIV" exp))))

;; representing algebraic expressions

(define (variable? x) (symbol? x))

(define (same-variable? v1 v2)
  (and (variable? v1) (variable? v2) (eq? v1 v2)))

;;(define (make-sum a1 a2) (list '+ a1 a2))

;;(define (make-product m1 m2) (list '* m1 m2))

(define (sum? x)
  (and (pair? x) (eq? (car x) '+)))

(define (addend s) (cadr s))

(define (augend s) (caddr s))

(define (product? x)
  (and (pair? x) (eq? (car x) '*)))

(define (multiplier p) (cadr p))

(define (multiplicand p) (caddr p))

;: (deriv '(+ x 3) 'x)
;: (deriv '(* x y) 'x)
;: (deriv '(* (* x y) (+ x 3)) 'x)

;; With simplification

(define (make-sum a1 a2)
  (cond ((=number? a1 0) a2)
        ((=number? a2 0) a1)
        ((and (number? a1) (number? a2)) (+ a1 a2))
        (else (list '+ a1 a2))))

(define (=number? exp num)
  (and (number? exp) (= exp num)))

(define (make-product m1 m2)
  (cond ((or (=number? m1 0) (=number? m2 0)) 0)
        ((=number? m1 1) m2)
        ((=number? m2 1) m1)
        ((and (number? m1) (number? m2)) (* m1 m2))
        (else (list '* m1 m2))))

;; 2.56

(define (make-exponentiation base exponent)                         ; 新增
    (cond ((= exponent 0)                                           ;
            1)                                                      ;
          ((= exponent 1)                                           ;
            base)                                                   ;
          (else                                                     ;
            (list '** base exponent))))                             ;
                                                                    ;
(define (exponentiation? x)                                         ;
    (and (pair? x)                                                  ;
        (eq? (car x) '**)))                                         ;
                                                                    ;
(define (base exp)                                                  ;
    (cadr exp))                                                     ;
                                                                    ;
(define (exponent exp)                                              ;
    (caddr exp))                                                    ;


;; 2.57
(define (make-sum a1 . a2)
    (if (single-operand? a2)
        (let ((a2 (car a2)))
            (cond ((=number? a1 0)
                    a2)
                  ((=number? a2 0)
                    a1)
                  ((and (number? a1) (number? a2))
                    (+ a1 a2))
                  (else
                    (list '+ a1 a2))))
        (cons '+ (cons a1 a2))))

(define (sum? x)
    (and (pair? x)
         (eq? (car x) '+)))

(define (addend s)
    (cadr s))

(define (augend s)
    (let ((tail-operand (cddr s)))
        (if (single-operand? tail-operand)
            (car tail-operand)
            (apply make-sum tail-operand))))


(define (make-product m1 . m2)
    (if (single-operand? m2)
        (let ((m2 (car m2)))
            (cond ((or (=number? m1 0) (=number? m2 0))
                    0)
                  ((=number? m1 1)
                    m2)
                  ((=number? m2 1)
                    m1)
                  ((and (number? m1) (number? m2))
                    (* m1 m2))
                  (else
                    (list '* m1 m2))))
        (cons '* (cons m1 m2))))

(define (product? x)
    (and (pair? x)
         (eq? (car x) '*)))

(define (multiplier p)
    (cadr p))

(define (multiplicand p)
    (let ((tail-operand (cddr p)))
        (if (single-operand? tail-operand)
            (car tail-operand)
            (apply make-product tail-operand))))

;; 2.58
;;; 58-sum.scm

(define (make-sum a1 a2)
    (cond ((=number? a1 0)
            a2)
          ((=number? a2 0)
            a1)
          ((and (number? a1) (number? a2))
            (+ a1 a2))
          (else
            (list a1 '+ a2))))              ; 修改

(define (sum? x)
    (and (pair? x)
         (eq? (cadr x) '+)))                ; 修改

(define (addend s)
    (car s))                                ; 修改

(define (augend s)
    (caddr s))


(define (make-product m1 m2)
    (cond ((or (=number? m1 0) (=number? m2 0))
            0)
          ((=number? m1 1)
            m2)
          ((=number? m2 1)
            m1)
          ((and (number? m1) (number? m2))
            (* m1 m2))
          (else
            (list m1 '* m2))))              ; 修改

(define (product? x)
    (and (pair? x)
         (eq? (cadr x) '*)))                ; 修改

(define (multiplier p)
    (car p))                                ; 修改

(define (multiplicand p)
    (caddr p))