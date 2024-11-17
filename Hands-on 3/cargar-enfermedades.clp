(deftemplate enfermedad
	(slot nombre)
	(multislot sintomas)
)

(deftemplate consulta-enfermedad
    (slot nombre)
)

(deftemplate consulta-sintomas
    (multislot sintomas)
)

(deffacts enfermedades
    (enfermedad (nombre "Gripe") (sintomas "fiebre" "dolores" "fatiga" "dolor de cabeza" "congestión" "estornudos" "dolor de garganta"))
    (enfermedad (nombre "Chikunguña") (sintomas "fiebre" "dolor articular" "dolor de cabeza" "dolor muscular"))
    (enfermedad (nombre "Influenza") (sintomas "fiebre" "tos" "dolor de garganta" "dolores musculares" "fatiga" ))
    (enfermedad (nombre "Culebrilla") (sintomas "fiebre" "dolor de cabeza" "escalofríos" "dolor abdominal" "neuralgia posherpética"))
    (enfermedad (nombre "Paperas") (sintomas "fiebre" "dolor de cabeza" "dolores musculares" "pérdida de apetito" "inflamación de glándulas salivales"))
    (enfermedad (nombre "Tuberculosis") (sintomas "tos" "dolor de pecho" "tos con sangre" "debilidad" "fatiga" "escalofríos" "sudores nocturnos"))
    (enfermedad (nombre "Botulismo") (sintomas "cólicos abdominales" "dificultad respiratoria" "visión doble" "nauseas" "vómito" "parálisis"))
    (enfermedad (nombre "Herpes") (sintomas "diarrea" "deshidratación" "calambres musculares"))
    (enfermedad (nombre "Salmonelosis") (sintomas "diarrea" "cólicos estomacales" "fiebre" "naúseas" "vómito" "escalofríos" "dolor de cabeza" "sangre en las heces"))
    (enfermedad (nombre "Sífilis") (sintomas "llagas en la boca" "llagas genitales" "caída de pelo" "dolores musculares" "fiebre" "dolor de garganta" "pérdida de peso"))
)