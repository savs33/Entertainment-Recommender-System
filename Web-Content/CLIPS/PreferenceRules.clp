;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 1. Preference Business Rule 1
; If there is a preference for a specific region
; THEN those activities should have a higher preference
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defrule R101-regionPrioritisation
		(personal-data (interestedRegion ?itineraryRegions))
		;(not (activity (category Culinary)))
		?activity <- (activity (activityTitle ?activityTitle) (activityRegion ?activityReg)
		;CF value for the activty and the rules applied
		(activityCF ?aCF) (activityRules ?appliedRules))
		; Check if the rule has been applied before
		(test (neq ?activityReg nil))
		(test (eq (numberp (str-index R101 ?appliedRules)) FALSE))

		=>
		(switch  (eq (numberp (str-index ?itineraryRegions ?activityReg)) TRUE)
		(case TRUE then
			(assert (activityShortList (activityTitle ?activityTitle) (cf ?*PosCf*)))
			(modify ?activity	(activityRules =(str-cat "+R101" ?appliedRules)))
		)
		(case FALSE then
			(assert (activityShortList (activityTitle ?activityTitle) (cf ?*NegCf*)))
			(modify ?activity	(activityRules =(str-cat "-R101" ?appliedRules)))
			)
		)
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 1. Preference Business Rule 2
; If there are categories which selected
; THEN those activities will be prioritised
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defrule R102-prioritiseInterest
		?activity <- (activity (category ?category) (activityTitle ?activityTitle)
		(activityCF ?aCF) (activityRules ?appliedRules))
		; (test (eq ?category ?interest ))
		(interestedCategories (category ?interest) (cf ?InterestLevel))

		(test (eq (numberp (str-index R102 ?appliedRules)) FALSE))
		(test (eq ?category ?interest ) )
		=>
			(assert (activityShortList (activityTitle ?activityTitle) (cf ?*PosCf*)))
			(modify ?activity (activityRules =(str-cat R102 ?appliedRules)))
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 1. Preference Business Rule 3
; If the person like animals
; then activities like bird park, zoo, pet cafes will be selected and displayed
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defrule R103-likeAnimals
		(personal-data (likeAnimals Y))
		(exists (activity (category Nature)))
		?activity <- (activity (category ?category)	(activityTitle ?activityTitle) (activityOverview ?activityOverview)
		(activityCF ?aCF) (activityRules ?appliedRules))
		; (test (eq ?category ?interest ))
		(test (eq (numberp (str-index R103 ?appliedRules)) FALSE))
		(test (or (eq (numberp (str-index "Zoo" ?activityTitle)) TRUE)
		 (eq (numberp (str-index "Safari" ?activityTitle)) TRUE)
		 (eq (numberp (str-index "animals" ?activityOverview)) TRUE)))
		=>
			(assert (activityShortList (activityTitle ?activityTitle) (cf ?*PosCf*)))
			(modify ?activity (activityRules =(str-cat R103 ?appliedRules)))
)
