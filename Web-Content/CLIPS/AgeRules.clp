;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 3. Age Rule group Business Rule 1
; If age is between 13 to 21 and outdoor
; then outdoor Leisure activities are prioritised
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defrule R801-youngLoveLeisure
	(personal-data (age ?age&:(< ?age 22)) (sheltered Outdoor))

		?activity <- (activity (category Leisure) (activityTitle ?activityTitle) (activitySheltered Outdoor)
		;CF value for the activty and the rules applied
		(activityCF ?aCF) (activityRules ?appliedRules))
		; Check if the rule has been applied before
		(test (eq (numberp (str-index R801 ?appliedRules)) FALSE))

		=>	;Set the CF of the activity to 0, record that the rule has been applied
		(assert (activityShortList (activityTitle ?activityTitle) (cf ?*PosCf*)))
		(modify ?activity (activityRules =(str-cat R801 ?appliedRules)))
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 3. Age Rule group Business Rule 2
; If the age is > 56 and alone
; then go to the park for a walk
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defrule R802-oldSoloWalkInThePark
		(personal-data (age ?age&:(> ?age 55)) (groupProfile ?groupProfile&:(eq ?groupProfile "Solo"))
		)
		?activity <- (activity (category Nature) (activityTitle ?activityTitle) (activitySuitableForElderly Yes)
		;CF value for the activty and the rules applied
		(activityCF ?aCF) (activityRules ?appliedRules))
		; Check if the rule has been applied before
		(test (eq (numberp (str-index R802 ?appliedRules)) FALSE))

	  ;test for the criteria
		(test (eq (numberp (str-index "Park" ?activityTitle)) TRUE))
		=>
		(assert (activityShortList (activityTitle ?activityTitle) (cf ?*PosCf*)))
		(modify ?activity (activityRules =(str-cat R802 ?appliedRules)))
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Business Rule 3
; If age is between 22 to 35 and night activity will be for pub?
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defrule R803-youngAdultPubs
		(personal-data (age ?age&:(< ?age 36)&:(> ?age 21)))
		?activity <- (activity (category Culinary) (activityTitle ?activityTitle)
		;CF value for the activty and the rules applied
		(activityCF ?aCF) (activityRules ?appliedRules))
		; Check if the rule has been applied before
		(test (eq (numberp (str-index R803 ?appliedRules)) FALSE))
	  ;test for the criteria
		(test (eq (numberp (str-index "Pub" ?activityTitle)) TRUE))
		=>
		(assert (activityShortList (activityTitle ?activityTitle) (cf ?*PosCf*)))
		(modify ?activity	(activityRules =(str-cat R803 ?appliedRules)))
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Business Rule 4
; If age is between 22 to 35 and they are going alone then they prefer architecture
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defrule R804-youngAdultSoloArchitecture
		(personal-data (groupProfile "Just me") (age ?age&:(>= ?age 22)&:(<= ?age 35)))
		?activity <- (activity (category Architecture) (activityTitle ?activityTitle)
		;CF value for the activty and the rules applied
		(activityCF ?aCF) (activityRules ?appliedRules))
		; Check if the rule has been applied before
		(test (eq (numberp (str-index R804 ?appliedRules)) FALSE))
	  ;test for the criteria
		=>
		(assert (activityShortList (activityTitle ?activityTitle) (cf ?*PosCf*)))
		(modify ?activity	(activityRules =(str-cat R804 ?appliedRules)))
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Business Rule 4
; If age is between 22 to 35 and they are going alone then they prefer architecture
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defrule R805-ClarkeQuayDrinks18to21
		(personal-data (nationality Singaporean) (age ?age&:(>= ?age 18)&:(<= ?age 21)))
		?activity <- (activity (category Culinary) (activityTitle ?activityTitle)
		;CF value for the activty and the rules applied
		(activityCF ?aCF) (activityRules ?appliedRules))
		; Check if the rule has been applied before
		(test (eq (numberp (str-index R805 ?appliedRules)) FALSE))
				(test (eq (numberp (str-index "Pub" ?appliedRules)) TRUE))
	  ;test for the criteria
		=>
		(assert (activityShortList (activityTitle ?activityTitle) (cf ?*PosCf*)))
		(modify ?activity	(activityRules =(str-cat R805 ?appliedRules)))
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Business Rule 5
; If they are underlegal drinking age then pubs are out
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defrule R806-UnderLegalDrinkingAge
	(exists (Age UnderLegalDrinkingAge))
	?activity <- (activity (category Culinary) (activityId  ?activityId) (activityTitle ?activityTitle)
	;CF value for the activty and the rules applied
	(activityCF ?aCF) (activityRules ?appliedRules))
	; Check if the rule has been applied before
	(test (eq (numberp (str-index R806 ?appliedRules)) FALSE))
	;test for the criteria
	(test (eq (numberp (str-index "Pub" ?activityTitle)) TRUE))
	=>	;Set the CF of the activity to 0, record that the rule has been applied
				(assert (activityShortList (activityTitle ?activityTitle) (cf ?*NotAvailable*)))
				(modify ?activity		(activityRules =(str-cat R806 ?appliedRules)))

)
