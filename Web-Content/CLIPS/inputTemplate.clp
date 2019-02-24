(deffacts itineraryRequest
  (personal-data
  	(name Nivedita)
  	(age 23) 				; 1 How old are you
  	(nationality Indian) 			; 2 Where are you from?
  	(timeInSingapore "Less than 1 year")	     ; Less than 1 year; 1-3 years; More than 3 years
  	(interestedRegion Central)		;(West/East/Central/North/No Preference) Which part of singapore would you like to explore
  	(budget 50)						; 5 What is your budget?
  	(groupProfile kids)		; 6 Who is in need of entertainment
  	(interest "Arts History")		; 7 Place you would like to go
  	(specialNeeds Y)			; 9 Are you a person with special needs?
  	(sheltered Indoor)				; Indoor/Outdoor/Both
  	(travelDate 2018 02 26 1600 Mon)	; 11 Travel Date and Time YYYY-MM-DD HHMM
  	(familyHasYoungKids N) (familyHasElderly N)
  	(predictedWeather Sunny) ;
    (predictedTemperature 35)
  	(meetNewPeople Y) ; for solo person
  	(likeAnimals Y)
  )
)

(deffacts itineraryCategories  (interestedCategories (category Nature) (cf 0.6))
 (interestedCategories (category Arts) (cf 0.8))  )
