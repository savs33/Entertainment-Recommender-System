;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;combine POSITIVE (or ZERO) certainty factors for multiple conclusions
;cf(cf1,cf2) = cf1 + cf2 * (1- cf1)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defrule combine-positive-cf
  	(declare (salience -1))
	?f1 <- (activity (activityTitle ?g1)(activityCF ?cf1&:(>= ?cf1 0)))
	?f2 <- (activityShortList (activityTitle ?g2)(cf ?cf2&:(>= ?cf2 0)))
	(test (eq ?g1 ?g2)) ;; compares pointers not value
  =>
 	(retract ?f2)
  	(modify ?f1 (activityCF =(+ ?cf1 (* ?cf2 (- 1 ?cf1)))))
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;combine NEGATIVE certainty factors for multiple conclusions
;cf(cf1,cf2) = cf1 + cf2 * (1+cf1)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defrule combine-negative-cf
 	(declare (salience -1))
	?f1 <- (activity (activityTitle ?g1)(activityCF ?cf1&:(< ?cf1 0)))
  ?f2 <- (activityShortList (activityTitle ?g2) (cf ?cf2&:(< ?cf2 0)))
  (test (eq ?g1 ?g2)) ;; compares pointers not value
  =>
  	(retract ?f2)
  	(modify ?f1 (activityCF =(+ ?cf1 (* ?cf2 (+ 1 ?cf1)))))
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;combine POSITIVE & NEGATIVE certainty factors for multiple conclusions
;cf(cf1,cf2) = (cf1 + cf2)/ 1- MIN(|cf1|, |cf1|)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defrule combine-pos-neg-cf
 	(declare (salience -1))
  	?f1 <- (activity (activityTitle ?g1)(activityCF  ?cf1))
  	?f2 <- (activityShortList (activityTitle ?g2) (cf ?cf2))
   (test (eq ?g1 ?g2)) ;; compares pointers not value
  	(test (< (* ?cf1 ?cf2) 0))
  =>
  	(retract ?f2)
  	(modify ?f1 (activityCF =(/ (+ ?cf1 ?cf2) (- 1 (min (abs ?cf1) (abs ?cf2))))))
)

;; Recommendation summary
(defrule compile_recommendations
	(declare (salience -10))
;  (transportMode ?modeOfTransport)
  (activity (activityCF ?activityCF) (category ?category) (activityId ?activityId)
		(activityTitle ?activityTitle) (activityOverview ?activityOverview) (activityShortContent ?activityShortContent)
		(activityRegion ?activityRegion) (activityAddress ?activityAddress) (activityPostalCode ?activityPostalCode)
		(activityLongitude ?activityLongitude) (activityLatitude ?activityLatitude)
		(activityStartTime ?activityStartTime) (activityEndTime ?activityEndTime)
		(activityMinimumAgeRange ?activityMinimumAgeRange)
		(activityLengthOfTime ?activityLengthOfTime)	(activityMinimumBudget ?activityMinimumBudget)
    (activityImageUrl ?activityImageUrl) (activitySheltered ?activitySheltered)(activityClosedDays ?activityClosedDays)
    (activityRules ?activityRules  )
)
 (test (> ?activityCF 0.51 ))
	=>
	(printout t "Recommended " ?activityTitle crlf)
	(assert
	(recommendedActivity (category ?category) (activityId ?activityId)
		(activityTitle ?activityTitle) (activityOverview ?activityOverview) (activityShortContent ?activityShortContent)
		(activityRegion ?activityRegion) (activityAddress ?activityAddress) (activityPostalCode ?activityPostalCode)
		(activityLongitude ?activityLongitude) (activityLatitude ?activityLatitude)
		(activityStartTime ?activityStartTime) (activityEndTime ?activityEndTime)
		(activityMinimumAgeRange ?activityMinimumAgeRange)
		(activityLengthOfTime ?activityLengthOfTime)	(activityMinimumBudget ?activityMinimumBudget)
		(activitySheltered ?activitySheltered)
		(activityCF ?activityCF)	(modeOfTransport nil) (activityRules ?activityRules  )
	))
)
