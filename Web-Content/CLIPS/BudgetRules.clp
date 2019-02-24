;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 6. Budget Group Business Rules 1
; If the budget is less than 20 the mode of transport will be public
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defrule R601-LowBudgetTransportMode
		(exists (Budget LowBudget))
		(not (transportMode Public))
		=>
		 	(assert (transportMode Public))
)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 6. Budget Group Business Rules 2
; If the budget is less than 20 the mode of transport will be public
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defrule R602-LowBudgetFood
		(exists (Budget LowBudget))
		?activity <- (activity (category Culinary)
		(activityId ?activityId) (activityTitle ?activityTitle) (activityMinimumBudget ?activityMinimumBudget)
		;CF value for the activty and the rules applied
		(activityCF ?aCF) (activityRules ?appliedRules))
					; Check if the rule has been applied before
		(test (eq (numberp (str-index R602 ?appliedRules)) FALSE))
		(test (<  ?activityMinimumBudget 10 ))
		=>	;Set the CF of the activity to 0, record that the rule has been applied
		  (assert (activityShortList (activityTitle ?activityTitle) (cf ?*PosCf*)))
			(modify ?activity	(activityRules =(str-cat R602 ?appliedRules)))
)
