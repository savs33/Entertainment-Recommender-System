;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 4. Young and Old Group Business Rules 1
; Activities for kids are like science centre, zoo night safari,
; botanic gardens (sundial), gardens by the bay, stamp muesum
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defrule R401-kidsActivities
	(personal-data (groupProfile kids))
	?activity <- (activity (activityTitle ?activityTitle)  (activityProfile ?activityProfile)
	 (activityOverview ?activityOverview)
		(activityCF ?aCF) (activityRules ?appliedRules))

	(test (eq (numberp (str-index R401 ?appliedRules)) FALSE))
	(test  (or (eq (numberp (str-index kids ?activityOverview)) TRUE)
	(eq (numberp (str-index "Children" ?activityProfile )) TRUE)	) )
	=>
	 (assert (activityShortList (activityTitle ?activityTitle) (cf ?*PosCf*)))
	 (modify ?activity  (activityRules =(str-cat R401 ?appliedRules)))
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 4. Young and Old Group Business Rules 2
; If there are kids then pubs are out
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defrule R402-noDrinksforKids
	(personal-data (groupProfile kids))
	?activity <- (activity (category Culinary) (activityTitle ?activityTitle)
		(activityCF ?aCF) (activityRules ?appliedRules))

	(test (eq (numberp (str-index R402 ?appliedRules)) FALSE))
	(test (eq (numberp (str-index "Pub" ?activityTitle)) TRUE))
	=>
	 (assert (activityShortList (activityTitle ?activityTitle) (cf ?*NegCf*)))
	 (modify ?activity  (activityRules =(str-cat R402 ?appliedRules)))
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 4. Young and Old Group Business Rules 3
; If group has members with young children,
; then activities wilthout "Family with young children" will be depriorised
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defrule R403-withYoungChildren
		(personal-data (familyHasYoungKids Y))
		?activity <- (activity  (activityTitle ?activityTitle) (activitySuitableForYoungChildren No)
		;CF value for the activty and the rules applied
		(activityCF ?aCF) (activityRules ?appliedRules))
		; Check if the rule has been applied before
		(test (eq (numberp (str-index R403 ?appliedRules)) FALSE))

		=>	;Set the CF of the activity -0.1
		(assert (activityShortList (activityTitle ?activityTitle) (cf ?*NegCf*)))
		(modify ?activity (activityRules =(str-cat R403 ?appliedRules)))
	)

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;; 4. Young and Old Group Business Rules 4
	; If group has members with young children,
	; then activities wilthout "Family with young children" will be depriorised
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	(defrule R404-withElderly
			(personal-data (familyHasElderly Y))
			?activity <- (activity (activityTitle ?activityTitle)  (activitySuitableForElderly No)
			;CF value for the activty and the rules applied
			(activityCF ?aCF) (activityRules ?appliedRules))
			; Check if the rule has been applied before
			(test (eq (numberp (str-index R404 ?appliedRules)) FALSE))

			=>	;Set the CF of the activity -0.1
			(assert (activityShortList (activityTitle ?activityTitle) (cf ?*NegCf*)))
			(modify ?activity	(activityRules =(str-cat R404 ?appliedRules)))
		)


		;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		;; 4. Young and Old Group Business Rules 5
		; If group has members with young children,
		; then activities wilthout "Family with young children" will be depriorised
		;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		(defrule R405-withSpecialNeeds
				(personal-data (specialNeeds Y))
				?activity <- (activity  (activityTitle ?activityTitle) (activitySpecialNeeds No)
				;CF value for the activty and the rules applied
				(activityCF ?aCF)  (activityRules ?appliedRules))
				; Check if the rule has been applied before
				(test (eq (numberp (str-index R405 ?appliedRules)) FALSE))

				=>	;Set the CF of the activity to 0
				(assert (activityShortList (activityTitle ?activityTitle) (cf ?*SpecialNeeds*)))
				(modify ?activity (activityRules =(str-cat R405 ?appliedRules)))
			)
