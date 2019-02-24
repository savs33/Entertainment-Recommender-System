;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 7. ItineraryFood choices
; If the budget is less than 20 the mode of transport will be public
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defrule R701-FoodSelectionMorning
		(exists (itineraryPlanLength Short))
		(exists (itineraryStart Morning))
		?activity <- (activity (category Culinary)
		(activityId ?activityId) (activityTitle ?activityTitle)
		;CF value for the activty and the rules applied
		(activityCF ?aCF) (activityRules ?appliedRules))

		(test (eq (numberp (str-index R701 ?appliedRules)) FALSE))
		(test (and (eq (numberp (str-index "Kaya Toast" ?activityTitle)) FALSE)
			(eq (numberp (str-index "Roti Prata" ?activityTitle)) FALSE)
		))
		=>
		  (assert (activityShortList (activityTitle ?activityTitle) (cf ?*NotAvailable*)))
			(modify ?activity	(activityRules =(str-cat R701 ?appliedRules)))

	)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 7. ItineraryFood choices
; If the budget is less than 20 the mode of transport will be public
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defrule R702-FoodMorningBreakfastAndLunch
	(exists (itineraryPlanLength HalfDay))
	(exists (itineraryStart Morning))
	?activity <- (activity (category Culinary)
	(activityId ?activityId) (activityTitle ?activityTitle)
	;CF value for the activty and the rules applied
	(activityCF ?aCF) (activityRules ?appliedRules))

	(test (eq (numberp (str-index R702 ?appliedRules)) FALSE))
	(test (or (eq (numberp (str-index "Chilli Crab" ?activityTitle)) TRUE)
		(eq (numberp (str-index "Pub" ?activityTitle)) TRUE)
		(eq (numberp (str-index "Rojak" ?activityTitle)) TRUE)
	))
	=>
		(assert (activityShortList (activityTitle ?activityTitle) (cf ?*NotAvailable*)))
		(modify ?activity	(activityRules =(str-cat R702 ?appliedRules)))

)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 7. ItineraryFood choices
; If the budget is less than 20 the mode of transport will be public
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defrule R703-FoodEvening
	(not (itineraryPlanLength FullDay))
	(not (itineraryStart Morning))
	?activity <- (activity (category Culinary)
	(activityId ?activityId) (activityTitle ?activityTitle)
	;CF value for the activty and the rules applied
	(activityCF ?aCF) (activityRules ?appliedRules))

	(test (eq (numberp (str-index R702 ?appliedRules)) FALSE))
	(test (or
		(eq (numberp (str-index "Roti Prata" ?activityTitle)) TRUE)
		(eq (numberp (str-index "Kaya Toast" ?activityTitle)) TRUE)
		(eq (numberp (str-index "Fried Carrot Cake" ?activityTitle)) TRUE)
	))
	=>
		(assert (activityShortList (activityTitle ?activityTitle) (cf ?*NotAvailable*)))
		(modify ?activity	(activityRules =(str-cat R702 ?appliedRules)))

)
