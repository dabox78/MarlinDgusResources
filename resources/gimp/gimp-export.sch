(define (go-by-layers no layers)
  (while (< 0 no)
    (let* (
      (layer (vector-ref layers (- no 1)))
      (layername (car (gimp-item-get-name layer)))
      )
          
      (if (< 0 (car (gimp-item-is-group layer)))
        (begin

            (display "export group ")
            (display layername) (newline)
            (file-bmp-save 1 1 layer layername layername)
        )
        (begin
          (display "skip layer ")
          (display layername) (newline)
          
        )
      )
      
      (set! no (- no 1))
    )
  )
)

(let* ((layers (gimp-image-get-layers 1)))
  (display "Number of Layers: ") (display (car layers)) (newline)
  (go-by-layers (car layers) (cadr layers))
  (display "end") (newline)
)

(gimp-quit 0)
