<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js">
$(function() {
    $('input[name="group"]').on('click', function() {
        if ($(this).val() == 'solo') {
            $('#lone').show();
            $('#grp').hide();
        }
        else {
        	$('#lone').hide();
            $('#grp').show();
        }
    });
});
</script>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Boredom Curer</title>
<link href="formstyle.css" rel="stylesheet" type="text/css">
</head>


<body background="https://www.amazingviewscabinrentals.com/wp-content/uploads/2015/02/fun-group-vacation-in-Gatlinburg.jpg">
<div class="container">
  <h2> Preferences </h2>
 <form method="post" action="http://localhost:8080/EntertainmentSystem/TravelManager/SpecialDetails">
 	 <div class="row">
      <div class="col-25">
        <label for="group"> Who will accompany you? </label>
      </div>
      <div class="col-75">
      		<input type="radio" name="group" value="family"> Family needs<br>
 			<input type="radio" name="group" value="friends"> Friends <br>
 			<input type="radio" name="group" value="both"> Family and Friends <br>
 			<input type="radio" name="group" value="solo"> Just me <br>
     </div>
    </div>
    <div class="row" id="lone">
      <div class="col-25">
        <label for="socialize">Do you want to socalize?</label>
      </div>
      <div class="col-75">
      	<select id="social" name="social">
          <option value="yes">Yes</option>
          <option value="no">No</option>
        </select>
      </div>
    </div>
   
    <div class="row" id="grp">
      <div class="col-25">
        <label for="special"> Select all options that are applicable. Will you be accompanied by </label>
      </div>
      <div class="col-75">
        <input type="checkbox" name="special" value="needs"> People with special needs<br>
 		<input type="checkbox" name="special" value="kids"> Kids <br>
 		<input type="checkbox" name="special" value="elder"> Senior citizens <br>
      </div>
    </div>
    <div class="row">
      <div class="col-25">
        <label for="pets">Do you like to play with animals</label>
      </div>
      <div class="col-75">
         <input type="radio" name="pets" value="yes"> Yes<br>
         <input type="radio" name="pets" value="no"> No<br>
      </div>
    </div>
    <div class="row">
      <input type="submit" value="Submit">
    </div>
  </form>
</div>
</body>
</html>