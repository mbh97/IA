;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; sc-mapcar (x y)
;;; Calcula la similitud coseno de un vector usando mapcar
;;;
;;; INPUT: x: vector, representado como una lista
;;; y: vector, representado como una lista
;;;
;;; OUTPUT: similitud coseno entre x e y
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;; Funcion que calcula el sumatorio de una serie de numeros de una lista
(defun sumatorio (x) 
	(reduce #'+ x))

;;; Funcion que calcula el producto escalar de dos vectores
(defun prod-escalar (x y) 
	(sumatorio (mapcar #'(lambda (z w) (* z w)) x y)))

;;; Funcion que calcula el modulo de un vector
(defun modulo (x) 
	(sqrt (prod-escalar x x)))

;;; Funcion que calcula la longitud de una lista
(defun my-length (x) 
	(if (null x) 
		0 
		(+ 1 (my-length (cdr x)))))

;;; Funcio que comprueba que todos los argumentos de una lista son mayores o iguales a 0
(defun lista-positiva (x) 
	(not (some #'minusp x)))

;;; Funcion que comprueba si los argumentos pasados son correctos
(defun comprueba-arg (x y) 
	(and (lista-positiva x) (lista-positiva y) (eql (my-length x) (my-length y))))

;;; Funcion sc-mapcar (x y)
(defun sc-mapcar (x y) 
	(if (null (comprueba-arg x y)) 
		nil 
		(/ (prod-escalar x y) (* (modulo x) (modulo y)))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; sc-rec (x y)
;;; Calcula la similitud coseno de un vector de forma recursiva
;;;
;;; INPUT: x: vector, representado como una lista
;;; y: vector, representado como una lista
;;;
;;; OUTPUT: similitud coseno entre x e y
;;;

;;; Funcion que calcula el producto escalar recursivamente
(defun prod-esc-rec (x y) 
	(if (null (rest x)) 
		(* (first x) (first y))     ; null rest: multily the (only) element of the list
		(+ (* (first x) (first y)) (prod-esc-rec (rest x) (rest y)))))

;;; Funcion que calcula el modulo de un vector
(defun modulo-rec (x) 
	(sqrt (prod-esc-rec x x)))

;;; Funcion sc-rec (x y)
(defun sc-rec (x y) 
	(if (null (comprueba-arg x y)) 
		nil 
		(/ (prod-esc-rec x y) (* (modulo-rec x) (modulo-rec y)))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; sc-conf (cat vs conf)
;;; Devuelve aquellos vectores similares a una categoria
;;; INPUT: cat: vector que representa a una categoría, representado como una lista
;;; vs: vector de vectores
;;; conf: Nivel de confianza
;;; OUTPUT: Vectores cuya similitud con respecto a la categoría es superior al
;;; nivel de confianza, ordenados
(defun sc-conf (cat vs conf) ...)



;;; Funcion que elimina de lista de lista aquellos vectores cuya similitud sea menor al nivel de confianza
(defun limpia-lista (cat vs conf) 
	(remove-if #'(lambda (y) (< (abs (sc-rec cat y)) conf)) vs))


(defun sc-conf (cat vs conf) 
	(sort (limpia-lista cat vs conf) #'(lambda(y z) (> (sc-rec cat y) (sc-rec cat z)))))



;;Maria
(defun is-ok (cat conf) 
	(and (>= conf 0) (<= conf 1) (lista-positiva cat)))

;;; limpiar vs de longtudes distintas a x y de listas con elementos negativos

(defun limpia-lista1 (cat vs conf n) 
	(remove-if #'(lambda (y) (or (/= (my-length y) n) (not (lista-positiva y)) (< (abs (sc-rec cat y)) conf))) vs))

(defun sc-conf1 (cat vs conf)
	(if (null (is-ok cat conf))
		nil
		(sort (limpia-lista1 cat vs conf (my-length cat)) #'(lambda(y z) (> (sc-rec cat y) (sc-rec cat z))))))




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; sc-classifier (cats texts func)
;; Clasifica a los textos en categorías.
;;;
;;; INPUT: cats: vector de vectores, representado como una lista de listas
;;; texts: vector de vectores, representado como una lista de listas
;;; func: función para evaluar la similitud coseno
;;; OUTPUT: Pares identificador de categoría con resultado de similitud coseno
;;;
(defun sc-classifier (cats texts func) ...)



;;




