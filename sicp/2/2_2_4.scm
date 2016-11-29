#lang scheme/gui
(require (planet "sicp.ss" ("soegaard" "sicp.plt" 2 1)))
(require graphics/graphics)
(open-graphics)
(define vp (open-viewport "A Picture Language" 500 500))

(define draw (draw-viewport vp))
(define (clear) ((clear-viewport vp)))
(define line (draw-line vp))

(define einstein2 (beside einstein (flip-vert einstein)))

;;(define einstein4 (below einstein2 einstein2))

(define (flipped-pairs painter)
  (let ((painter2 (beside painter (flip-vert painter))))
    (below painter2 painter2)))

(define einstein4 (flipped-pairs einstein))

(define (right-split painter n)
  (if (= n 0)
      painter
      (let ((smaller (right-split painter (- n 1))))
        (beside painter (below smaller smaller)))))

(define (up-split painter n)
  (if (= n 0)
      painter
      (let ((smaller (up-split painter (- n 1))))
        (below painter (beside smaller smaller)))))


(define (corner-split painter n)
  (if (= n 0)
      painter
      (let ((up (up-split painter (- n 1)))
            (right (right-split painter (- n 1))))
        (let ((top-left (beside up up))
              (bottom-right (below right right))
              (corner (corner-split painter (- n 1))))
          (beside (below painter top-left)
                  (below bottom-right corner))))))

(define (square-limit painter n)
  (let ((quarter (corner-split painter n)))
    (let ((half (beside (flip-horiz quarter) quarter)))
      (below (flip-vert half) half))))

(define (square-of-four tl tr bl br)
  (lambda (painter)
    (let ((top (beside (tl painter) (tr painter)))
          (bottom (beside (bl painter) (br painter))))
      (below bottom top))))

(define (flipped-pairs2 painter)
  (let ((combine4 (square-of-four identity flip-vert
                                  identity flip-vert)))
    (combine4 painter)))

(define (square-limit2 painter n)
  (let ((combine4 (square-of-four flip-horiz identity
                                  rotate180 flip-vert)))
    (combine4 (corner-split painter n))))

;; 2.45
(define (split big-combiner small-combiner)
    (define (inner painter n)
        (if (= n 0)
            painter
            (let ((smaller (inner painter (- n 1))))
                (big-combiner painter   
                              (small-combiner smaller smaller)))))
    inner)

(define right-split2 (split beside below))
(define up-split2 (split below beside))

;; 2.46

(define (make-vect xcor ycor)
    (list xcor ycor))

(define (xcor-vect v)
    (car v))

(define (ycor-vect v)
    (cadr v))


(define (add-vect vect another-vect)
    (make-vect (+ (xcor-vect vect)
                  (xcor-vect another-vect))
               (+ (ycor-vect vect)
                  (ycor-vect another-vect))))

(define (sub-vect vect another-vect)
    (make-vect (- (xcor-vect vect)
                  (xcor-vect another-vect))
               (- (ycor-vect vect)
                  (ycor-vect another-vect))))


(define (scale-vect factor vect)
    (make-vect (* factor (xcor-vect vect))
               (* factor (ycor-vect vect))))

;;; 47

(define (make-frame origin edge1 edge2)
    (list origin edge1 edge2))

(define (origin-frame f)
    (car f))

(define (edge1-frame f)
    (cadr f))

(define (edge2-frame f)
    (caddr f))

(define (frame-coord-map frame)
  (lambda (v)
    (add-vect
     (origin-frame frame)
     (add-vect (scale-vect (xcor-vect v)
                           (edge1-frame frame))
               (scale-vect (ycor-vect v)
                           (edge2-frame frame))))))


;; 2.48
(define (make-segment start end)
    (list start end))

(define (start-segment s)
    (car s))

(define (end-segment s)
    (cadr s))

;; 2.49

(define top-left (make-vect 0.0 1.0))
(define top-right (make-vect 1.0 1.0))
(define bottom-left (make-vect 0.0 0.0))
(define bottom-right (make-vect 1.0 0.0))

(define top (make-segment top-left top-right))
(define left (make-segment top-left bottom-left))
(define right (make-segment top-right bottom-right))
(define bottom (make-segment bottom-left bottom-right))





(define (segments->painter segment-list)
  (lambda (frame)
    (for-each
     (lambda (segment)
       (draw-line
        ((frame-coord-map frame) (start-segment segment))
        ((frame-coord-map frame) (end-segment segment))))
     segment-list)))
(segments->painter (list top bottom left right))





