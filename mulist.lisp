(in-package :mulist) 
 ;; здесь будет расчет коэффициентов расчетных длин стоек по таблице И.1 СП стальные конструкции
  ;; схема 1
(defvar *nList* '(-6.37299 -6.3952 -4.20019 -4.1831 -4.20581 -2.90791 -2.90838)) ;; список перемещений от еденичных горизонтальных нагрузок 
(defvar *mList* '(-0.267519 -0.270143 -0.257817 -0.162763 -0.258691 -0.362852 -0.37931)) ;; список перемещений от моментов в узле в плоскости рамы
(defun kn-list (list*)
	(mapcar #'(lambda (x) (/ 1 x 1000)) list*))
(defvar *kn-list* (kn-list *nList*))
(defun km-list (list*)
	(mapcar #'(lambda (x) (/ 1 x 1000)) list*))
(defvar *km-list* (km-list *mList*))
(defvar *e* 2.1e7) ;; в тм  - для случая если все колонны одной жесткости
(defvar *llist* '(11.18 11.85 11.18 11.85 12.49 11.18 12.49)) ;; список длин колонн

(defvar *i* 21680) ;; в см4 -- как в сортаменте лиры
(defvar *i_priv* (* *i* 10e-7))
(defvar *ei* (* *e* *i_priv*))
(defvar *aList* (mapcar #'(lambda (x y) (/ (* x y) *ei*)) *km-list* *llist*))
(defvar *bList* (mapcar #'(lambda (x y) (/ (* x (expt y 3)) *ei*)) *kn-list* *llist*))

(defvar *mulist* (mapcar #'(lambda (a b) (sqrt 
	(/ 
		(+ (* 5.4 (+ a 4)) (* b (+ 1.2 (* a 0.25))))
		(+ (* 5.4 (+ a 1)) (* b (+ a 2.4)))))) *aList* *bList*))
;; а теперь выведем все это нахер

(format t "список перемещений от еденичных горизонтальных нагрузок = ~a мм" *nList*)
(format t "список перемещений от моментов в узле в плоскости рамы = ~a рад*1000" *mList*)
;; а теперь распечатаем основные формулы для отчета в libreoffice
(format t "%alpfa = ~a~%" (lispMathTranslator  '(/ (* K_m l) EI)))
(format t "%beta = ~a~%" (lispMathTranslator  '(/ (* K_n l^3) EI)))
(format t "%mu = ~a~%" (lispMathTranslator '(sqrt 
	(/ 
		(+ (* 5.4 (+ a 4)) (* b (+ 1.2 (* a 0.25))))
		(+ (* 5.4 (+ a 1)) (* b (+ a 2.4)))))))
(format t "список к-в %alpfa = ~a~%" *aList*)
(format t "список к-в %beta = ~a~%" *bList*)
(format t "список к-в %mu = ~a~%" *mulist*)