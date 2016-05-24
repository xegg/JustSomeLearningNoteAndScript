(print (/ (+ 5 4 (- 2 (- 3 (+ 6 (/ 4 5)))))
   (* 3
      (- 6 2)
      (- 2 7))))

;;1.3
(defun find-big-two (a b c)
  (cond ((< a b c ) (+ b c))
        ((< b a c ) a c)
        ((< c b a ) (+ b a))))

(print (find-big-two 1 2 3))

;;1.5
(defun p ()
  (p))

(defun (= x 0)
  (if (= x 0)
    0
    y))

(defun square (x)
     (* x x))

(defun sqrt-iter (guess x)
  (if (good-enough? guess x)
    guess
    (sqrt-iter (improve guess x) x)))

(defun good-enough? (guess x)
  (< (abs (- (square guess) x)) 0.001)) 
(defun improve (guess x)
  (average guess (/ x guess)))

(defun average (x y)
  (/ (+ x y) 2))

(defun sqrt (x)
  (sqrt-iter 1.0 x))


;;1.6
(defun new-if (predicate then-clause else-clause)
  (cond (predicate then-clause)
        (t else-clause)))

(defun sqrt-iter (guess x)
  (new-if (good-enough? guess )
    guess
    (sqrt-iter (improve guess x) x)))

;;1.7
(defun sqrt-iter (new-guess old-guess x)
  (if (good-enough? new-guess old-guess x)
    new-guess
    (sqrt-iter (improve new-guess x) new-guess x)))

(defun good-enough? (old-guess new-guess)
  (< (abs (- old-guess new-guess)) 0.001))

;;1.9
(defun + (a b)
  (if (= a 0)
    b
    (inc (+ (dec a) b))))

(defun (A x y)
  (cond ((= y 0) 0)
        ((= x 0) (* 2 y))
        ((= y 1) 2)
        (t (A (-x 1)
              (A x (- y 1))))))
