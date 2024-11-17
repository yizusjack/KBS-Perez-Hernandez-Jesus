(load "cargar-enfermedades.clp")
(load "rules.clp")
(load "functions.clp")
(reset)
(run)
Influenza
"fiebre" "dolor de cabeza"
(agregar-enfermedad "Tosferina" "tos" "fiebre" "mucosidad")
(facts)
(eliminar-enfermedad "Tosferina")
(facts)
(editar-enfermedad "Sífilis" "llagas" "dolores musculares")
(facts)
