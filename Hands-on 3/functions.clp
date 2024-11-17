(deffunction agregar-enfermedad (?nombre-enfermedad $?sintomas)
   (assert (enfermedad (nombre ?nombre-enfermedad) (sintomas $?sintomas)))
   (printout t "Enfermedad agregada: " ?nombre-enfermedad crlf)
)


(deffunction eliminar-enfermedad (?nombre-enfermedad)
    (do-for-all-facts ((?e enfermedad))
        (if (eq ?e:nombre ?nombre-enfermedad) then
            (retract ?e)
            (printout t "La enfermedad " ?nombre-enfermedad " ha sido eliminada" crlf)
        )
    )
    nil ;no muestra mensaje de retorno
)

(deffunction editar-enfermedad (?nombre-enfermedad $?sintomas)
    (do-for-all-facts ((?e enfermedad))
        (if (eq ?e:nombre ?nombre-enfermedad) then
            (retract ?e)
            (assert(enfermedad(nombre ?nombre-enfermedad) (sintomas $?sintomas)))
            (printout t "La enfermedad " ?nombre-enfermedad " ha sido modificada" crlf)
        )
    )
    nil ;no muestra mensaje de retorno
)