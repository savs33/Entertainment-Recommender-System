<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Boredom Curer</title>
<link href="formstyle.css" rel="stylesheet" type="text/css">  
</head>

<body background="http://static.asiawebdirect.com/m/phuket/portals/www-singapore-com/homepage/pagePropertiesImage/singapore.jpg.jpg">
<div class="container">
  <h2> Preferences </h2>
 <form method="post" action="http://localhost:8080/EntertainmentSystem/TravelManager/BudgetDetails">
 	<div class="row">
      <div class="col-25">
        <label for="date">Date and Time in YYYY MM DD HHMM followed by the first 3 letters of the day(e.g. Mon) </label>
      </div>
      <div class="col-75">
        <input type="text" id="date" name="date" placeholder="Date for activity planning">
      </div>
    </div>
    <div class="row">
      <div class="col-25">
        <label for="duration">Preferred Duration</label>
      </div>
      <div class="col-75">
        <select id="duration" name="duration">
          <option value="4">Less than 4 hours</option>
          <option value="8">Between 4 to 8 hours </option>
          <option value="12">Greater than 8 hours </option>
        </select>
      </div>
    </div>
    <div class="row">
      <div class="col-25">
        <label for="budget">Budget per person</label>
      </div>
      <div class="col-75">
        <select id="budget" name="budget">
          <option value="lt20">Less than 20 SGD</option>
          <option value="lt50">Between 20 - 50 SGD </option>
          <option value="lt100">Between 50 - 100 SGD </option>
          <option value="gt100">Greater than 100 SGD </option>
        </select>
      </div>
    </div>
    <div class="row">
      <div class="col-25">
        <label for="pref_area">Do you want to explore any particular area of Singapore</label>
      </div>
      <div class="col-75">
         <select id="area_pref" name="area_pref">
          <option value="Central">Central Singapore</option>
          <option value="West">West Singapore </option>
          <option value="East">East Singapore</option>
          <option value="North">North Singapore </option>
          <option value="South">South Singapore </option>
          <option value="All">No such preference</option>
        </select>
      </div>
    </div>
    <div class="row">
      <div class="col-25">
        <label for="indoor"> Select your preference of type of activities: </label>
      </div>
      <div class="col-75">
       <select id="indoor" name="indoor">
          <option value="Indoor">Indoor</option>
          <option value="Outdoor">Outdoor</option>
          <option value="Both">No such preference</option>
        </select>
     </div>
    </div>
    <div class="row">
      <div class="col-25">
        <label for="group"> Who will accompany you? </label>
      </div>
      <div class="col-75">
      		<input type="radio" name="group" value="family"> Family <br>
 			<input type="radio" name="group" value="friends"> Friends <br>
 			<input type="radio" name="group" value="both"> Family and Friends <br>
 			<input type="radio" name="group" value="solo"> Just me <br>
     </div>
    </div>
    <div class="row">
      <input type="submit" value="Submit">
    </div>
  </form>
</div>
</body>
</html>