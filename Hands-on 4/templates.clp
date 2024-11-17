

(deftemplate customer
  (slot customer-id)
  (multislot name)
  (multislot address)
  (slot phone)
)

(deftemplate smartphone
  (slot code)
  (slot marca)
  (multislot modelo)
  (slot precio)
  (slot color)
  (slot stock)
)

(deftemplate computador
  (slot code)
  (slot marca)
  (multislot modelo)
  (slot precio)
  (slot procesador)
  (slot stock)
)

(deftemplate accesorio
  (slot code)
  (slot nombre)
  (slot precio)
  (slot stock)
)

(deftemplate tarjeta
  (slot numero)
  (slot banco)
  (slot grupo)
  (slot fecha_exp)
)

(deftemplate vale
  (slot cliente-id)
  (slot cantidad)
)

(deftemplate line-item
  (slot item-id)
  (slot product-id) 
  (slot quantity (default 1))
)

(deftemplate order
  (slot order-number)
  (slot date)
  (multislot line-items)
  (slot customer-id)
  (slot form-of-pay)
  (slot card (default nil))
)