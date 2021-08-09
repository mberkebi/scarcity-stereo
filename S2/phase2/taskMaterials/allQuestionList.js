var allQuestionList =  {
		"MTurkID":{
			"name":"MTurkID",
			"include":true,
			"type":"text",
			"warning":"REQMTurkID",
			"HTML":'<label>Please enter your Mechanical Turk ID accurately.<p style="display:none" class="required" id = "REQMTurkID">This is a required field.</p></label><input type="text" name="MTurkID" class="form-control">',
			"value":""
		},
		"age":{
			"name":"age",
			"include":true,
			"type":"text",
			"warning":"REQage",
			"HTML":'<label>What is your age?<p style="display:none" class="required" id = "REQage">This is a required field.</p></label><input type="text" name="age" class="form-control">',
			"value":""
		},
		"mouse":{
			"name":"mouse",
			"include":true,
			"type":"select",
			"warning":"REQmouse",
			"HTML":'<label>Are you using an external mouse or a trackpad?<p style="display:none" class="required" id="REQmouse">This is a required field.</p></label><select name="mouse" class="form-control"><option value=""></option><option value="Mouse">Mouse</option><option value="Trackpad">Trackpad</option><option value="Other">Other (such as trackball mouse)</option></select>',
			"value":""
		},
		"gender":{
			"name":"gender",
			"include":true,
			"type":"radio",
			"warning":"REQgender",
			"HTML":'<label>With which gender do you most identify?<p style="display:none" class="required" id="REQgender">This is a required field.</p></label><div class="radio"><label><input type="radio" name="gender" value="male">Male</label></div><div class="radio"><label><input type="radio" name="gender" value="female">Female</label></div><div class="radio"><label><input type="radio" name="gender" value="other">Not otherwise specified</label></div><div class="radio"><label><input type="radio" name="gender" value="decline">I do not wish to provide this information</label></div>',
			"value":""
		},
		"english":{
			"name":"english",
			"include":true,
			"type":"radio",
			"warning":"REQenglish",
			"HTML":'<label>Are you fluent in English?<p style="display:none" class="required" id="REQenglish">This is a required field.</p></label><div class="radio"><label><input type="radio" name="english" value="yes">Yes</label></div><div class="radio"><label><input type="radio" name="english" value="no">No</label></div>',
			"value":""
		},
		"hispanic":{
			"name":"hispanic",
			"include":true,
			"type":"radio",
			"warning":"REQhispanic",
			"HTML":'<label>Do you consider yourself to be Hispanic or Latino?<p style="display:none" class="required" id="REQhispanic">This is a required field.</p></label><div class="radio"><label><input type="radio" name="hispanic" value="hispanic">Hispanic or Latino</label></div><div class="radio"><label><input type="radio" name="hispanic" value="not">Not Hispanic or Latino</label></div><div class="radio"><label><input type="radio" name="hispanic" value="decline">I do not wish to provide this information</label></div>',
			"value":""
		},
		"race":{
			"name":"race",
			"include":true,
			"type":"checkbox",
			"warning":"REQrace",
			"HTML":'<label>With which race/ethnicity do you most identify?<p style="display:none" class="required" id = "REQrace">This is a required field.</p></label><div class="checkbox"><label><input class="race" type="checkbox" name="AmericanIndian">American Indian or Alaska Native</label></div><div class="checkbox"><label><input class="race" type="checkbox" name="Asian">Asian</label></div><div class="checkbox"><label><input class="race" type="checkbox" name="Black">Black or African-American</label></div><div class="checkbox"><label><input class="race" type="checkbox" name="PacificIslander">Native Hawaiian or Other Pacific Islander</label></div><div class="checkbox"><label><input class="race" type="checkbox" name="White">White</label></div><div class="checkbox"><label><input class="race" type="checkbox" name="Other">Other</label></div>',
			"value":""
		},
		"attention":{
			"name":"attention",
			"include":true,
			"type":"radio",
			"warning":"REQattention",
			"HTML":'<label><b>Please read the following instructions:</b> Recent research on decision making has shown that choices are affected by political party affiliation. To help us understand how people make decisions from different backgrounds, we are interested in information about you. Specifically we want to know if you actually read any of the instructions we give at the beginning of our survey; if not, some results may not tell us very much about decision making and perception in the real world. To show that you have read the instructions, please ignore the questions about political party affiliation below and simply select "Other" at the bottom. For which political party do you typically vote? <br> <p style="display:none" class="required" id="REQattention">This is a required field.</p></label><div class="radio"><label><input type="radio" name="attention" value="Democrat">Democratic</label></div><div class="radio"><label><input type="radio" name="attention" value="Republican">Republican</label></div><div class="radio"><label><input type="radio" name="attention" value="Independent">Independent</label></div><div class="radio"><label><input type="radio" name="attention" value="Libertarian">Libertarian</label></div><div class="radio"><label><input type="radio" name="attention" value="Green">Green Party</label></div><div class="radio"><label><input type="radio" name="attention" value="Other">Other</label></div>',
			"value":""
		},
		"poli":{
			"name":"poli",
			"include":true,
			"type":"radio",
			"warning":"REQpoli",
			"HTML":'<label>Where on the following scale of political orientation would you place yourself (overall, in general)?<p style="display:none" class="required" id="REQpoli">This is a required field.</p></label><div class="radio"><label><input type="radio" name="poli" value="extremely_liberal">Extremely Liberal</label></div><div class="radio"><label><input type="radio" name="poli" value="moderately_liberal">Moderately Liberal</label></div><div class="radio"><label><input type="radio" name="poli" value="slightly_liberal">Slightly Liberal</label></div><div class="radio"><label><input type="radio" name="poli" value="neither">Neither</label></div><div class="radio"><label><input type="radio" name="poli" value="slightly_conservative">Slightly Conservative</label></div><div class="radio"><label><input type="radio" name="poli" value="moderately_conservative">Moderately Conservative</label></div><div class="radio"><label><input type="radio" name="poli" value="extremely_conservative">Extremely Conservative</label></div>',
			"value":""
		},
		"color_poli":{
			"name":"color_poli",
			"include":true,
			"type":"radio",
			"warning":"REQcolor_poli",
			"HTML":'<label>Throughout today\'s study, you evaluated a series of faces that were surrounded by different colored borders. What did the border colors indicate?<p style="display:none" class="required" id="REQcolor_poli">This is a required field.</p></label><div class="radio"><label><input type="radio" name="color_poli" value="A">Blue = House of Representatives, Red = Senate</label></div><div class="radio"><label><input type="radio" name="color_poli" value="B">Blue = Senate, Red = House of Representatives</label></div><div class="radio"><label><input type="radio" name="color_poli" value="C">Blue = Democrat, Red = Republican</label></div><div class="radio"><label><input type="radio" name="color_poli" value="D">Blue = Republican, Red = Democrat</label></div><div class="radio"><label><input type="radio" name="color_poli" value="E">This information was not provided.</label></div>',
			"value":""
		},
		"sexOrientation":{
			"name":"sexOrientation",
			"include":true,
			"type":"radio",
			"warning":"REQsexOrientation",
			"HTML":'<label>What sexual orientation do you most identify with?<p style="display:none" class="required" id="REQsexOrientation">This is a required field.</p></label><div class="radio"><label><input type="radio" name="sexOrientation" value="Heterosexual">Heterosexual</label></div><div class="radio"><label><input type="radio" name="sexOrientation" value="Gay">Gay</label></div><div class="radio"><label><input type="radio" name="sexOrientation" value="Lesbian">Lesbian</label></div><div class="radio"><label><input type="radio" name="sexOrientation" value="Bisexual">Bisexual</label></div><div class="radio"><label><input type="radio" name="sexOrientation" value="Transgender">Transgender</label></div><div class="radio"><label><input type="radio" name="sexOrientation" value="Asexual">Asexual</label></div><div class="radio"><label><input type="radio" name="sexOrientation" value="Queer">Queer</label></div><div class="radio"><label><input type="radio" name="sexOrientation" value="Questioning">Questioning</label></div><div class="radio"><label><input type="radio" name="sexOrientation" value="Other">Not Otherwise Specified</label></div><div class="radio"><label><input type="radio" name="sexOrientation" value="Decline">I do not wish to provide this information</label></div>',
			"value":""
		},
		"education":{
			"name":"education",
			"include":true,
			"type":"radio",
			"warning":"REQeducation",
			"HTML":'<label>What is the highest level of education you have received?<p style="display:none" class="required" id = "REQeducation">This is a required field.</p></label><div class="radio"><label><input type="radio" name="education" value="LessThanHighSchool">Less than high School</label></div><div class="radio"><label><input type="radio" name="education" value="HighSchool">High School Diploma</label></div><div class="radio"><label><input type="radio" name="education" value="SomeCollege">Some College</label></div><div class="radio"><label><input type="radio" name="education" value="Associate">Associate\'s Degree</label></div><div class="radio"><label><input type="radio" name="education" value="Bachelor">Bachelor\'s Degree</label></div><div class="radio"><label><input type="radio" name="education" value="SomeGraduate">Some Graduate School</label></div><div class="radio"><label><input type="radio" name="education" value="master">Master\'s Degree</label></div><div class="radio"><label><input type="radio" name="education" value="doctoral">Doctoral Degree</label></div>',
			"value":""
		},
		"religion":{
			"name":"religion",
			"include":true,
			"type":"radio",
			"warning":"REQreligion",
			"HTML":'<label>What is your religion?<p style="display:none" class="required" id = "REQreligion">This is a required field.</p></label><div class="radio"><label><input type="radio" name="religion" value="noReligion">No Religion</label></div><div class="radio"><label><input type="radio" name="religion" value="Christian">Christian</label></div><div class="radio"><label><input type="radio" name="religion" value="Buddhist">Buddhist</label></div><div class="radio"><label><input type="radio" name="religion" value="Hindu">Hindu</label></div><div class="radio"><label><input type="radio" name="religion" value="Muslim">Muslim</label></div><div class="radio"><label><input type="radio" name="religion" value="Jewish">Jewish</label></div><div class="radio"><label><input type="radio" name="religion" value="other">Other Religion</label></div>',
			"value":""
		},
		"income":{
			"name":"income",
			"include":true,
			"type":"text",
			"warning":"REQincome",
			"HTML":'<label>How much money do you make per year?<p style="display:none" class="required" id = "REQincome">This is a required field.</p></label><input type="text" name="income" class="form-control">',
			"value":""
		},
		"CRT1":{
			"name":"CRT1",
			"include":true,
			"type":"text",
			"warning":"REQCRT1",
			"HTML":'<label>A bat and a ball cost $1.10 in total. The bat costs $1.00 more than the ball. How much does the ball cost (in cents)?<p style="display:none" class="required" id="REQCRT1">This is a required field.</p></label><input type="text" name="CRT1" class="form-control">',
			"value":""
		},
		"CRT2":{
			"name":"CRT2",
			"include":true,
			"type":"text",
			"warning":"REQCRT2",
			"HTML":'<label>If it takes 5 machines 5 minutes to make 5 widgets, how long would it take 100 machines to make 100 widgets (in minutes)?<p style="display:none" class="required" id="REQCRT1">This is a required field.</p></label><input type="text" name="CRT1" class="form-control">',
			"value":""
		},
		"CRT3":{
			"name":"CRT3",
			"include":true,
			"type":"text",
			"warning":"REQCRT3",
			"HTML":'<label>In a lake, there is a patch of lily pads. Every day, the patch doubles in size. If it takes 48 days for the patch to cover the entire lake, how long would it take for the patch to cover half of the lake (in days)?<p style="display:none" class="required" id="REQCRT1">This is a required field.</p></label><input type="text" name="CRT1" class="form-control">',
			"value":""
		},	
		"zip_current":{
			"name":"zip_current",
			"include":true,
			"type":"text",
			"warning":"REQzip_current",
			"HTML":'<label>What is your current zip code?<p style="display:none" class="required" id="REQzip_current">This is a required field.</p></label><input type="text" name="zip_current" class="form-control">',
			"value":""
		},
		"city_current":{
			"name":"city_current",
			"include":true,
			"type":"text",
			"warning":"REQcity_current",
			"HTML":'<label>What is your current city?<p style="display:none" class="required" id="REQcity_current">This is a required field.</p></label><input type="text" name="city_current" class="form-control">',			
			"value":""
		},
		"state_current":{
			"name":"state_current",
			"include":true,
			"type":"text",
			"warning":"REQstate_current",
			"HTML":'<label>What is your current state?<p style="display:none" class="required" id="REQstate_current">This is a required field.</p></label><input type="text" name="state_current" class="form-control">',			
			"value":""
		},
		"time_current":{
			"name":"time_current",
			"include":true,
			"type":"text",
			"warning":"REQtime_current",
			"HTML":'<label>How long have you been living in your current address (in years)?<p style="display:none" class="required" id="REQtime_current">This is a required field.</p></label><input type="text" name="time_current" class="form-control">',
			"value":""
		},		
		"zip_grewup":{
			"name":"zip_grewup",
			"include":true,
			"type":"text",
			"warning":"REQzip_grewup",
			"HTML":'<label>What zip code did you grow up in?<p style="display:none" class="required" id="REQzip_grewup">This is a required field.</p></label><input type="text" name="zip_grewup" class="form-control">',			
			"value":""
		},
		"city_grewup":{
			"name":"city_grewup",
			"include":true,
			"type":"text",
			"warning":"REQcity_grewup",
			"HTML":'<label>What city did you grow up in?<p style="display:none" class="required" id="REQcity_grewup">This is a required field.</p></label><input type="text" name="city_grewup" class="form-control">',			
			"value":""
		},
		"state_grewup":{
			"name":"state_grewup",
			"include":true,
			"type":"text",
			"warning":"REQstate_grewup",
			"HTML":'<label>What state did you grow up in?<p style="display:none" class="required" id="REQstate_grewup">This is a required field.</p></label><input type="text" name="state_grewup" class="form-control">',			
			"value":""
		},		
		"zip_work":{
			"name":"zip_work",
			"include":true,
			"type":"text",
			"warning":"REQzip_work",
			"HTML":'<label>What zip code do you work in?<p style="display:none" class="required" id="REQzip_work">This is a required field.</p></label><input type="text" name="zip_work" class="form-control">',			
			"value":""
		},
		"city_work":{
			"name":"city_work",
			"include":true,
			"type":"text",
			"warning":"REQcity_work",
			"HTML":'<label>What city do you work in?<p style="display:none" class="required" id="REQcity_work">This is a required field.</p></label><input type="text" name="city_work" class="form-control">',			
			"value":""
		},
		"state_work":{
			"name":"state_work",
			"include":true,
			"type":"text",
			"warning":"REQstate_work",
			"HTML":'<label>What state do you work in?<p style="display:none" class="required" id="REQstate_work">This is a required field.</p></label><input type="text" name="state_work" class="form-control">',			
			"value":""
		},		
		"zip_longest":{
			"name":"zip_longest",
			"include":true,
			"type":"text",
			"warning":"REQzip_longest",
			"HTML":'<label>What zip code did you spend the most time in your life?<p style="display:none" class="required" id="REQzip_longest">This is a required field.</p></label><input type="text" name="zip_longest" class="form-control">',			
			"value":""
		},
		"city_longest":{
			"name":"city_longest",
			"include":true,
			"type":"text",
			"warning":"REQcity_longest",
			"HTML":'<label>What city did you spend the most time in your life?<p style="display:none" class="required" id="REQcity_longest">This is a required field.</p></label><input type="text" name="city_longest" class="form-control">',			
			"value":""
		},
		"state_longest":{
			"name":"state_longest",
			"include":true,
			"type":"text",
			"warning":"REQstate_longest",
			"HTML":'<label>What state did you spend the most time in your life?<p style="display:none" class="required" id="REQstate_longest">This is a required field.</p></label><input type="text" name="state_longest" class="form-control">',			
			"value":""
		},
		"SATScore":{
			"name":"SATScore",
			"include":true,
			"type":"text",
			"warning":"REQSATScore",
			"HTML":'<label>What was your combined SAT Score (Verbal section + Math section)? If you did not take the SAT or do not remember your score, please enter N/A.<p style="display:none" class="required" id = "REQSATScore">This is a required field.</p></label><input type="text" name="SATScore" class="form-control">',
			"value":""
		},
		'bornUS':{
		"name":"bornUS",
		"include":true,
		"type":"radio",
		"warning":"REQbornUS",
		"HTML":'<label>Were you born and raised in the USA?<p style="display:none" class="required" id="REQbornUS">This is a required field.</p></label><div class="radio"><label><input type="radio" name="bornUS" value="yes">Yes</label></div><div class="radio"><label><input type="radio" name="bornUS" value="no">No</label></div>',
		"value":""
		},
		'color_blind': {
		"name":"color_blind",
		"include":true,
		"type":"text",
		"warning":"REQcolor_blind",
		"HTML":'<label>What 2-digit number do you see in the picture below?<p style="display:none" class="required" id = "REQcolor_blind">This is a required field.</p></label><input type="text" name="color_blind" class="form-control"><br><img src="pictures/reg_green_color.jpg" style="height:300px;"/>',
		"value":""
		}
}