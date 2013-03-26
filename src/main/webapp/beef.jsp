<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Beef Timer</title>
		
		<script type="text/javascript" src="http://code.jquery.com/jquery-latest.min.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/date.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/moment.min.js"></script>
		<!--[if IE]><script src="${pageContext.request.contextPath}/js/excanvas.compiled.js"></script><![endif]-->
		
		<style>
			
			#content {
				margin-top:100px;
			}
			
			body {
				background: url("${pageContext.request.contextPath}/resources/beef-sammich-edited.JPG")  center top fixed;
				background-size: 100% auto;
			}
			
			.time-table td {
				text-align:center;
			}
			
			.time-table .label {
				font-size: 25px;
			}
		</style>
		
		<script type="text/javascript">
			
			var dateParse = 'next friday';
			
			$(document).ready(function(){
				countdown();
				setInterval(countdown, 1000);
				function countdown () {
					//Get next friday with date.js
					//http://code.google.com/p/datejs/wiki/FormatSpecifiers
					var nextDate = Date.parse(dateParse).addHours(12);
					
					$('#nextDate').html(nextDate);
					
					var nextDateYear = nextDate.toString('yyyy'); //4 digit year
					var nextDateMonth = nextDate.toString('M'); //1 to 12
					var nextDateDay = nextDate.toString('d');
					var nextDateHour = parseInt(nextDate.toString('H'));
					var nextDateMinute = nextDate.toString('m');
					var nextDateSecond = nextDate.toString('s');
					
					//console.log('year: ' + nextDateYear);
					//console.log('month: ' + nextDateMonth);
					//console.log('day: ' + nextDateDay);
					//console.log('hour: ' + nextDateHour);
					
					//var monthSpan = 12
					//var daySpan = Date.getDaysInMonth(nextDateYear, nextDateMonth - 1); //Span for Days in Month
					var daySpan = 7; //Span for 1 week, 7 days total
					var hourSpan = 24;
					var minuteSpan = 60;
					var secondSpan = 60;
					var millisecondSpan = 1000;
					
					//The momemnt we are in now
					var now = moment();
					
					//The moment we are comparing against
					var then = moment([nextDateYear, (nextDateMonth - 1), nextDateDay, nextDateHour, nextDateMinute, nextDateSecond, 0]);
					
					// get the difference from now to then in ms
					var ms = then.diff(now, 'milliseconds', true);
					years = Math.floor(moment.duration(ms).asYears());

					then = then.subtract('years', years);
					ms = then.diff(now, 'milliseconds', true);
					months = Math.floor(moment.duration(ms).asMonths());
					 
					then = then.subtract('months', months);
					ms = then.diff(now, 'milliseconds', true);
					days = Math.floor(moment.duration(ms).asDays());
					 
					then = then.subtract('days', days);
					ms = then.diff(now, 'milliseconds', true);
					hours = Math.floor(moment.duration(ms).asHours());
					 
					then = then.subtract('hours', hours);
					ms = then.diff(now, 'milliseconds', true);
					minutes = Math.floor(moment.duration(ms).asMinutes());
					 
					then = then.subtract('minutes', minutes);
					ms = then.diff(now, 'milliseconds', true);
					seconds = Math.floor(moment.duration(ms).asSeconds());
					
					then = then.subtract('seconds', seconds);
					ms = then.diff(now, 'milliseconds', true);
					milliseconds = Math.floor(moment.duration(ms).asMilliseconds());
					
					
					
					// concatonate the variables
					diff = 	'<span class="num">' + months + '</span> months<br/>' + 
							'<span class="num">' + days + '</span> days<br/>' +
							'<span class="num">' + hours + '</span> hours<br/>' +
							'<span class="num">' + minutes + '</span> minutes<br/>' +
							'<span class="num">' + seconds + '</span> seconds<br/>' +
							'<!--<span class="num">' + milliseconds + '</span> milliseconds&#133;-->';
					//$('#relative').html(diff);
					
					
					//Need to move the clock!
					incrementTime(days, daySpan, "dayCanvas");
					incrementTime(hours, hourSpan, "hourCanvas");
					incrementTime(minutes, minuteSpan, "minuteCanvas");
					incrementTime(seconds, secondSpan, "secondCanvas");
					//incrementTime(milliseconds, millisecondSpan, "millisecondCanvas");
					
				}
			});
				
			
			
		</script>
		
		<script type="text/javascript">
			
			function incrementTime(time, span, canvas) {
				//The Time Increment by the Span need to move by
				var timeIncrement = (2 * Math.PI) / span;
				
				//Setup the Canvas
				var canvas = document.getElementById(canvas);
				var context = canvas.getContext('2d');
				context.clearRect(0,0,250,250); //Clear the Rectangle
				var x = canvas.width / 2; //Set the x center location of the canvas
				var y = canvas.height / 2; //set the y center location of the canvas
				var radius = 100; //Radius of the clock
				var startAngle = Math.PI * 1.5; //Where the angle will start
				var endAngle = timeIncrement * time - (0.5 * Math.PI);
				var counterClockwise = false; //False to CounterClockwise
				
				
				//Draw our arc for the timer!
				context.beginPath(); //Start drawing
				context.arc(x, y, radius, startAngle, endAngle, counterClockwise); //Draw the arc
				var arcWidth = 15;
				context.lineWidth = arcWidth; //Width of the arc line
				context.strokeStyle = '#6A5F6F'; //Color of the line
				context.stroke(); //STROKE!!! write it to the canvas
				
				
				//create the container for the clock
				context.beginPath();
				context.arc(x, y, radius + (arcWidth/2), 0, 2 * Math.PI, counterClockwise); //Draw the arc
				context.lineWidth = 4; //Width of the arc line
				context.strokeStyle = 'black'; //Color of the line
				context.stroke(); //STROKE!!! write it to the canvas
				context.beginPath();
				context.arc(x, y, radius - (arcWidth/2), 0, 2 * Math.PI, counterClockwise); //Draw the arc
				context.lineWidth = 4; //Width of the arc line
				context.strokeStyle = 'black'; //Color of the line
				context.stroke(); //STROKE!!! write it to the canvas
				
				
				
				
				//Add Text in the center of the circle
				context.font="50.4px Arial";
				context.textAlign="center";
				context.textBaseline = 'middle';
				
				context.fillText(time,x,y);
			}
		</script>
		
	</head>
	<body>
		<div id="content">
			<div  style="margin: 0px auto;text-align:center;">
				<!--<h1>Time Until Next Beef!</h1>-->
				<!--<div id="relative"></div>-->
				<div>
					<div style="margin: 0px auto; display: inline-block">
						<table class="time-table">
							<tr>
								<td><canvas id="dayCanvas" width="250" height="250"></canvas>
									<br/><span class="label">Days</span></td>
								<td><canvas id="hourCanvas" width="250" height="250"></canvas>
									<br/><span class="label">Hours</span></td>
								<td><canvas id="minuteCanvas" width="250" height="250"></canvas>
									<br/><span class="label">Minutes</span></td>
								<td><canvas id="secondCanvas" width="250" height="250"></canvas>
									<br/><span class="label">Seconds</span></td>
								<!--<td><canvas id="millisecondCanvas" width="250" height="250"></canvas>
									<br/><span class="label">Milliseconds</span></td>-->
							</tr>
						</table>
					</div>
				</div>
				
			</div>
		</div>

		<!--
		<br/>
		<div>
		Next Friday's Date: <span id="nextDate"></span>
		</div>
		-->
		
		
	</body>
</html>