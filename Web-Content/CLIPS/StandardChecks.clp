;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Business Rule 1
; If start time of the itinerary is after the cloins time
; THEN those activities will be ignored
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defrule R001-TravelingToday
	(personal-data (travelDate ?year ?month ?day ?time ?dayofWeek))
		=> ;Set the CF of the activity to 0
	(bind ?a (local-time))
	(if (and (eq ?year (nth$ 1 ?a)) (eq ?month (nth$ 2 ?a))  (eq ?day (nth$ 3 ?a)))
	then
		(assert (TravelDate Today))
	)
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Business Rule 2
; If acitivy is not open on the day of travel
; THEN those activity are excluded
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defrule R002IsActivityOpenOnTravelDay
		(personal-data (travelDate ?year ?month ?day ?time ?dayofWeek))
		?activity <- (activity (activityId ?activityId)  (activityTitle ?activityTitle)
			(activityClosedDays ?activityClosedDays)
		;CF value for the activty and the rules applied
		(activityCF ?aCF) (activityRules ?appliedRules))
		; Check if the rule has been applied before
		(test (eq (numberp (str-index R002 ?appliedRules)) FALSE))

	  ;test for the criteria
		(test (eq (numberp (str-index ?dayofWeek ?activityClosedDays)) TRUE))
		=>	;Set the CF of the activity to 0, record that the rule has been applied
			(assert (activityShortList (activityTitle ?activityTitle) (cf ?*NotAvailable*)))
			(modify ?activity	(activityRules =(str-cat R002 ?appliedRules)))
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Business Rule 3
; If age is under 18 then pubs are excluded
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defrule R003-IsUnder18
		(personal-data (age ?age&:(< ?age 18)))
		=>	;Set the CF of the activity to 0, record that the rule has been applied
			(assert (Age UnderLegalDrinkingAge))
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Business Rule 4
; If the activtiy cost exceeds the budget
; THEN those activities should be removed
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	(defrule R004-OverMyBudget
				?data-fact <- (personal-data (budget ?availableBudget))
				?activity <- (activity  (activityTitle ?activityTitle) (activityMinimumBudget ?maxCost)
				;CF value for the activty and the rules applied
				(activityCF ?aCF) (activityRules ?appliedRules))
				; Check if the rule has been applied before
				(test (eq (numberp (str-index R004 ?appliedRules)) FALSE))

				(test (neq ?availableBudget nil))
				(test (neq ?maxCost nil))
				(test (>= ?maxCost ?availableBudget))
				=> ;Set the CF of the activity to 0
					(assert (activityShortList (activityTitle ?activityTitle) (cf ?*NotAvailable*)))
					(modify ?activity (activityRules =(str-cat R004 ?appliedRules)))
	)


		;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	  ;; Business Rule 5
	  ; If activity requires appointment (Closed column) and activity is planned for today
		; then activity will be depriotised
	  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	(defrule R005-AppointmentRequired
				(exists (TravelDate Today))
				?activity <- (activity  (activityTitle ?activityTitle) (activityClosedDays ?activityClosedDays)
				;CF value for the activty and the rules applied
				(activityCF ?aCF) (activityRules ?appliedRules))
				; Check if the rule has been applied before
				(test (eq (numberp (str-index R005 ?appliedRules)) FALSE))

				(test (eq (numberp (str-index "Appointment" ?activityClosedDays)) TRUE))
				=>
				(assert (activityShortList (activityTitle ?activityTitle) (cf ?*NegCf*)))
				(modify ?activity (activityRules =(str-cat R005 ?appliedRules))	)
 )

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;; Check if today is a public holiday
	; If the travel date is on a public holiday and the activity is not open remove it from the recommended list
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	(defrule R006-IsPublicHoliday
		(personal-data (travelDate ?year ?month ?day ?time ?dayofWeek))

		(publicHoliday (holiday ?holiday)
			; (date ?PHyear&:(= ?PHyear ?year) ?PHmonth&:(= ?PHmonth ?month)			?PHday&:(= ?PHday ?day) ?PHdayofWeek&:(= ?PHdayofWeek ?dayofWeek)   )
			(date  ?year ?month ?day  ?dayofWeek)
					)
			(test (neq ?holiday nil))
			=>
			(assert (TravelDate PublicHoliday))
	)

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;; Business Rule 7
	; If start time of the itinerary is after the cloins time
	; THEN those activities will be ignored
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	(defrule R007-HasActivityClosedFortheDay
			(personal-data (travelDate ?year ?month ?day ?time ?dayofWeek))

			?activity <- (activity (activityId ?activityId) (activityTitle ?activityTitle)
			(activityStartTime ?activityStartTime) (activityEndTime ?activityEndTime)
			;CF value for the activty and the rules applied
			(activityCF ?aCF) (activityRules ?appliedRules))
			; Check if the rule has been applied before
			(test (neq ?activityStartTime nil))
			(test (eq (numberp (str-index R007 ?appliedRules)) FALSE))

		  ;test for the criteria
			(test 	(and (> (+ ?time 100) ?activityEndTime) (> ?activityEndTime 0500)))
			=>	;Set the CF of the activity to 0, record that the rule has been applied
				(assert (activityShortList (activityTitle ?activityTitle) (cf ?*NotAvailable*)))
				(modify ?activity	(activityRules =(str-cat R007 ?appliedRules)))
	)

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;; Check if today is a public holiday
	; If the travel date is on a public holiday and the activity is not open remove it from the recommended list
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	(defrule R008-IsOnLowBudget
		(personal-data (budget ?budget&:(< ?budget ?*LowBudget*) ))
			=>
			(assert (Budget LowBudget))
	)
