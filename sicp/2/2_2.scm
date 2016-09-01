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


(define (scale-tree tree factor)
  (cond ((null? tree) nil)
        ((not (pair? tree)) (* tree factor))
        (else (cons (scale-tree (car tree) factor)
                    (scale-tree (cdr tree) factor)))))

(define (scale-tree1 tree factor)
  (map (lambda (sub-tree)
         (if (pair? sub-tree)
           (scale-tree sub-tree factor)
           (* sub-tree factor)))
         tree))

;; 2.30
(define (square-tree tree)
    (cond ((null? tree)                         ; 空树
            '())
          ((not (pair? tree))                   ; 叶子节点
            (square tree))
          (else 
            (cons (square-tree (car tree))
                  (square-tree (cdr tree))))))

(define (square-tree1 tree)
    (map (lambda (sub-tree)
             (if (pair? sub-tree)           ; 如果有左右子树
                 (square-tree sub-tree)     ; 那么递归地处理它们
                 (square sub-tree)))
         tree))
;; 2.31
(define (tree-map f tree)
    (cond ((null? tree)                         ; 空树
            '())
          ((not (pair? tree))                   ; 叶子节点
            (f tree))
          (else
            (cons (tree-map f (car tree))       ; 递归处理左右子树
                  (tree-map f (cdr tree))))))

;; 2.32
(define (subsets s)
    (if (null? s)
        (list '())
        (let ((rest (subsets (cdr s))))
            (append rest (map (lambda (x)
                                (cons (car s) x))
                              rest)))))


(define (sum-odd-squares tree)
  (cond ((null? tree) 0)
        ((not (pair? tree))
         (if (odd? tree) (square tree) 0))
        (else (+ (sum-odd-squares (car tree))
                 (sum-odd-squares (cdr tree))))))

(define (fib n)
  (cond ((= n 0) 0)
        ((= n 1) 1)
        ((= n 2) 1)
        (else (+ (fib (- n 1))
                 (fib (- n 2))))))

(define (even-fibs n)
  (define (next k)
    (if (> k n)
        nil
        (let ((f (fib k)))
          (if (even? f)
              (cons f (next (+ k 1)))
              (next (+ k 1))))))
    (next 0))

(define (filter predicate sequence)
  (cond ((null? sequence) nil)
        ((predicate (car sequence))
         (cons (car sequence)
               (filter predicate (cdr sequence))))
        (else (filter predicate (cdr sequence)))))


(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))

(define (enumerate-interval low high)
  (if (> low high)
      nil
      (cons low (enumerate-interval (+ low 1) high))))

(define (enumerate-tree tree)
  (cond ((null? tree) nil)
        ((not (pair? tree)) (list tree))
        (else (append (enumerate-tree (car tree))
                      (enumerate-tree (cdr tree))))))

(define (sum-odd-squares2 tree)
  (accumulate +
              0
              (map square
                   (filter odd?
                           (enumerate-tree tree)))))


(define (even-fibs1 n)
  (accumulate cons
              nil
              (filter even?
                      (map fib
                           (enumerate-interval 0 n)))))

(define (list-fib-squares n)
  (accumulate cons
              nil
              (map square
                   (map fib
                        (enumerate-interval 0 n)))))

;; 2.34
(define (horner-eval x coefficient-sequence)
    (accumulate (lambda (this-coeff higher-terms)
                    (+ this-coeff (* x higher-terms)))
                0
                coefficient-sequence))

;; 2.35

(define (count-leaves1 tree)
    (accumulate +
                0
                (map (lambda (sub-tree)
                         (if (pair? sub-tree)           ; 如果这个节点有分支
                             (count-leaves sub-tree)    ; 那么这个节点调用 count-leaves 的结果就是这个节点的树叶数量
                             1))                        ; 遇上一个叶子节点就返回 1
                     tree)))

;; 2.36
(define (car-n seqs)
    (map car seqs))

(define (cdr-n seqs)
    (map cdr seqs))

(define (accumulate-n op init seqs)
    (if (null? (car seqs))
        '()
        (cons (accumulate op init (car-n seqs))
              (accumulate-n op init (cdr-n seqs)))))


;; 2.37
(define (dot-product v w)
  (accumulate + 0 (map * v w)))

(define (matrix-*-vector m v)
    (map (lambda (col)
             (dot-product col v))
         m))

(define (transpose m)
    (accumulate-n cons '() m))


(define (matrix-*-matrix m n)
    (let ((cols (transpose n)))
        (map (lambda (col-of-m)
                 (map (lambda (col-of-cols)
                          (dot-product col-of-m 
                                       col-of-cols))
                      cols))
             m)))

(define (matrix-*-matrix1 m n)
    (let ((trans-n (transpose n)))
        (map (lambda (col-of-m)
                (matrix-*-vector trans-n col-of-m))
                m)))

;; 2.38
(define (fold-left op initial sequence)
    (define (iter result rest)
        (if (null? rest)
            result
            (iter (op result (car rest))
                  (cdr rest))))
    (iter initial sequence))

(define fold-right accumulate)



;;
(define (smallest-devisor n)
  (find-divisor n 2))

(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
        ((devides? test-divisor n) test-divisor)
        (else (find-divisor n (+ test-divisor 1)))))

(define (devides? a b)
  (= (remainder b a ) 0))

(define (prime? n)
  (= n (smallest-devisor n)))

(define (flatmap proc seq)
  (accumulate append nil (map proc seq)))

(define (prime-sum? pair)
  (prime? (+ (car pair) (cadr pair))))

(define (make-pair-sum pair)
  (list (car pair) (cadr pair) (+ (car pair) (cadr pair))))

(define (prime-sum-pairs n)
  (map make-pair-sum
       (filter prime-sum?
               (flatmap
                (lambda (i)
                  (map (lambda (j) (list i j))
                       (enumerate-interval 1 (- i 1))))
                  (enumerate-interval 1 n)))))

(define (permutations s)
  (if (null? s)
      (list nil)
      (flatmap (lambda (x)
                 (map (lambda (p) (cons x p))
                      (permutations (remove x s))))
               s)))

(define (remove item sequence)
  (filter (lambda (x) (not (= x item)))
          sequence))

;; 2.40

(define (unique-pairs n)
    (flatmap (lambda (i)
                 (map (lambda (j) (list i j))
                      (enumerate-interval 1 (- i 1))))
             (enumerate-interval 1 n)))

(define (prime-sum-pairs1 n)
    (map make-pair-sum
         (filter prime-sum? (unique-pairs n))))


;; 2.41

(define (unique-triples n)
    (flatmap (lambda (i)
                 (map (lambda (j)                   ; cons 起 i 元素和二元组 j ,组成三元组
                          (cons i j))
                      (unique-pairs (- i 1))))      ; 生成不大于 i 的所有相异整数二元组
             (enumerate-interval 1 n)))             ; 生成 1 至 n 的所有整数，作为 i


(define (triple-sum-equal-to? sum triple)
    (= sum
       (fold-right + 0 triple)))

(define (remove-triples-not-equal-to sum triple)
    (filter (lambda (current-triple)
                (triple-sum-equal-to? sum current-triple))
            triple))

;; 2.42
(define (queens board-size)
  (define (queen-cols k)
  (if (= k 0)
      (list empty-board)
      (filter
       (lambda (positions) (safe? k positions))
       (flatmap
        (lambda (rest-of-queens)
                (map (lambda (new-row)
                       (adjoin-position new-row k rest-of-queens))
                     (enumerate-interval 1 board-size)))
       (queen-cols (- k 1))))))
  (queen-cols board-size))


(define empty-board '())

(define (safe? k position)
    (iter-check (car position) 
                (cdr position)
                 1))

(define (adjoin-position new-row k rest-of-queens)
    (cons new-row rest-of-queens))

(define (iter-check row-of-new-queen rest-of-queens i)
    (if (null? rest-of-queens)  ; 下方所有皇后检查完毕,新皇后安全
        #t
        (let ((row-of-current-queen (car rest-of-queens)))
            (if (or (= row-of-new-queen row-of-current-queen)           ; 行碰撞
                    (= row-of-new-queen (+ i row-of-current-queen))     ; 右下方碰撞
                    (= row-of-new-queen (- row-of-current-queen i)))    ; 左下方碰撞
                #f
                (iter-check row-of-new-queen 
                            (cdr rest-of-queens)    ; 继续检查剩余的皇后
                            (+ i 1))))))            ; 更新步进值

;;(for-each (lambda (pos)
;;                    (begin
;;                        (display pos)
;;                       (newline)))
;;                (queens 8))