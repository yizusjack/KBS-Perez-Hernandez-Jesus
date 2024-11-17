(deffunction calculate-total-cost ($?lineItems)
   (bind ?total 0)
   ;; Itera cada line-item
   (foreach ?itemId $?lineItems 
        (do-for-fact ((?li line-item)) (eq ?li:item-id ?itemId) ;;Obtiene el line item
            (do-for-fact ((?sm smartphone)) (eq ?sm:code ?li:product-id) ;;Obtiene si el line item pertenece a un smartphone
                (bind ?unit-price (* ?li:quantity ?sm:precio))
            )
            (do-for-fact ((?cp computador)) (eq ?cp:code ?li:product-id) ;;Obtiene si el line item pertenece a un computador
                (bind ?unit-price (* ?li:quantity ?cp:precio))
            )
            (do-for-all-facts ((?ac accesorio)) (eq ?ac:code ?li:product-id) ;;Obtiene si el line item pertenece a un accesorio
                (bind ?unit-price (* ?li:quantity ?ac:precio))
            )
            (bind ?total (+ ?total ?unit-price))
        )
    )
?total)

(deffunction calculate-total-items ($?lineItems)
    (bind ?total 0)
    (foreach ?itemId $?lineItems
        (do-for-fact ((?li line-item)) (eq ?li:item-id ?itemId)
            (bind ?total (+ ?total ?li:quantity))
        )
    )
?total)

(deffunction update-stock ($?lineItems)
   ;; Itera cada line-item
   (foreach ?itemId $?lineItems 
        (do-for-fact ((?li line-item)) (eq ?li:item-id ?itemId) ;;Obtiene el line item
            (do-for-fact ((?sm smartphone)) (eq ?sm:code ?li:product-id) ;;Obtiene si el line item pertenece a un smartphone
                (if (<= ?li:quantity ?sm:stock) then
                    (modify ?sm (stock (- ?sm:stock ?li:quantity)))
                    (printout t "Stock restante de " ?sm:modelo ": " ?sm:stock crlf)
                else
                    (printout t "Stock insuficiente..." crlf)
                    (retract ?li)
                )
            )
            (do-for-fact ((?cp computador)) (eq ?cp:code ?li:product-id) ;;Obtiene si el line item pertenece a un computador
                (if (<= ?li:quantity ?cp:stock) then
                    (modify ?cp (stock (- ?cp:stock ?li:quantity)))
                    (printout t "Stock restante de " ?cp:modelo ": " ?cp:stock crlf)
                else
                    (printout t "Stock insuficiente..." crlf)
                    (retract ?li)
                )
            )
            (do-for-all-facts ((?ac accesorio)) (eq ?ac:code ?li:product-id) ;;Obtiene si el line item pertenece a un accesorio
                (if (<= ?li:quantity ?ac:stock) then
                    (modify ?ac (stock (- ?ac:stock ?li:quantity)))
                    (printout t "Stock restante de " ?ac:nombre ": " ?ac:stock crlf)
                else
                    (printout t "Stock insuficiente..." crlf)
                    (retract ?li)
                )
            )
        )
    )
nil)

(deffunction order-has-smartphone ($?lineItems)
    (bind ?has-phone 0)
    (foreach ?itemId $?lineItems 
        (do-for-fact ((?li line-item)) (eq ?li:item-id ?itemId)
            (do-for-fact ((?sm smartphone)) (eq ?sm:code ?li:product-id)
                (bind ?has-phone 1)
            )
        )
    )
?has-phone)

(deffunction order-has-computer ($?lineItems)
    (bind ?has-computer 0)
    (foreach ?itemId $?lineItems 
        (do-for-fact ((?li line-item)) (eq ?li:item-id ?itemId) 
            (do-for-fact ((?cp computador)) (eq ?cp:code ?li:product-id) 
                (bind ?has-computer 1)
            )
        )
    )
?has-computer)

(deffunction order-has-accesorio ($?lineItems)
    (bind ?has-accesorio 0)
    (foreach ?itemId $?lineItems 
        (do-for-fact ((?li line-item)) (eq ?li:item-id ?itemId) 
            (do-for-fact ((?ac accesorio)) (eq ?ac:code ?li:product-id) 
                (bind ?has-accesorio 1)
            )
        )
    )
?has-accesorio)