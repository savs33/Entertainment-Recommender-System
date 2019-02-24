(defglobal ?*LocalCity* = "Singapore"
?*LowBudget* = 20
?*NegCf* = -0.1
?*SpecialNeeds* = -0.2
?*PosCf* = 0.1
?*NotAvailable* = 0
)

(deftemplate personal-data
	(slot name)
	(slot age (type INTEGER FLOAT)) 				; 1 How old are you
	(slot nationality) 			; 2 Where are you from?
	(slot timeInSingapore)	; 3 How long have you been in Singapore?
	(slot currentLocation)		; 4 Area of Singapore you live in
	(slot interestedRegion)		; Which part of singapore would you like to explore
	(slot budget (type INTEGER FLOAT))						; 5 What is your budget?
	(slot groupProfile )		; 6 Who is in need of entertainment
	(slot interest)		; 7 Place you would like to go
	(slot itineraryLength)	; 8 How long do have?
	(slot specialNeeds)			; 9 Are you a person with special needs?
	(slot sheltered)				; 10 do you prefer indoor or outdoor activities?
	(multislot travelDate)	; 11 Travel Date Time and Day YYYY MM DD HHMM Mon/Tue/Wed/Fri/Sat/Sun
	(slot familyHasYoungKids) (slot familyHasElderly)
	(multislot predictedWeather) (slot predictedTemperature)
	(slot meetNewPeople) ; for solo person
	(slot likeAnimals)
)

;; Stores the categories the person is interested in
(deftemplate interestedCategories	(slot category) (slot cf))
(deftemplate publicHoliday	(slot holiday) (multislot date))

(deftemplate activityShortList
	(slot activityId) (slot activityTitle) (slot cf)
)

(deftemplate activity
	(slot category) (slot activityId)
	(slot activityTitle) (slot activityOverview) (slot activityShortContent)
	(slot activityRegion) (slot activityAddress) (slot activityPostalCode) (slot activityLongitude) (slot activityLatitude)
	(slot activityStartTime) (slot activityEndTime)
	(multislot activityProfile) (slot activityMinimumAgeRange)
	(slot activityLengthOfTime)
	(slot activityMinimumBudget) (slot activityImageUrl)
	(slot activitySuitableForYoungChildren) (slot activitySuitableForElderly)
	(slot activitySpecialNeeds) (slot activitySheltered)
	(slot activityCF (default 0.5))
	(slot activityRules (default " ")) (slot activityClosedDays)
)

(deftemplate recommendedActivity
	(slot category) (slot activityId)
	(slot activityTitle) (slot activityOverview) (slot activityShortContent)
	(slot activityRegion) (slot activityAddress) (slot activityPostalCode) (slot activityLongitude) (slot activityLatitude)
	(slot activityStartTime) (slot activityEndTime)
	(slot activityProfile) (slot activityMinimumAgeRange)
	(slot activityLengthOfTime)
	(slot activityMinimumBudget) (slot activityImageUrl)
	(slot activitySpecialNeeds) (slot activitySheltered)
	(slot activityCF (default 0.5))
	(slot modeOfTransport) (slot activityClosedDays) (slot activityRules (default " "))
)

(deffunction count-facts (?template)
		(bind ?count 0)
		(do-for-all-facts ((?m ?template))
			(and (> ?m:activityCF 0.3)
					(> (str-length ?m:activityRules) 2.0 )
			)
		(bind ?count (+ ?count 1)))
		?count
)

(deffacts holidayList
	( publicHoliday (holiday "New Year's Day") (date 2018 01 01 Mon))
	( publicHoliday (holiday "Chinese New Year Day 1") (date 2018 02 16 Fri))
	( publicHoliday (holiday "Chinese New Year Day 2") (date 2018 02 17 Sat))
	( publicHoliday (holiday "Good Friday") (date 2018 03 30 Fri))
	( publicHoliday (holiday "Labour Day") (date 2018 05 01 Tue))
	( publicHoliday (holiday "Vesak Day") (date 2018 05 29 Tue))
	( publicHoliday (holiday "Hari Raya Puasa") (date 2018 06 15 Fri))
	( publicHoliday (holiday "National Day") (date 2018 08 09 Thu))
	( publicHoliday (holiday "Hari Raya Haji") (date 2018 08 22 Wed))
	( publicHoliday (holiday "Deepavali") (date 2018 11 06 Tue))
	( publicHoliday (holiday "Christmas Day") (date 2018 12 25 Tue))
)
