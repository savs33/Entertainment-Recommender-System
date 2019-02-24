;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 2.  Nationality Business Rule 7
; If there are Europeans and they are 35 and above
; THEN Historical sites should be prioritised
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defrule R201-oldereuropeansLoveHistory
		?data-fact <- (personal-data (nationality European) (age ?age))
		?activity <- (activity (category History) (activityTitle ?activityTitle)
		;CF value for the activty and the rules applied
			(activityCF ?aCF) (activityRules ?appliedRules))
		; Check if the rule has been applied before
		(test (eq (numberp (str-index R201 ?appliedRules)) FALSE))

		(test (>= ?age 35))
		=>	; Apply CF and record the application of Rule to activity
		(assert (activityShortList (activityTitle ?activityTitle) (cf ?*PosCf*)))
		(modify ?activity  (activityRules =(str-cat R201 ?appliedRules)) )
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 2. Nationality Business Rule 2
; If there are british
; THEN colonial activities can be prioritised
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defrule R202-britishColonialActivities
		?data-fact <- (personal-data (nationality European) )
		?activity <- (activity (activityTitle ?activityTitle) (activityShortContent ?description)
			(activityCF ?aCF)			(activityRules ?appliedRules))
		; Check if the rule has been applied before
		(test (eq (numberp (str-index R202 ?appliedRules)) FALSE))

		(test (or
			(eq (numberp (str-index colonial ?description)) TRUE)
			 (eq (numberp (str-index civic ?description)) TRUE)
		))
		=>	; Apply CF and record the application of Rule to activity
		(assert (activityShortList (activityTitle ?activityTitle) (cf ?*PosCf*)))
		(modify ?activity (activityRules =(str-cat R202 ?appliedRules)) )
)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 2. Nationality Business Rule 3
; If there are vistors from India
; THEN Nature activities  should be prioritised
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defrule R203-indiansLikeNature
		?data-fact <- (personal-data (nationality Indian))
		?activity <- (activity (category Nature) (activityTitle ?activityTitle)
			(activityCF ?aCF)			(activityRules ?appliedRules))
			; Check if the rule has been applied before
		(test (eq (numberp (str-index R203 ?appliedRules)) FALSE))

		=>	; Apply CF and record the application of Rule to activity
		(assert (activityShortList (activityTitle ?activityTitle) (cf ?*PosCf*)))
		(modify ?activity (activityRules =(str-cat R203 ?appliedRules)) )
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 2. Nationality  Business Rule 10
; If there are vistors from India
; THEN budget shopping should be prioritised
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defrule R204-indiansLikeBudgetShopping
		?data-fact <- (personal-data (nationality Indian))
		?activity <- (activity (category Leisure) (activityTitle ?activityTitle)
		 (activityMinimumBudget ?activityMinimumBudget)
			(activityCF ?aCF)			(activityRules ?appliedRules))
			; Check if the rule has been applied before
		(test (eq (numberp (str-index R204 ?appliedRules)) FALSE))

		(test (eq (numberp (str-index Shopping ?activityTitle)) TRUE))
		(test (>= 50 ?activityMinimumBudget))
		=>	; Apply CF and record the application of Rule to activity
		(assert (activityShortList (activityTitle ?activityTitle) (cf ?*PosCf*)))
		(modify ?activity (activityRules =(str-cat R204 ?appliedRules)) )
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 2. Nationality  Business Rule 5
; If european and night itinerary then drinking @ clarke quay
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defrule R205-europeansNightClarkeQuay
		(personal-data (nationality European))
		?activity <- (activity (category Culinary) (activityTitle ?activityTitle)  (activityAddress ?activityAddress)
			(activityCF ?aCF)			(activityRules ?appliedRules))
			; Check if the rule has been applied before
		(test (eq (numberp (str-index R205 ?appliedRules)) FALSE))

		(test (eq (numberp (str-index "Clarke Quay" ?activityAddress)) TRUE))
		=>	; Apply CF and record the application of Rule to activity
		(assert (activityShortList (activityTitle ?activityTitle) (cf ?*PosCf*)))
		(modify ?activity (activityRules =(str-cat R205 ?appliedRules)) )
)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 2. Nationality  Business Rule 6
; If european and night itinerary then drinking @ clarke quay
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defrule R206-europeansNightClarkeQuay
		(personal-data (nationality ?nationality&:(neq ?nationality Singaporean)))
		(not (personal-data (timeInSingapore "More then 3 years")))
		(personal-data (timeInSingapore ?timeInSingapore))
		?activity <- (activity (category Culinary) (activityTitle ?activityTitle) (activityAddress ?activityAddress)
			(activityCF ?aCF)			(activityRules ?appliedRules))
			; Check if the rule has been applied before
		(test (eq (numberp (str-index R206 ?appliedRules)) FALSE))
		(test (eq (numberp (str-index "Clarke Quay" ?activityAddress)) TRUE))
		=>	; Apply CF and record the application of Rule to activity
		(assert (activityShortList (activityTitle ?activityTitle) (cf ?*PosCf*)))
		(modify ?activity (activityRules =(str-cat R206 ?appliedRules)) )
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 2. Nationality  Business Rule 7
; If the person is Singapore or has been in SIngapore for more than 3 year
; the activities with "Off the beaten track" in the shortContent field will be prioritised
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defrule R207-OffTheBeatenTrack
		(personal-data (nationality ?nationality) (timeInSingapore ?timeInSingapore)  )

		?activity <- (activity (activityTitle ?activityTitle)  (activityOverview ?activityOverview) (activityShortContent ?activityShortContent)
			(activityCF ?aCF)			(activityRules ?appliedRules))
			; Check if the rule has been applied before
		(test (eq (numberp (str-index R207 ?appliedRules)) FALSE))
		(test (or (eq ?nationality Singaporean) (eq ?timeInSingapore "More then 3 years")))
		(test (or (eq (numberp (str-index "off the beaten track" ?activityOverview)) TRUE)
		(eq (numberp (str-index "off the beaten track" ?activityShortContent)) TRUE)
		))
		=>	; Apply CF and record the application of Rule to activity
		(assert (activityShortList (activityTitle ?activityTitle) (cf ?*PosCf*)))
		(modify ?activity (activityRules =(str-cat R207 ?appliedRules)) )
)
