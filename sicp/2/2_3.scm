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

(define (equal?2 x y)
    (cond ((and (symbol? x) (symbol? y))
            (symbol-equal? x y))
          ((and (list? x) (list? y))
            (list-equal? x y))
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
(define single-operand? 1)
(define (make-sum2 a1 . a2)
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

(define (sum?2 x)
    (and (pair? x)
         (eq? (car x) '+)))

(define (addend2 s)
    (cadr s))

(define (augend2 s)
    (let ((tail-operand (cddr s)))
        (if (single-operand? tail-operand)
            (car tail-operand)
            (apply make-sum tail-operand))))


(define (make-product2 m1 . m2)
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

(define (product?2 x)
    (and (pair? x)
         (eq? (car x) '*)))

(define (multiplier2 p)
    (cadr p))

(define (multiplicand2 p)
    (let ((tail-operand (cddr p)))
        (if (single-operand? tail-operand)
            (car tail-operand)
            (apply make-product tail-operand))))

;; 2.58
;;; 58-sum.scm

(define (make-sum3 a1 a2)
    (cond ((=number? a1 0)
            a2)
          ((=number? a2 0)
            a1)
          ((and (number? a1) (number? a2))
            (+ a1 a2))
          (else
            (list a1 '+ a2))))              ; 修改

(define (sum?3 x)
    (and (pair? x)
         (eq? (cadr x) '+)))                ; 修改

(define (addend3 s)
    (car s))                                ; 修改

(define (augend3 s)
    (caddr s))


(define (make-product3 m1 m2)
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

(define (product?3 x)
    (and (pair? x)
         (eq? (cadr x) '*)))                ; 修改

(define (multiplie3r p)
    (car p))                                ; 修改

(define (multiplicand3 p)
    (caddr p))


;; 2.3.3
(define (element-of-set? x set)
  (cond ((null? set) false)
        ((equal? x (car set)) true)
        (else (element-of-set? x (cdr set)))))

(define (adjoin-set x set)
  (if (element-of-set? x set)
      set
      (cons x set)))

(define (intersection-set set1 set2)
  (cond ((or (null? set1) (null? set2)) '())
        ((element-of-set? (car set1) set2)
         (cons (car set1)
               (intersection-set (cdr set1) set2)))
        (else (intersection-set (cdr set1) set2))))



(define (union-set set1 set2)
    (iter (append set1 set2) '()))

(define (iter input result)
    (if (null? input)
        (reverse result)
        (let ((current-element (car input))
              (remain-element (cdr input)))
            (if (element-of-set? current-element result)
                (iter remain-element result)
                (iter remain-element
                      (cons current-element result))))))

;; 2.60
(define (adjoin-set2 x set)
    (cons x set))

(define (intersection-set2 set another)
    (define (iter set result)
        (if (or (null? set) (null? another))
            (reverse result)
            (let ((current-element (car set))
                  (remain-element (cdr set)))
                (if (and (element-of-set? current-element another)
                         (not (element-of-set? current-element result)))
                    (iter remain-element
                          (cons current-element result))
                    (iter remain-element result)))))
    (iter set '()))

;; if set is order
(define (intersection-set3 set1 set2)
  (if (or (null? set1) (null? set2))
      '()
      (let ((x1 (car set1)) (x2 (car set2)))
        (cond ((= x1 x2)
               (cons x1
                     (intersection-set (cdr set1)
                                       (cdr set2))))
              ((< x1 x2)
               (intersection-set (cdr set1) set2))
              ((< x2 x1)
               (intersection-set set1 (cdr set2)))))))
;; 2.61
(define (adjoin-set3 x set)
    (if (null? set)
        (list x)
        (let ((current-element (car set))
              (remain-element (cdr set)))
            (cond ((= x current-element)
                    set)
                  ((> x current-element)
                    (cons current-element
                          (adjoin-set x remain-element)))
                  ((< x current-element)
                    (cons x set))))))

;; 2.62
(define (union-set2 set another)
    (cond ((and (null? set) (null? another))
            '())
          ((null? set)
            another)
          ((null? another)
            set)
          (else
            (let ((x (car set)) (y (car another)))
                (cond ((= x y)
                        (cons x (union-set (cdr set) (cdr another))))
                      ((< x y)
                        (cons x (union-set (cdr set) another)))
                      ((> x y)
                        (cons y (union-set set (cdr another)))))))))


;; 2.63
(define (tree->list-1 tree)
    (if (null? tree)
        '()
        (append (tree->list-1 (left-branch tree))
                (cons (entry tree)
                      (tree->list-1 (right-branch tree))))))

(define (tree->list-2 tree)
    (define (copy-to-list tree result-list)
        (if (null? tree)
            result-list
            (copy-to-list (left-branch tree)
                          (cons (entry tree)
                                (copy-to-list (right-branch tree)
                                              result-list)))))
    (copy-to-list tree '()))

(define (entry tree) (car tree))

(define (left-branch tree) (cadr tree))

(define (right-branch tree) (caddr tree))

(define (make-tree entry left right)
  (list entry left right))

(define (element-of-set?4 x set)
  (cond ((null? set) false)
        ((= x (entry set)) true)
        ((< x (entry set))
         (element-of-set? x (left-branch set)))
        ((> x (entry set))
         (element-of-set? x (right-branch set)))))

(define (adjoin-set4 x set)
  (cond ((null? set) (make-tree x '() '()))
        ((= x (entry set)) set)
        ((< x (entry set))
         (make-tree (entry set) 
                    (adjoin-set4 x (left-branch set))
                    (right-branch set)))
        ((> x (entry set))
         (make-tree (entry set)
                    (left-branch set)
                    (adjoin-set4 x (right-branch set))))))

;; 2.64
(define (list->tree elements)
    (car (partial-tree elements (length elements))))

(define (partial-tree elts n)
    (if (= n 0)
        (cons '() elts)
        (let ((left-size (quotient (- n 1) 2)))
            (let ((left-result (partial-tree elts left-size)))
                (let ((left-tree (car left-result))
                      (non-left-elts (cdr left-result))
                      (right-size (- n (+ left-size 1))))
                    (let ((this-entry (car non-left-elts))
                          (right-result (partial-tree (cdr non-left-elts)
                                                      right-size)))
                        (let ((right-tree (car right-result))
                              (remaining-elts (cdr right-result)))
                            (cons (make-tree this-entry left-tree right-tree)
                                  remaining-elts))))))))

;; 2.65
(define (intersection-tree tree another)
    (list->tree
        (intersection-set (tree->list-2 tree)
                          (tree->list-2 another))))


(define (union-tree tree another)
    (list->tree
        (union-set (tree->list-2 tree)
                   (tree->list-2 another))))

;;; 66-lookup.scm
(define key 1)
(define (lookup given-key tree-of-records)
    (if (null? tree-of-records)                                             ; 数据库为空，查找失败
        #f
        (let ((entry-key (key (entry tree-of-records))))                    ; 获取当前节点的键
            (cond ((= given-key entry-key)                                  ; 对比当前节点的键和给定的查找键
                    (entry tree-of-records))                                ; 决定查找的方向
                  ((> given-key entry-key)
                    (lookup given-key (right-branch tree-of-records)))
                  ((< given-key entry-key)
                    (lookup given-key (left-branch tree-of-records)))))))


(define (make-leaf symbol weight)
  (list 'leaf symbol weight))

(define (leaf? object)
  (eq? (car object) 'leaf))

(define (symbol-leaf x) (cadr x))
(define (weight-leaf x) (caddr x))

(define (symbols tree)
  (if (leaf? tree)
      (list (symbol-leaf tree))
      (caddr tree)))

(define (weight tree)
  (if (leaf? tree)
      (weight-leaf tree)
      (cadddr tree)))

(define (make-code-tree left right)
  (list left
        right
        (append (symbols left) (symbols right))
        (+ (weight left) (weight right))))


(define (left-branch2 tree) (car tree))
(define (right-branch2 tree) (cadr tree))

(define (decode bits tree)
  (define (decode-1 bits current-branch)
    (if (null? bits)
        '()
        (let ((next-branch
               (choose-branch (car bits) current-branch)))
          (if (leaf? next-branch)
              (cons (symbol-leaf next-branch)
                    (decode-1 (cdr bits) tree))
              (decode-1 (cdr bits) next-branch)))))
  (decode-1 bits tree))

(define (choose-branch bit branch)
  (cond ((= bit 0) (left-branch2 branch))
        ((= bit 1) (right-branch2 branch))
        (else (display "bad bit -- CHOOSE_BRANCH" bit))))

(define (adjoin-set5 x set)
  (cond ((null? set) (list x))
        ((< (weight x) (weight (car set))) (cons x set))
        (else (cons (car set)
                    (adjoin-set5 x (cdr set))))))

(define sample-tree
  (make-code-tree (make-leaf 'A 4)
                  (make-code-tree
                   (make-leaf 'B 2)
                   (make-code-tree (make-leaf 'D 1)
                                   (make-leaf 'C 1)))))
                                                        
(define sample-message '(0 1 1 0 0 1 0 1 0 1 1 1 0))


;; 2.67
;;(decode sample-message sample-tree)

;; 2.68
(define (encode message tree)
  (if (null? message)
      '()
      (append (encode-symbol (car message) tree)
              (encode (cdr message) tree))))

(define (encode-symbol x) x)


