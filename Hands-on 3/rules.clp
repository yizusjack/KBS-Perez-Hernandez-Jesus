(defrule enlistar-enfermedades
    (enfermedad (nombre ?nombre_enfermedad) (sintomas $?sintomas))
    =>
    (printout t "La enfermedad " ?nombre_enfermedad " presenta los síntomas de: " )
    (foreach ?sintoma $?sintomas
        (printout t ?sintoma ", ")
    )
    (printout t crlf)
)

(defrule solicitar-enfermedad
    =>
    (printout t "Ingrese la enfermedad de la que desea conocer los síntomas: " crlf)
    (bind ?input (readline))
    (assert (consulta-enfermedad(nombre ?input)))
)

(defrule enlistar-sintomas
    ?consulta <- (consulta-enfermedad(nombre ?nombre-enfermedad))
    ?enfermedad <- (enfermedad(nombre ?nombre) (sintomas $?sintomas))
    (test (eq ?nombre-enfermedad ?nombre))
    =>
    (printout t "La enfermedad " ?nombre-enfermedad " presenta los síntomas de: " )
    (foreach ?sintoma $?sintomas
        (printout t ?sintoma ", ")
    )
    (printout t crlf)
)

(defrule solicitar-sintomas
    =>
    (printout t "Ingrese los síntomas separados por espacios: " crlf)
    (bind ?input (readline))
    (assert (consulta-sintomas (sintomas (explode$ ?input))))
)

(defrule diagnosticar-enfermedad
    ?consulta <- (consulta-sintomas (sintomas $?user-sintomas))
    ?enfermedad <- (enfermedad (nombre ?nombre) (sintomas $?sintomas))
    (test (subsetp $?user-sintomas $?sintomas))
    =>
    (printout t "La enfermedad podría ser: " ?nombre crlf)
)