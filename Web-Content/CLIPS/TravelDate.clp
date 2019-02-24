;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 5. TravelDate Group Business Rules 1
; Activities in January and Feburary is Chinatown
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defrule R501-visitJanuaryFeburary
	(personal-data (travelDate ?year ?month&:(< ?month 03) ?day ?time ?dayofWeek))

	?activity <- (activity (activityTitle ?activityTitle)	 (activityOverview ?activityOverview)
		(activityCF ?aCF) (activityRules ?appliedRules))

	(test (eq (numberp (str-index R501 ?appliedRules)) FALSE))
	(test (eq (numberp (str-index "Chinatown" ?activityOverview)) TRUE))
		=>
		(assert (activityShortList (activityTitle ?activityTitle) (cf ?*PosCf*)))
		(modify ?activity (activityRules =(str-cat R501 ?appliedRules)))
)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 5. TravelDate Group Business Rules 2
; If travel date is between 27 Apr to 12 May 2018 (Singapore International Festival of the Arts)
; , Performance-Arts activities will be prioritised
; If the travel date is in August the recommend Arts for arts festival
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defrule R502-artsFestivalAprtoMay
	(personal-data (travelDate ?year ?month ?day ?time ?dayofWeek))

	?activity <- (activity (category Arts) (activityTitle ?activityTitle)
	 (activityOverview ?activityOverview) (activityAddress ?activityAddress)
		(activityCF ?aCF) (activityRules ?appliedRules))

	(test (eq (numberp (str-index R502 ?appliedRules)) FALSE))
	(test (or (and (= ?month 4 ) (> ?day 26)) (and (= ?month 5)  (< ?day 13)) (= ?month 08)))
		=>
		(assert (activityShortList (activityTitle ?activityTitle) (cf ?*PosCf*)))
		(modify ?activity  (activityRules =(str-cat R502 ?appliedRules)))
)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 5. TravelDate Group Business Rules 3
; If travel date is on between May and June receommend shopping activities
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defrule R503-greatSingaporeSale
	(personal-data (travelDate ?year ?month ?day ?time ?dayofWeek))

	?activity <- (activity (category Leisure)
	 (activityOverview ?activityTitle)
		(activityCF ?aCF) (activityRules ?appliedRules))

	(test (eq (numberp (str-index R503 ?appliedRules)) FALSE))
	(test (or (= ?month 6 ) (= ?month 5) ))
	(test (eq (numberp (str-index "Shopping" ?activityTitle)) TRUE))
		=>
		(modify ?activity
			(activityCF =(* ?aCF (+ 1 0.1))) (activityRules =(str-cat R503 ?appliedRules)))
)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 5. TravelDate Group Business Rules 4
; If travel date is on between May and June recommend Kampong Glam
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defrule R504-Ramadan
	(personal-data (travelDate ?year ?month ?day ?time ?dayofWeek))

	?activity <- (activity (category Places)
	 (activityOverview ?activityTitle)
		(activityCF ?aCF) (activityRules ?appliedRules))

	(test (eq (numberp (str-index R504 ?appliedRules)) FALSE))
	(test (or (= ?month 6 ) (= ?month 5) ))
	(test (eq (numberp (str-index "Kampong" ?activityTitle)) TRUE))
		=>
		(modify ?activity
			(activityCF =(* ?aCF (+ 1 0.1))) (activityRules =(str-cat R504 ?appliedRules)))
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 5. TravelDate Group Business Rules 5
; If the travel date is in July 2018 then go Geylang serai at night
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defrule R505-July
	(personal-data (travelDate ?year 07 ?day ?time ?dayofWeek))

	?activity <- (activity (category Leisure)
	 (activityOverview ?activityTitle)
		(activityCF ?aCF) (activityRules ?appliedRules))

	(test (eq (numberp (str-index R505 ?appliedRules)) FALSE))
	(test (eq (numberp (str-index "Geylang Serai" ?activityTitle)) TRUE))
		=>
		(modify ?activity
			(activityCF =(* ?aCF (+ 1 0.1))) (activityRules =(str-cat R505 ?appliedRules)))
)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 5. TravelDate Group Business Rules 6
; If the travel date is August then Epslande or MBS for the fireworks during the saturday
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defrule R506-NationalDay
	(personal-data (travelDate ?year 08 ?day ?time Sat))

	?activity <- (activity (category Architecture)
	 (activityOverview ?activityTitle)
		(activityCF ?aCF) (activityRules ?appliedRules))

	(test (eq (numberp (str-index R506 ?appliedRules)) FALSE))
	(test (or (eq (numberp (str-index "Marina Bay Sands" ?activityTitle)) TRUE)
			(eq (numberp (str-index "Esplanade" ?activityTitle)) TRUE)))
		=>
		(modify ?activity
			(activityCF =(* ?aCF (+ 1 0.1))) (activityRules =(str-cat R506 ?appliedRules)))
)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 5. TravelDate Group Business Rules 8
; If travel date is in September (mid Autumn Festival), go to Chinese Garden
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defrule R508-MidAutumnFestival
	(personal-data (travelDate ?year 09 ?day ?time ?dayofWeek))

	?activity <- (activity (category Nature)
	 (activityOverview ?activityTitle)
		(activityCF ?aCF) (activityRules ?appliedRules))

	(test (eq (numberp (str-index R508 ?appliedRules)) FALSE))
	(test (eq (numberp (str-index "Chinese Garden" ?activityTitle)) TRUE))
		=>
		(modify ?activity
			(activityCF =(* ?aCF (+ 1 0.1))) (activityRules =(str-cat R508 ?appliedRules)))
)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 5. TravelDate Group Business Rules 9
; If the travel date is in November then go Little India
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defrule R509-MidAutumnFestival
	(personal-data (travelDate ?year 11 ?day ?time ?dayofWeek))

	?activity <- (activity (category Places)
	 (activityOverview ?activityTitle)
		(activityCF ?aCF) (activityRules ?appliedRules))

	(test (eq (numberp (str-index R509 ?appliedRules)) FALSE))
	(test (eq (numberp (str-index "Little India" ?activityTitle)) TRUE))
		=>
		(modify ?activity
			(activityCF =(* ?aCF (+ 1 0.1))) (activityRules =(str-cat R509 ?appliedRules)))
)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 5. TravelDate Group Business Rules 10
; If travel date is in September (mid Autumn Festival), go to Chinese Garden
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defrule R510-VesakToothRelic
	(personal-data (travelDate ?year 05 ?day ?time ?dayofWeek))

	?activity <- (activity (category Religion)
	 (activityOverview ?activityTitle)
		(activityCF ?aCF) (activityRules ?appliedRules))

	(test (eq (numberp (str-index R510 ?appliedRules)) FALSE))
	(test (eq (numberp (str-index "Tooth Relic" ?activityTitle)) TRUE))
		=>
		(modify ?activity
			(activityCF =(* ?aCF (+ 1 0.1))) (activityRules =(str-cat R510 ?appliedRules)))
)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 5. TravelDate Group Business Rules 11
; Activities in December is Orchard
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defrule R511-visitDecember
	(personal-data (travelDate ?year 12 ?day ?time ?dayofWeek))

	?activity <- (activity (activityAddress ?activityAddress)
	 (activityOverview ?activityOverview)
		(activityCF ?aCF) (activityRules ?appliedRules))

	(test (eq (numberp (str-index R511 ?appliedRules)) FALSE))
	(test (or (eq (numberp (str-index "Orchard" ?activityOverview)) TRUE)
		(eq (numberp (str-index "Orchard" ?activityAddress)) TRUE)
	))
		=>
		(modify ?activity
			(activityCF =(* ?aCF (+ 1 0.1))) (activityRules =(str-cat R511 ?appliedRules)))
)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Business Rule
; If acitivy is not open on the day of travel
; THEN those activity are excluded
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defrule R512-IsActivityOpenOnPublicHolidays
		(exists (TravelDate PublicHoliday))
		?activity <- (activity (activityId ?activityId)  (activityTitle ?activityTitle)
			(activityClosedDays ?activityClosedDays)
		;CF value for the activty and the rules applied
		(activityCF ?aCF) (activityRules ?appliedRules))
		; Check if the rule has been applied before
		(test (eq (numberp (str-index R512 ?appliedRules)) FALSE))

		;test for the criteria
		(test (eq (numberp (str-index "PH" ?activityClosedDays)) TRUE))
		=>	;Set the CF of the activity to 0, record that the rule has been applied
			(assert (Closed ?activityId ?activityTitle))
			(modify ?activity	(activityRules =(str-cat R512 ?appliedRules)))
)
