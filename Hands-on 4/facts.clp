

(deffacts customers
  (customer (customer-id 1) (name Juan) (address "Azalea 899") (phone 3313073905))
  (customer (customer-id 2) (name Maria) (address "Margarita 500") (phone 333222345))
  (customer (customer-id 3) (name Bob) (address "Anturio 798" ) (phone 331567890)) 
)  	 

(deffacts smartphones 
 	(smartphone (code sm1) (marca samsung) (modelo "Note 21") (precio 199.99) (color rojo) (stock 50))
 	(smartphone (code sm2) (marca apple) (modelo "!phone 16") (precio 399.99) (color negro) (stock 23))
 	(smartphone (code sm3) (marca motorola) (modelo "moto-stylus") (precio 99.99) (color gris) (stock 34))
)

(deffacts computadores 
 	(computador (code cp1) (marca asus) (modelo "rog20") (precio 500.99) (procesador intel) (stock 34))
 	(computador (code cp2) (marca lenovo) (modelo "ideapad") (precio 399.99) (procesador amd) (stock 54))
 	(computador (code cp3) (marca hp) (modelo "thinkpad") (precio 300.99) (procesador intel) (stock 23))
	(computador (code cp4) (marca mac) (modelo "MacBook Air") (precio 300.99) (procesador intel) (stock 23))
)

(deffacts accesorios
	(accesorio (code ac1) (nombre funda) (precio 100.00) (stock 80))
	(accesorio (code ac2) (nombre mica) (precio 40.00) (stock 70))
	(accesorio (code ac3) (nombre pop-socket) (precio 25.00) (stock 100))
	(accesorio (code ac4) (nombre mochila) (precio 400.00) (stock 80))
)