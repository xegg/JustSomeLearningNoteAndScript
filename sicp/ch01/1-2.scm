(define (f n)
  (if (< n 3)
      n
      (+ (f (- n 1))
         (* 2 (f (- n 2)))
         (* 3 (f (- n 3))))))

(define (f2 n)
  (define (f-iter a b c n)
    (if (= n 0)
        a
        (f-iter b c (+ c (* 2 b) (* 3 a)) (- n 1))))
  (f-iter 0 1 2 n))

(define (gcd a b)
  ( if (= b 0)
       a
       (gcd b (remainder a b))))

#TODO LAME证明, 13

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

(define (fermat-test n)
  (define (try-it a)
    (= (expmod a n n) a))
  (try-it (+ 1 (random (- n 1)))))

(define (fast-prime? n times)
  (cond ((= times 0) true)
        ((fermat-test n) (fast-prime? n (- times 1)))
        (else false)))

(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp)
         (remainder (square (expmod base (/ exp 2) m))
                    m))
        (else
          (remainder (* base (expmod base (- exp 1) m))
                     m))))

(define (square a)
  (* a a))

(define (timed-prime-test n)
  (newline)
  (display n)
  (start-prime-test n (runtime)))

(define (start-prime-test n start-time)
  (if (prime? n)
      (report-prime (- (runtime) start-time))(newline)))

(define (report-prime elapsed-time)
  (display " *** ")
  (display elapesd-time))

(define (next-odd n)
  (if (odd? n)
    (+ n 2)
    (+ n 1)))

(define (continue-primes n count)
  (cond ((= count 0)
         (display "are primes."))
        ((prime? n)
         (display n)
         (newline)
         (coutinue-primes (next-odd n) (- cout 1)))
        (else
          (continue-primes (next-odd n) count))))

(define (search-for-primes n)
  (let((start-time (real-time-clock)))
    (continue-primes n 3)
    (- (real-time-clock) start-time)))

;; 1.27
(define (carmichael-test n)
  (test-iter 1 n))

(define (test-iter a n)
  (cond ((= a n)
         #t)
        ((congruent? a n)
         (test-iter (+ a 1) n))
        (else
          #f)))

(define (congruent? a n)
  (= (expmod a n n) a))

;; 1.28
(define (expmod base exp m)
  (cond ((= exp 0)
         1)
        ((nontrivial-square-root? base m)
         0)
        ((even? exp)
         (remainder (square (expmod base (/ exp 2) m))
                    m)
         (else
           (remainder (* base (expmod base (- exp 1) m))
                      m)))))
