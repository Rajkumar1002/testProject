<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<script type="text/javascript" 
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script src="https://code.jquery.com/jquery-1.11.1.min.js"></script>
<script src="https://code.jquery.com/ui/1.11.1/jquery-ui.min.js"></script>
<style>
table, th, td {
  border: 1px solid black;
}
</style>
<script>
 function showHide() {
	var displayUnit;
	var city = document.getElementById("cityName").value;
	var unitChecked = document.querySelector("input[name='unit']:checked");
	var showUnit;
	
	if(city == null || city == undefined)
		city = "chennai";
		
	if(unitChecked == null){
		showUnit = "metric";
	}else{
		showUnit = unitChecked.value;
	
	}	
	if(showUnit == "metric"){
		displayUnit = "Celsius";
	}else{
		displayUnit = "Fahrenheit";
	}
	
	$("#contentTable").remove();
	
	$.ajax(
	{
	type : "POST",
	url : "weather",
	data : {
	"city" : city,
	"showUnit" : showUnit
	},
	success : function(result) {
			let table = document.createElement('table');
			let thead = document.createElement('thead');
			let tbody = document.createElement('tbody');
			
			table.setAttribute("id", "contentTable");
			table.style.backgroundColor= "aliceblue";
			table.style.fontSize= "xx-large";
			table.style.margin= "auto";
			table.style.textAlign= "center";
			
			thead.style.backgroundColor= "aquamarine";
			thead.style.fontWeight= "bold";
			
			let row_1 = document.createElement('tr');
			let heading_1 = document.createElement('th');
			heading_1.innerHTML = "CITY";
			let heading_2 = document.createElement('th');
			heading_2.innerHTML = "MAX TEMP";
			let heading_3 = document.createElement('th');
			heading_3.innerHTML = "MIN TEMP";
			let heading_4 = document.createElement('th');
			heading_4.innerHTML = "UNIT";

			row_1.appendChild(heading_1);
			row_1.appendChild(heading_2);
			row_1.appendChild(heading_3);
			row_1.appendChild(heading_4);
			thead.appendChild(row_1);
			
			let row_2 = document.createElement('tr');
			let row_2_data_1 = document.createElement('td');
			row_2_data_1.innerHTML = result.name;
			let row_2_data_2 = document.createElement('td');
			row_2_data_2.innerHTML = result.main.temp_max;
			let row_2_data_3 = document.createElement('td');
			row_2_data_3.innerHTML = result.main.temp_min;
			let row_2_data_4 = document.createElement('td');
			row_2_data_4.innerHTML = displayUnit;

			row_2.appendChild(row_2_data_1);
			row_2.appendChild(row_2_data_2);
			row_2.appendChild(row_2_data_3);
			row_2.appendChild(row_2_data_4);
			tbody.appendChild(row_2);
			
			table.appendChild(thead);
			table.appendChild(tbody);
			// Adding the entire table to the body tag
			document.getElementById('body').appendChild(table);
	
	},
	});
	
   
 }
 
 </script>

<html>
<head>
<meta charset="utf-8">
<title>Insert title here</title>
</head>
<body id="body" style="font-size: x-large;background-color: cadetblue;">

</div>

     <h2 align="center"> Hello!</h2>
     
     <p>Enter Area Name : <input type="text" id="cityName" name="cityName" style="height: 30;font-size: large;border-radius: 8px;text-align: center;"></p><br>     
     <p>Please select Unit:</p>
  <input type="radio" id="Fahrenheit" name="unit" value="imperial">Fahrenheit (<sup>o</sup>F)<br>
  <input type="radio" id="Celsius" name="unit" value="metric">Celsius (<sup>o</sup>C)<br><br>
  <input type="button" value="Submit" onclick="showHide()" style="height: 50;width: 100;border-radius: 8px;font-size: large;">
  
  
 
</body>
</html>