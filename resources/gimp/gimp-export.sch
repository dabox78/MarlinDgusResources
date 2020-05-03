(define (go-by-layers no layers)
  (while (< 0 no)
    (let* (
      (layer (vector-ref layers (- no 1)))
      (layername (car (gimp-item-get-name layer)))
      (basename (car (gimp-image-get-name 1)))
      (rawfilename (string-append (string-append basename "_") layername))
      (filename (string-append rawfilename ".bmp"))
      
      )

      (if (< 0 (car (gimp-item-is-group layer)))
        (begin
            (display "export group ") (display layername) (display " to ") (display filename) (newline)
            
            (file-bmp-save 1 1 layer filename rawfilename)
            ;(file-png-save-defaults 1 1 layer filename rawfilename)
            ;(file-png-save2 run-mode image drawable filename raw-filename interlace compression bkgd gama offs phys time comment svtrans)
            ;(file-png-save2 1 1 layer layername layername 0 9 0 1 0 1 0 0 0)
            ;(file-png-save2 1 1 layer layername layername 0 9 0 1 0 1 0 0 1)
            ;(file-png-save2 1 1 layer layername layername 0 9 1 1 0 1 0 0 1)
            ;(file-gif-save2 run-mode image drawable uri raw-uri interlace loop default-delay default-dispose as-animation force-delay force-dispose)
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
