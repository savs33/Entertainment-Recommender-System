;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 3. weather Group Business Rules 1
; If it is raining
; THEN activities which are indoors should be prioritised
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defrule R301-raining
		(personal-data (predictedWeather Rain))
		?activity <- (activity (activitySheltered ?activitySheltered)
			(activityCF ?aCF) (activityRules ?appliedRules))
		(test (neq ?activitySheltered nil))
		(test (eq (numberp (str-index R301 ?appliedRules)) FALSE))
		(test (or (eq Indoor ?activitySheltered) (eq Both ?activitySheltered	)))
		=>
;		 (printout t "predictedWeather " ?predictedWeather " activitySheltered " ?activitySheltered crlf)
		 (modify ?activity (activityCF =(* ?aCF 1.1)) (activityRules =(str-cat R301 ?appliedRules)))
)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 3. Age Rule group Business Rule 2
; If the age is > 56 and alone
; then go to the park for a walk
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defrule R302-Haze
		(personal-data (predictedWeather Haze))
		?activity <- (activity (activitySheltered Outdoor))
		=>
		 (retract ?activity)
)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Business Rule 3
; If the temperature is above 34 degrees then outdoor activities are depriortised
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defrule R303-Hotweather
		(personal-data (predictedTemperature ?predictedTemperature&:(> ?predictedTemperature 34)))
		?activity <- (activity (activitySheltered Outdoor)
		;CF value for the activty and the rules applied
		(activityCF ?aCF) (activityRules ?appliedRules))
		; Check if the rule has been applied before
		(test (eq (numberp (str-index R303 ?appliedRules)) FALSE))
		=>	;Set the CF of the activity to 0, record that the rule has been applied
		(modify ?activity			(activityCF =(* ?aCF (+ 1 -0.1))) (activityRules =(str-cat R303 ?appliedRules)))
)
