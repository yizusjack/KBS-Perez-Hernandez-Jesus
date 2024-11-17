(load templates.clp)

(load facts.clp)

(load functions.clp)

(load rules.clp)

(reset)

(facts)


(assert (line-item (item-id 1) (product-id sm2) (quantity 2)))

(assert (tarjeta (numero 12345678) (banco Banamex) (grupo Visa) (fecha_exp 24/05)))

(assert (order 
    (order-number 1) 
    (date "14/11/24") 
    (line-items 1) 
    (customer-id 1) 
    (form-of-pay credit) 
    (card 12345678)
))

(run)

(assert (line-item (item-id 2) (product-id sm3) (quantity 2)))
(assert (line-item (item-id 4) (product-id sm1) (quantity 1)))

(assert (tarjeta (numero 78945612) (banco Liverpool) (grupo visa) (fecha_exp 24/05)))

(assert (order 
    (order-number 2) 
    (date "14/11/24") 
    (line-items 2 4) 
    (customer-id 1) 
    (form-of-pay credit) 
    (card 78945612)
))

(run)

(assert (line-item (item-id 3) (product-id cp1) (quantity 2)))

(assert (tarjeta (numero 23456789) (banco BBVA) (grupo Visa) (fecha_exp 24/05)))

(assert (order 
    (order-number 3) 
    (date "14/11/24") 
    (line-items 3) 
    (customer-id 1) 
    (form-of-pay credit) 
    (card 23456789)
))

(run)

(assert (line-item (item-id 5) (product-id sm2) (quantity 2)))
(assert (line-item (item-id 6) (product-id cp4) (quantity 10)))
(assert (line-item (item-id 11) (product-id ac4) (quantity 8)))

(assert (order 
    (order-number 4) 
    (date "14/11/24") 
    (line-items 5 6 11) 
    (customer-id 2) 
    (form-of-pay cash) 
))

(run)

(assert (line-item (item-id 7) (product-id sm3) (quantity 2)))
(assert (line-item (item-id 8) (product-id cp3) (quantity 2)))
(assert (line-item (item-id 9) (product-id sm1) (quantity 1)))
(assert (line-item (item-id 10) (product-id ac3) (quantity 1)))

(assert (tarjeta (numero 6172839) (banco Azteca) (grupo visa) (fecha_exp 24/05)))

(assert (order 
    (order-number 5) 
    (date "14/11/24") 
    (line-items 7 8 9 10) 
    (customer-id 3) 
    (form-of-pay credit) 
    (card 6172839)
))

(run)


(assert (line-item (item-id 12) (product-id sm1) (quantity 1)))
(assert (order 
    (order-number 6) 
    (date "14/11/24") 
    (line-items 12) 
    (customer-id 2) 
    (form-of-pay cash)
))

(run)
