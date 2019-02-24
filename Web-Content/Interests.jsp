<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<style>

.cir {
    background: skin-tone.jpg;
    background-size: cover;
    border-radius:50% 50% 50% 50%;
    width:150px;
    height:150px;
}

h1 {
  color:white;
  font-size:300%;
  text-align: justify;
   text-align-last: center;
}

label {
font-size: 150%;
color : white;
}

input[type=submit] {
    background-color: green;
    color: white;
    padding: 10px 20px;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    float: right;
}

</style>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Boredom Curer</title>
</head>
<body background="http://globalmedicalco.com/photos/globalmedicalco/3/10320.jpg">
<h1> What Interests you?</h1>
<form method="post" action="http://localhost:8080/EntertainmentSystem/TravelManager/InterestDetails">
	<table style="width:100%">
	<!--  <div class="dir1">-->
	<tr>
	<td>
	<input  type="checkbox" name="interest" value="architecture"><img class="cir" src="https://c1.staticflickr.com/9/8419/8706370006_500b3cd472_b.jpg"><br> <label for="arch" >       Architecture </label>
	</td> <td><input  type="checkbox" name="interest" value="nature"><img class="cir" src="https://media-cdn.tripadvisor.com/media/photo-s/09/76/7b/2b/singapore-botanic-gardens.jpg"><br> <label > Nature and wildlife </label> <br>
	</td> <td> <input  type="checkbox" name="interest" value="recreation"><img class="cir" src="https://www.lokopoko.travel/wp-content/uploads/2015/09/USS-Banner.jpg"> <br>  <label>  Recreation and Leisure </label><br>
	</td></tr> <!-- </div><br> -->
	<!--  <div class="dir1">-->
	<tr>
	<td>
	<input type="checkbox" name="interest" value="arts"><img class="cir" src="http://eastspringsec.moe.edu.sg/qql/slot/u559/CCA/Performing%20Arts/Malay%20Dance/MD%202018_1.png"> <br>  <label for="arch" left=30px>       Arts </label><br>
	</td><td><input type="checkbox" name="interest" value="history"><img class="cir" src="https://ssl.c.photoshelter.com/img-get2/I00005.LqW4sMoXY/fit=1000x750/singapore-2011-11-13-0115.jpg"> <br>  <label for="arch" left=30px>  History </label><br>
	</td><td><input type="checkbox" name="interest" value="heritage"><img class="cir" src="http://www.buschartersingapore.com/wp-content/uploads/2016/10/Haw-Par-Villa-2-1024x675.jpg"> <br>  <label for="arch" left=30px>  Heritage </label><br>
	</td></tr> <!-- </div> <br> -->
	<!--  <div class="dir1">-->
	<tr>
	<td>
	<input type="checkbox" name="interest" value="religion"><img class="cir" src="http://www.worldreligionnews.com/wp-content/uploads/2014/11/Buddha-Temple.jpg"> <br>  <label for="arch" left=30px>  Religion </label><br>
	</td><td><input type="checkbox" name="interest" value="museum"><img class="cir" src="http://singaporewest.sg/wp-content/uploads/2015/06/nus-cover-pic.jpg"> <br>  <label for="museum" left=30px>  Museum </label><br>
	</td><td><input type="checkbox" name="interest" value="surprise"><img class="cir" src="http://www.worldreligionnews.com/wp-content/uploads/2014/11/Buddha-Temple.jpg"> <br>  <label for="arch" left=30px>  Surprise Me </label><br>
    </td></tr> <!-- </div> <br> -->
    </table>
    <input type="submit" value="Submit">
    
</form>
</body>
</html>