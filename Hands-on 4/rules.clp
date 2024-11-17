;;Cambia el stock tras una compra
(defrule modificar-stock
   (order 
      (order-number ?orderNumber)
      (line-items $?lineItems)
   )
   =>
   (update-stock ?lineItems)
)

;;calcula el costo total de una orden
(defrule calcular-costo-orden
   (order 
      (order-number ?orderNumber)
      (line-items $?lineItems)
   )
   =>
   (bind ?totalCost (calculate-total-cost ?lineItems))
   (printout t "Total de la orden " ?orderNumber ": $" ?totalCost crlf)
)

;;Calcula el total de items de una compra
(defrule calcular-numero-items-orden
   (order 
      (order-number ?orderNumber)
      (line-items $?lineItems)
   )
   =>
   (bind ?items (calculate-total-items ?lineItems))
   (printout t "La orden " ?orderNumber " cuenta con " ?items " articulos" crlf)
)

;;Define si el cliente es mayorista o menudista
(defrule evaluar-may-men
   (order 
      (order-number ?orderNumber)
      (line-items $?lineItems)
      (customer-id ?customer)
   )
   =>
   (bind ?items (calculate-total-items ?lineItems))
   (if (>= ?items 10) then
         (printout t "El cliente " ?customer " es mayorista" crlf)
      else
         (printout t "El cliente " ?customer " es menudista" crlf)
   )
)

;;Ofrece 24 meses sin  intereses al comprar un !phone16 con una tarjeta banamex
(defrule meses-!phone16-banamex
   (order 
      (order-number ?orderNumber) 
      (line-items $?before ?lineItemId $?after)  ; Decompone los items por partes para poderlos iterar
      (customer-id ?customerId)
      (card ?cardId))
   (line-item 
      (item-id ?lineItemId) 
      (product-id sm2)) ; El line-item es igual a sm2 (!phone16)
   (tarjeta 
      (numero ?cardId) 
      (banco Banamex)) ; La tarjeta es banamex
   =>
   (printout t "El cliente " ?customerId " ha recibido 24 meses sin intereses por la compra de un !Phone 16 con una tarjeta banamex como parte de la compra " ?orderNumber crlf)
)

;;Ofrece 12 meses sin intereses al comprar un note 21 con una visa liverpool
(defrule meses-samsung-note-21-liverpool
   (order 
      (order-number ?orderNumber) 
      (line-items $?before ?lineItemId $?after)
      (customer-id ?customerId)
      (card ?cardId))
   (line-item 
      (item-id ?lineItemId) 
      (product-id sm1)) ; Match a specific line-item
   (tarjeta 
      (numero ?cardId) 
      (banco Liverpool)) ; Match the card with Liverpool
   =>
   (printout t "El cliente " ?customerId " ha recibido 12 meses sin intereses por la compra de un Note 21 con una tarjeta liverpool-visa como parte de la compra " ?orderNumber crlf)
)

;;Ofrece 100 pesos en vales por cada 1000 de compra al comprar un !phone 16 y una macbook air
(defrule vales-mac-iphone
   (order 
      (order-number ?orderNumber)
      (line-items $?lineItems)
      (customer-id ?customer)
      (form-of-pay cash)
   )
   (line-item (item-id ?itemId1) (product-id sm2)) ;!phone16
   (line-item (item-id ?itemId2) (product-id cp4)) ;MacBook Air
   (test (member$ ?itemId1 ?lineItems))
   (test (member$ ?itemId2 ?lineItems))
   =>
   (bind ?totalCost (calculate-total-cost ?lineItems))
   (if (>= ?totalCost 1000) then
      (bind ?vales (* (div ?totalCost 1000) 100))
      (printout t "El cliente " ?customer " recibirá " ?vales " pesos en vales de descuento" crlf)
      (assert (vale (cliente-id ?customer) (cantidad ?vales)))
   )
)

;;Ofrecer descuento en mica al comprar smartphone
(defrule ofrecer-funda-mica
   (order 
      (order-number ?orderNumber)
      (line-items $?lineItems)
   )
   =>
   (bind ?has-phone (order-has-smartphone ?lineItems))
   (if (eq ?has-phone 1) then
      (printout t "Puede comprar una funda o una mica con un 15% de descuento" crlf)
   )
)

;;Ofrecer descuento en mochila al comprar computador
(defrule ofrecer-mochila
   (order 
      (order-number ?orderNumber)
      (line-items $?lineItems)
   )
   =>
   (bind ?has-compu (order-has-computer ?lineItems))
   (if (eq ?has-compu 1) then
      (printout t "Puede comprar una mochila con un 10% de descuento" crlf)
   )
)

;;Ofrecer otro articulo a mitad de precio en la compra de un articulo
(defrule ofrecer-articulo-mitad-de-precio
   (order 
      (order-number ?orderNumber)
      (line-items $?lineItems)
   )
   =>
   (bind ?has-accesorio (order-has-accesorio ?lineItems))
   (if (eq ?has-accesorio 1) then
      (printout t "Puede llevar otro articulo identico a mitad de precio" crlf)
   )
)

;;Ofrecer 10% de descuento en la compra al contado de una computadora
(defrule descuento-computadora-contado
   (order 
      (line-items $?lineItems)
      (form-of-pay cash)
   )
   =>
   (bind ?has-compu (order-has-computer ?lineItems))
   (if (eq ?has-compu 1) then
      (printout t "10% de descuento por la compra al contado de una computadora" crlf)
   )
)

;;Ofrecer meses en compra de thinkpad con tarjeta Azteca
(defrule meses-thinkpad-azteca
   (order 
      (order-number ?orderNumber) 
      (line-items $?before ?lineItemId $?after)
      (customer-id ?customerId)
      (card ?cardId))
   (line-item 
      (item-id ?lineItemId) 
      (product-id cp3))
   (tarjeta 
      (numero ?cardId) 
      (banco Azteca))
   =>
   (printout t "El cliente " ?customerId " ha recibido 6 meses sin intereses por la compra de una thinkpad con una tarjeta Azteca como parte de la compra " ?orderNumber crlf)
)

;;Ofrecer 10 pesos de descuento por cada 100 de compra al comprar un motostylus
(defrule descuento-moto-stylus
   (order 
      (order-number ?orderNumber)
      (line-items $?lineItems)
      (customer-id ?customer)
   )
   (line-item (item-id ?itemId1) (product-id sm3)) ;Moto-stylus

   (test (member$ ?itemId1 ?lineItems))
   =>
   (bind ?totalCost (calculate-total-cost ?lineItems))
   (if (>= ?totalCost 100) then
      (bind ?vales (* (div ?totalCost 100) 10))
      (printout t "El cliente " ?customer " recibirá " ?vales " pesos en vales de descuento por comprar un motostylus" crlf)
      (assert (vale (cliente-id ?customer) (cantidad ?vales)))
   )
)

;;Ofrecer 10 pesos de descuento por cada 100 de compra al comprar una computadora
(defrule descuento-computadoras
   (order 
      (order-number ?orderNumber)
      (line-items $?lineItems)
      (customer-id ?customer)
   )
   =>
   (bind ?has-compu (order-has-computer ?lineItems))
   (if (eq ?has-compu 1) then
      (bind ?totalCost (calculate-total-cost ?lineItems))
   
      (if (>= ?totalCost 100) then
         (bind ?vales (* (div ?totalCost 100) 10))
         (printout t "El cliente " ?customer " recibirá " ?vales " pesos en vales de descuento por comprar una computadora" crlf)
         (assert (vale (cliente-id ?customer) (cantidad ?vales)))
      )
   )
)

;;Ofrecer 25% de descuento al comprar una mochila al contado
(defrule descuento-mochila
   (order 
      (order-number ?orderNumber)
      (line-items $?lineItems)
      (customer-id ?customer)
      (form-of-pay cash)
   )
   (line-item (item-id ?itemId1) (product-id ac4))

   (test (member$ ?itemId1 ?lineItems))
   =>
   (printout t "El cliente " ?customer " recibirá 25% de decuento por la compra " ?orderNumber crlf)
)

;;Ofrecer 100 pesos de descuento en la compra de mas de 2000 pesos
(defrule descuento-compra-mayor-2000
   (order 
      (order-number ?orderNumber)
      (line-items $?lineItems)
      (customer-id ?customer)
   )
   =>
      (bind ?totalCost (calculate-total-cost $?lineItems))
   
      (if (>= ?totalCost 2000) then
         (printout t "El cliente " ?customer " recibirá 100 pesos en vales de descuento por la compra mayor a 2000 pesos" crlf)
         (assert (vale (cliente-id ?customer) (cantidad 100)))
      )
)

;;Ofrecer 10 pesos de descuento por cada articulo en la compra de mas de 20 articulos
(defrule descuento-compra-mayor-20-articulos
   (order 
      (order-number ?orderNumber)
      (line-items $?lineItems)
      (customer-id ?customer)
   )
   =>
      (bind ?items (calculate-total-items $?lineItems))
      (if (>= ?items 20) then
         (bind ?descuento (* 10 ?items))
         (printout t "El cliente " ?customer " recibirá " ?descuento " pesos en vales de descuento por la compra mayor a 20 articulos" crlf)
         (assert (vale (cliente-id ?customer) (cantidad ?descuento)))
      )
)

;;Ofrecer 5 pesos de descuento por articulo en cada compra con una tarjeta Banamex
(defrule descuento-por-articulo-banamex
   (order 
      (order-number ?orderNumber) 
      (line-items $?lineItems)  ; Decompone los items por partes para poderlos iterar
      (customer-id ?customerId)
      (card ?cardId))
   (line-item 
      (item-id ?lineItemId) 
   )
   (tarjeta 
      (numero ?cardId) 
      (banco Banamex)
   )
   (test (member$ ?lineItemId ?lineItems))
   =>
   (bind ?items (calculate-total-items $?lineItems))
      (bind ?descuento (* 5 ?items))
      (printout t "El cliente " ?customerId " recibirá " ?descuento " pesos en vales de descuento por usar una tarjeta banamex" crlf)
      (assert (vale (cliente-id ?customerId) (cantidad ?descuento)))
)

;;Dar 6 meses sin intereses al comprar una asus con una tarjeta bbva
(defrule meses-asus-bbva
   (order 
      (order-number ?orderNumber) 
      (line-items $?before ?lineItemId $?after)  ; Decompone los items por partes para poderlos iterar
      (customer-id ?customerId)
      (card ?cardId))
   (line-item 
      (item-id ?lineItemId) 
      (product-id cp1)) ; El line-item es igual a cp1 (asus)
   (tarjeta 
      (numero ?cardId) 
      (banco BBVA)) ; La tarjeta es bbva
   =>
   (printout t "El cliente " ?customerId " ha recibido 6 meses sin intereses por la compra de una asus con una tarjeta BBVA como parte de la compra " ?orderNumber crlf)
)

;;Ofrecer 150 pesos de descuento por la compra de un samsung note 11 al contado
(defrule descuento-samsung-contado
   (order 
      (order-number ?orderNumber) 
      (line-items $?before ?lineItemId $?after)  ; Decompone los items por partes para poderlos iterar
      (customer-id ?customerId)
      (form-of-pay cash)
   )
   (line-item 
      (item-id ?lineItemId) 
      (product-id sm1)
   )
   =>
   (printout t "El cliente " ?customerId " ha recibido 150 pesos de descuento por la compra de un celular samsung al contado como parte de la compra " ?orderNumber crlf)
)