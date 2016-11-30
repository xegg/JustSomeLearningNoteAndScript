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
    ((cadr v)))


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

(define (segments->painter segment-list)
  (lambda (frame)
    (for-each
     (lambda (segment)
       (draw-line
        ((frame-coord-map frame) (start-segment segment))
        ((frame-coord-map frame) (end-segment segment))))
     segment-list)))


; we define the corners of the frame (used for 1. and 2.)
(define c1 (make-vect 0 0))
(define c2 (make-vect 0 1))
(define c3 (make-vect 1 1))
(define c4 (make-vect 1 0))

; 1. outline of frame
(define outline
  (segments->painter (list (make-segment c1 c2)
                           (make-segment c2 c3)
                           (make-segment c3 c4)
                           (make-segment c4 c1))))

; 2. X in frame
(define X
  (segments->painter (list (make-segment c1 c4)
                           (make-segment c2 c3))))

; 3. diamond in frame
; we define the corners of the diamond
(define d1 (make-vect 0.5 0))
(define d2 (make-vect 0 0.5))
(define d3 (make-vect 0.5 1))
(define d4 (make-vect 1 0.5))

(define diamond
  (segments->painter (list (make-segment d1 d2)
                           (make-segment d2 d3)
                           (make-segment d3 d4)
                           (make-segment d4 d1))))


(define (transform-painter painter origin corner1 corner2)
  (lambda (frame)
          (let ((m (frame-coord-map frame)))
            (let ((new-origin (m origin)))
              (painter
               (make-frame new-origin
                           (sub-vect (m corner1) new-origin)
                           (sub-vect (m corner2) new-origin)))))))

(define (beside2 painter1 painter2)
  (let ((split-point (make-vect 0.5 0.0)))
    (let ((paint-left
           (transform-painter painter1
                              (make-vect 0.0 0.0)
                              split-point
                              (make-vect 0.0 1.0)))
          (paint-right
           (transform-painter painter2
                              split-point
                              (make-vect 1.0 0.0)
                              (make-vect 0.5 1.0))))
           (lambda (frame)
             (paint-left frame)
             (paint-right frame)))))


;; 2.50
(define (flip-horiz painter)
  (transform-painter painter
                     (make-vect 1.0 0.0)
                     (make-vect 0.0 0.0)
                     (make-vect 1.0 1.0)))

(define (rotate90 painter)
  (transform-painter painter
                     (make-vect 1.0 0.0)
                     (make-vect 1.0 1.0)
                     (make-vect 0.0 0.0)))

(define (rotate180 painter)
  (rotate90 (rotate90 painter)))

(define (rotate270 painter)
  (rotate90 (rotate180 painter)))

;; 2.51
(define (below painter1 painter2)
  (let ((split-point (make-vect 0.0 0.5)))
    (let ((paint-below
           (transform-painter painter1
                              (make-vect 0.0 0.0)
                              (make-vect 1.0 0.0)
                              split-point))
          (paint-above
           (transform-painter painter2
                              split-point
                              (make-vect 0.5 1.0)
                              (make-vect 0.0 1.0))))
         (lambda (frame)
           (paint-above frame)
           (paint-below frame)))))



