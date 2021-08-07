"use strict";
var subjID, IP, trait;
var study = "ratings/traceTrust"; 		//CHANGEME
subjID = getSubjID(7); 							// # is the length of subjID
preventTouch(); 

trait = 'trustworthy';

///////////////////////////
// SET UP SCREENING FORM //
///////////////////////////
var screenerTask = new Screener();
screenerTask.questions = [['MTurkID', 'age', 'english', 'attention']]; 
screenerTask.checkCustomEligibilities = function () {
	var age = $('input:text[name=age]').val();
   if ($('input:radio[name=attention]:checked').val()=='Other' && $('input:radio[name=english]:checked').val()=='yes' && (''+parseInt(age))==age && parseInt(age)>=18 && parseInt(age)<=50) {
       return true;
   }
    return false;
}

/////////////////////////
// SET UP CONSENT PAGE //
/////////////////////////
var consentPage = new Consent();
consentPage.imagesToLoad = ['h01.bmp','h02.bmp','h03.bmp','h04.bmp','h05.bmp','h06.bmp','h07.bmp','h08.bmp','h09.bmp','h10.bmp','h11.bmp','h12.bmp','h13.bmp','h14.bmp','h15.bmp','h16.bmp','h17.bmp','h18.bmp','h19.bmp','h20.bmp','h21.bmp','h22.bmp','h23.bmp','h24.bmp','h25.bmp','h26.bmp','h27.bmp','h28.bmp','h29.bmp','h30.bmp','h31.bmp','h32.bmp','h33.bmp','h34.bmp','h35.bmp','h36.bmp','h37.bmp','h38.bmp','h39.bmp','h40.bmp','h41.bmp','h42.bmp','h43.bmp','h44.bmp','h45.bmp','h46.bmp','h47.bmp','h48.bmp','h49.bmp','h50.bmp','h51.bmp','h52.bmp','h53.bmp','h54.bmp'];
consentPage.consentTitle = ['Study on Perceiving People'];
consentPage.consentText = [
	'Welcome! Thank you for your participation.',
    'You will be presented photos of faces. We are simply interested in how trustworthy they appear.',
    'This task will take approximately 5 minutes to complete, although you will be given 30 minutes to complete the task and enter your code into Mechanical Turk.',
	'We understand that this type of task can become pretty repetitive, but there are not too many faces to rate, so please try your best to stay focused and rate each face based on how trustworthy you personally think they appear.'
	]; 
consentPage.consentBold = [ 
	'Please DO NOT use your browser\'s back or reload buttons!',
	'You will receive the code for Mechanical Turk at the end of the study.'
	];


////////////////////////////
// SET UP THE RATING TASK //
////////////////////////////
var voteTask = new voteObj();

// Change task-specific information here (more info can be found in Task.js && vote.js)
voteTask.name = trait;
voteTask.prompt="How " + trait + " is this person?";
voteTask.instructions=['In the following task, please rate the following faces based on how ' + trait + ' they appear.<br><br><b style="color:red">The <strong>left</strong> side of the scale represents <strong>less ' + trait + '</strong> faces.<br><br>The <strong>right</strong> side of the scale represents <strong>more ' + trait + '</strong> faces. <br><br><b style="color:black">There are no correct or incorrect answers.'];
voteTask.trialScale = ["Extremely un" + trait, "Very untrustworthy", "Somewhat untrustworthy","Neutral","Somewhat trustworthy","Very trustworthy","Extremely " + trait]; 
voteTask.picArray = ['h01.bmp','h02.bmp','h03.bmp','h04.bmp','h05.bmp','h06.bmp','h07.bmp','h08.bmp','h09.bmp','h10.bmp','h11.bmp','h12.bmp','h13.bmp','h14.bmp','h15.bmp','h16.bmp','h17.bmp','h18.bmp','h19.bmp','h20.bmp','h21.bmp','h22.bmp','h23.bmp','h24.bmp','h25.bmp','h26.bmp','h27.bmp','h28.bmp','h29.bmp','h30.bmp','h31.bmp','h32.bmp','h33.bmp','h34.bmp','h35.bmp','h36.bmp','h37.bmp','h38.bmp','h39.bmp','h40.bmp','h41.bmp','h42.bmp','h43.bmp','h44.bmp','h45.bmp','h46.bmp','h47.bmp','h48.bmp','h49.bmp','h50.bmp','h51.bmp','h52.bmp','h53.bmp','h54.bmp'];

// These are for styling purpose (more properties can be found in Task.js && vote.js)
voteTask.color = 'black';
voteTask.background_color = 'rgb(175,175,175)';
voteTask.picHeight = 400; 
voteTask.width = 1000;
voteTask.height = 600;
voteTask.answerWidth = 120;
voteTask.feedbackTime = 2000;


//////////////////////////////////
// SET UP THE DEMOGRAPHICS TASK //
//////////////////////////////////
var demoTask = new demo();
demoTask.questions = [
	['age','gender','english'],
	['hispanic','race']
]



/////////////////////////////////////
// DEFINE THE ORDER OF TASKS ABOVE //
/////////////////////////////////////
window.onload = function () { screenerTask.start(); };
screenerTask.nextTask = function () {
	if (this.eligible) {
		consentPage.start();
	} else {
		$('body').empty().html('Sorry, you are NOT eligible for this study. Please do NOT accept the HIT.').show();
	}
}
consentPage.nextTask = function(){ voteTask.start();}
voteTask.nextTask = function(){ demoTask.start();};