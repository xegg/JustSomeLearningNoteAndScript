#lang sicp
(define (list-ref items n)
  (if (= n 0)
    (car items)
    (list-ref (cdr items) (- n 1))))

(define (length items)
  (if (null? items)
    0
    (+ 1 (length (cdr items)))))

(define (append list1 list2)
  (if (null? list1)
    list2
    (cons (car list1) (append (cdr list1) list2))))

;; 2.17
(define (last-pair items)
    (if (null? (cdr items))
        items
        (last-pair (cdr items))))

;; 2.18
(define (reverse items)
    (define (reverse-iter items rev-items)
        (if (null? items)
            rev-items
            (reverse-iter (cdr items) (cons (car items) rev-items))))
    (reverse-iter items '()))

;; 2.19
(define (first-denomination coin-values)
    (car coin-values))

(define (except-first-denomination coin-values)
    (cdr coin-values))

(define (no-more? coin-values)
    (null? coin-values))


(define (cc amount coin-values)
    (cond ((= amount 0)
            1)
          ((or (< amount 0) (no-more? coin-values))
            0)
          (else
            (+ (cc amount
                   (except-first-denomination coin-values))
               (cc (- amount
                      (first-denomination coin-values)))
                                  
                   coin-values))))
;; 2.20
(define (same-parity x . y)
    (let ((parity (if (odd? x) odd? even?)))
        (define (same-parity-with-list x ls)
            (if (null? ls)
                '()
                (if (parity (car ls))
                    (cons (car ls) (same-parity-with-list x (cdr ls)))
                    (same-parity-with-list x (cdr ls)))))
        (if (null? y)
            (list x)
            (cons x (same-parity-with-list x y)))))


;; 2.21
(define (square x)
  (* x x))

(define (square-list items)
    (if (null? items)
        nil
        (cons (square (car items)) (square-list (cdr items)))))

(define (square-list1 items)
    (map square items))

;; 2.22
(define (square-list2 items)
    (define (iter things answer)
        (if (null? things)
            answer
            (iter (cdr things)  
                  (cons (square (car things))
                        answer))))
    (iter (reverse items) '()))  ; 修改

;; 2.23
(define (for-each p lst)
    (if (not (null? lst))
        (begin
            (p (car lst))
            (for-each p (cdr lst)))))

;; 2.24
(define (count-leaves x)
  (cond ((null? x) 0)
        ((not (pair? x)) 1)
        (else (+ (count-leaves (car x))
                 (count-leaves (cdr x))))))
;; 2.27
(define (tree-reverse lst)
    (define (iter remained-items result)
        (if (null? remained-items)
            result
            (iter (cdr remained-items)
                  (cons (if (pair? (car remained-items))
                            (tree-reverse (car remained-items))
                            (car remained-items))
                        result))))
    (iter lst '()))


;; 2.28

(define (fringe tree)
    (cond ((null? tree)                         ; 空树
            '())
          ((not (pair? tree))                   ; 叶子
            (list tree))
          (else
            (append (fringe (car tree))         ; 累积左子树所有元素
                    (fringe (cadr tree))))))    ; 累积右子树所有元素

;; 2.29
(define (make-mobile left right)
    (list left right))

(define (make-branch length structure)
    (list length structure))


(define (left-branch mobile)
    (car mobile))

(define (right-branch mobile)
    (cadr mobile))



(define (branch-length branch)
    (car branch))

(define (branch-structure branch)
    (cadr branch))


(define (total-weight mobile)
    (+ (branch-weight (left-branch mobile))         ; 计算左右两个分支的重量之和
       (branch-weight (right-branch mobile))))

(define (branch-weight branch)
    (if (hangs-another-mobile? branch)              ; 如果分支吊着另一个活动体
        (total-weight (branch-structure branch))    ; 那么这个活动体的总重量就是这个分支的重量
        (branch-structure branch)))                 ; 否则, 分支的 structure 部分就是分支的重量

(define (hangs-another-mobile? branch)              ; 检查分支是否吊着另一个活动体
    (pair? (branch-structure branch)))

(define (branch-torque branch)
    (* (branch-length branch)
       (branch-weight branch)))



(define (mobile-balance? mobile)
    (let ((left (left-branch mobile))
          (right (right-branch mobile)))
        (and                                        ; 必须同时满足以下三个条件,才是平衡的活动体
            (same-torque? left right)
            (branch-balance? left)
            (branch-balance? right))))

(define (same-torque? left right)
    (= (branch-torque left)
       (branch-torque right)))

(define (branch-balance? branch)
    (if (hangs-another-mobile? branch)              ; 如果分支上有子活动体
        (mobile-balance? (branch-structure branch))  ; 那么(递归地)检查子活动体的平衡性
        #t))                                        ; 否则，返回 #t

