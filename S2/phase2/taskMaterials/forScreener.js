"use strict";
var subjID, version, IP;
var study = "ratings/scc_ts"; 		//CHANGEME
subjID = getSubjID(7); 							// # is the length of subjID
preventTouch(); 

version = getAllUrlParams().version;

///////////////////////////
// SET UP SCREENING FORM //
///////////////////////////
var screenerTask = new Screener();
screenerTask.questions = [['MTurkID', 'CRT1', 'race', 'bornUS', 'english']]; 
screenerTask.checkCustomEligibilities = function () {
    var race_sel = '';
    $('input:checkbox.race').each(function (i,box) {
        box.checked ? race_sel = race_sel + $(box).attr('name') + " " : "";
    });
    
    if (race_sel.trim() == 'White' && $('input:radio[name=bornUS]:checked').val()=='yes') {
        return true;
    }
    return false;
}

/////////////////////////
// SET UP CONSENT PAGE //
/////////////////////////
var consentPage = new Consent();
consentPage.imagesToLoad = [];
consentPage.consentTitle = ['Study on language'];
consentPage.consentText = [
	'Welcome! Thank you for your participation.',
	'You will be presented pairs of words. We are interested in how similar they are.',
	'This task will take approximately 5 minutes to complete, although you will be given 30 minutes to complete the task and enter your code into Mechanical Turk.'
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
voteTask.name = "scc_ts";
voteTask.prompt="How similar are these two traits?";
voteTask.instructions=["In this task, you will be asked to indicate how meaningfully similar pairs of words are. The words you are traits that can refer to specific people (for example, 'kind' or 'annoying' or 'tall'). You will be presented with two traits and asked to judge how similar the concepts of the two traits seem, as they would be applied to people in everyday life. <br><br>While many of these pairs of traits may not be identical in meaning, please do your best to indicate how meaningfully similar they are in any way.<br><br> Please indicate how similar the pairs of traits are on the scale provided, choosing any response between 1 - 7, with 1 corresponding to not at all similar, 4 to moderately similar, 7 to very similar.<br><br>Please take a moment for each pair to consider your response thoughtfully."];
voteTask.trialScale = ["1 - Not at all similar","2","3","4 - Moderately similar","5","6","7 - Very similar"]; 

if (version === 'a') {
    voteTask.picArray = ['outgoing  -  passive','unintelligent  -  ignorant','custom following  -  traditional','muscular  -  active','smart  -  hotheaded','talkative  -  passive','hotheaded  -  hostile','talkative  -  extroverted','athletic  -  conformist','uneducated  -  extroverted','scientific  -  outgoing','conformist  -  strong','scientific  -  uneducated','shy  -  traditional','ignorant  -  intelligent','active  -  quiet','reserved  -  ignorant','strong  -  outgoing','dumb  -  aggressive','athletic  -  aggressive','conventional  -  family oriented','smart  -  athletic','passive  -  active','hotheaded  -  brainy','conventional  -  brainy','reserved  -  smart','quiet  -  strong','uneducated  -  unintelligent','extroverted  -  conventional','active  -  social','unintelligent  -  traditional','family oriented  -  intelligent','timid  -  athletic','smart  -  hostile','smart  -  talkative','conformist  -  passive','intelligent  -  rule obsessed','rule obsessed  -  reserved','dumb  -  uneducated','hotheaded  -  passive','hotheaded  -  conformist','intelligent  -  active','muscular  -  hotheaded','reserved  -  social','unintelligent  -  family oriented','brainy  -  rule obsessed','hostile  -  uneducated','muscular  -  uneducated','ignorant  -  passive','passive  -  smart','conventional  -  passive','reserved  -  aggressive','ignorant  -  aggressive','shy  -  smart','shy  -  outgoing','hostile  -  strong','custom following  -  dumb','custom following  -  outgoing','hotheaded  -  obedient','strong  -  active','social  -  timid','shy  -  conventional'];
} else if (version === 'b') {
	voteTask.picArray = ['social  -  athletic','uneducated  -  quiet','custom following  -  athletic','reserved  -  scientific','shy  -  social','scientific  -  active','strong  -  uneducated','dumb  -  conventional','aggressive  -  traditional','hotheaded  -  unintelligent','strong  -  dumb','social  -  aggressive','social  -  unintelligent','quiet  -  custom following','family oriented  -  timid','brainy  -  strong','family oriented  -  shy','extroverted  -  conformist','threatening  -  rule obsessed','threatening  -  traditional','traditional  -  ignorant','passive  -  athletic','quiet  -  outgoing','rule obsessed  -  timid','scientific  -  hostile','family oriented  -  hotheaded','family oriented  -  muscular','family oriented  -  outgoing','intelligent  -  muscular','brainy  -  shy','reserved  -  conformist','smart  -  traditional','rule obsessed  -  custom following','traditional  -  brainy','smart  -  uneducated','uneducated  -  traditional','strong  -  custom following','threatening  -  aggressive','dumb  -  muscular','passive  -  shy','hotheaded  -  dumb','traditional  -  reserved','ignorant  -  hostile','ignorant  -  threatening','ignorant  -  muscular','muscular  -  passive','extroverted  -  quiet','threatening  -  scientific','brainy  -  aggressive','outgoing  -  conformist','extroverted  -  muscular','obedient  -  unintelligent','unintelligent  -  scientific','hotheaded  -  social','scientific  -  rule obsessed','extroverted  -  scientific','passive  -  hostile','extroverted  -  smart','threatening  -  family oriented','conventional  -  hostile','social  -  scientific','threatening  -  obedient'];
} else if (version === 'c') {
	voteTask.picArray = ['family oriented  -  social','custom following  -  unintelligent','brainy  -  ignorant','ignorant  -  custom following','rule obsessed  -  aggressive','hotheaded  -  traditional','scientific  -  talkative','custom following  -  aggressive','quiet  -  traditional','conformist  -  conventional','shy  -  unintelligent','quiet  -  scientific','uneducated  -  aggressive','active  -  reserved','hostile  -  active','threatening  -  unintelligent','strong  -  talkative','uneducated  -  conformist','strong  -  intelligent','outgoing  -  rule obsessed','aggressive  -  hotheaded','family oriented  -  uneducated','smart  -  ignorant','smart  -  obedient','active  -  athletic','rule obsessed  -  obedient','ignorant  -  uneducated','unintelligent  -  conformist','athletic  -  conventional','smart  -  unintelligent','extroverted  -  unintelligent','conformist  -  custom following','outgoing  -  unintelligent','social  -  quiet','smart  -  rule obsessed','uneducated  -  custom following','threatening  -  quiet','aggressive  -  active','conformist  -  smart','intelligent  -  unintelligent','talkative  -  hostile','scientific  -  strong','intelligent  -  quiet','custom following  -  smart','shy  -  extroverted','threatening  -  hotheaded','timid  -  scientific','intelligent  -  brainy','custom following  -  shy','passive  -  rule obsessed','muscular  -  social','extroverted  -  traditional','brainy  -  active','obedient  -  timid','unintelligent  -  timid','ignorant  -  rule obsessed','muscular  -  timid','conformist  -  quiet','family oriented  -  strong','extroverted  -  athletic','traditional  -  obedient','ignorant  -  timid'];
} else if (version === 'd') {
	voteTask.picArray = ['timid  -  quiet','intelligent  -  conformist','reserved  -  custom following','quiet  -  smart','ignorant  -  hotheaded','hotheaded  -  shy','talkative  -  social','obedient  -  family oriented','passive  -  custom following','social  -  passive','hostile  -  family oriented','hotheaded  -  uneducated','ignorant  -  social','athletic  -  talkative','timid  -  uneducated','dumb  -  smart','extroverted  -  strong','active  -  threatening','intelligent  -  conventional','conformist  -  aggressive','extroverted  -  threatening','intelligent  -  timid','uneducated  -  athletic','brainy  -  muscular','athletic  -  dumb','strong  -  ignorant','talkative  -  custom following','conventional  -  strong','rule obsessed  -  extroverted','traditional  -  family oriented','quiet  -  athletic','conventional  -  uneducated','rule obsessed  -  conformist','extroverted  -  social','hotheaded  -  reserved','dumb  -  ignorant','scientific  -  family oriented','conformist  -  talkative','strong  -  smart','athletic  -  scientific','traditional  -  conformist','hotheaded  -  rule obsessed','outgoing  -  reserved','family oriented  -  ignorant','brainy  -  outgoing','obedient  -  ignorant','traditional  -  scientific','outgoing  -  traditional','active  -  obedient','traditional  -  passive','reserved  -  talkative','muscular  -  scientific','shy  -  intelligent','athletic  -  family oriented','dumb  -  extroverted','timid  -  threatening','threatening  -  uneducated','shy  -  obedient','intelligent  -  traditional','reserved  -  uneducated','scientific  -  brainy','rule obsessed  -  unintelligent'];
} else if (version === 'e') {
	voteTask.picArray = ['conformist  -  scientific','intelligent  -  hostile','quiet  -  passive','smart  -  scientific','traditional  -  muscular','scientific  -  custom following','threatening  -  strong','conventional  -  social','obedient  -  brainy','hotheaded  -  custom following','quiet  -  unintelligent','threatening  -  social','rule obsessed  -  strong','threatening  -  conventional','reserved  -  timid','reserved  -  hostile','extroverted  -  custom following','athletic  -  hostile','brainy  -  unintelligent','strong  -  timid','rule obsessed  -  active','shy  -  timid','hostile  -  custom following','dumb  -  shy','talkative  -  muscular','threatening  -  outgoing','outgoing  -  ignorant','social  -  intelligent','brainy  -  reserved','timid  -  hostile','dumb  -  passive','intelligent  -  outgoing','obedient  -  outgoing','athletic  -  reserved','extroverted  -  timid','obedient  -  custom following','active  -  hotheaded','talkative  -  rule obsessed','brainy  -  timid','unintelligent  -  talkative','uneducated  -  intelligent','active  -  shy','threatening  -  hostile','brainy  -  athletic','threatening  -  athletic','family oriented  -  quiet','custom following  -  intelligent','talkative  -  active','talkative  -  dumb','obedient  -  aggressive','active  -  outgoing','unintelligent  -  conventional','traditional  -  social','conventional  -  active','strong  -  athletic','traditional  -  active','extroverted  -  ignorant','aggressive  -  extroverted','shy  -  muscular','obedient  -  hostile','conventional  -  outgoing','quiet  -  muscular'];
} else if (version === 'f') {
	voteTask.picArray = ['uneducated  -  active','shy  -  threatening','conformist  -  muscular','passive  -  reserved','uneducated  -  rule obsessed','talkative  -  traditional','custom following  -  timid','intelligent  -  extroverted','scientific  -  shy','smart  -  social','smart  -  aggressive','extroverted  -  reserved','rule obsessed  -  quiet','rule obsessed  -  dumb','dumb  -  conformist','scientific  -  intelligent','conventional  -  aggressive','reserved  -  strong','family oriented  -  talkative','unintelligent  -  active','unintelligent  -  athletic','brainy  -  family oriented','reserved  -  threatening','social  -  obedient','dumb  -  unintelligent','shy  -  rule obsessed','timid  -  traditional','muscular  -  aggressive','timid  -  aggressive','dumb  -  reserved','timid  -  conformist','aggressive  -  quiet','brainy  -  conformist','passive  -  extroverted','hostile  -  muscular','smart  -  active','dumb  -  brainy','obedient  -  talkative','obedient  -  strong','obedient  -  uneducated','strong  -  hotheaded','hostile  -  social','uneducated  -  social','athletic  -  traditional','conventional  -  reserved','obedient  -  intelligent','reserved  -  obedient','custom following  -  threatening','threatening  -  brainy','uneducated  -  brainy','ignorant  -  conventional','athletic  -  ignorant','hotheaded  -  scientific','quiet  -  hostile','quiet  -  ignorant','outgoing  -  smart','social  -  dumb','hostile  -  brainy','dumb  -  threatening','talkative  -  outgoing','talkative  -  threatening','aggressive  -  shy'];
} else if (version === 'g') {
	voteTask.picArray = ['smart  -  conventional','passive  -  family oriented','talkative  -  conventional','custom following  -  active','smart  -  muscular','conventional  -  hotheaded','passive  -  unintelligent','brainy  -  extroverted','talkative  -  timid','unintelligent  -  muscular','unintelligent  -  strong','unintelligent  -  hostile','brainy  -  smart','muscular  -  reserved','active  -  timid','unintelligent  -  reserved','muscular  -  custom following','hotheaded  -  athletic','reserved  -  family oriented','hostile  -  traditional','conventional  -  timid','unintelligent  -  aggressive','aggressive  -  passive','conformist  -  social','athletic  -  intelligent','hostile  -  conformist','active  -  extroverted','muscular  -  athletic','obedient  -  muscular','intelligent  -  threatening','conformist  -  family oriented','conventional  -  scientific','timid  -  dumb','scientific  -  obedient','conformist  -  obedient','outgoing  -  muscular','intelligent  -  passive','shy  -  talkative','family oriented  -  custom following','obedient  -  extroverted','obedient  -  athletic','conventional  -  traditional','strong  -  muscular','rule obsessed  -  muscular','threatening  -  passive','hostile  -  rule obsessed','custom following  -  social','reserved  -  quiet','ignorant  -  active','rule obsessed  -  social','dumb  -  scientific','passive  -  obedient','conventional  -  custom following','muscular  -  conventional','aggressive  -  talkative','hostile  -  extroverted','outgoing  -  uneducated','brainy  -  custom following','aggressive  -  family oriented','timid  -  passive','extroverted  -  hotheaded','conformist  -  ignorant'];
} else if (version === 'h') {
	voteTask.picArray = ['intelligent  -  smart','social  -  brainy','smart  -  family oriented','strong  -  shy','hotheaded  -  talkative','scientific  -  passive','hostile  -  dumb','extroverted  -  family oriented','rule obsessed  -  traditional','active  -  dumb','dumb  -  quiet','hotheaded  -  quiet','outgoing  -  aggressive','dumb  -  outgoing','brainy  -  quiet','social  -  outgoing','family oriented  -  active','traditional  -  dumb','timid  -  outgoing','ignorant  -  scientific','rule obsessed  -  conventional','threatening  -  muscular','talkative  -  ignorant','shy  -  reserved','traditional  -  strong','quiet  -  obedient','hostile  -  aggressive','threatening  -  smart','shy  -  conformist','talkative  -  brainy','obedient  -  dumb','intelligent  -  dumb','extroverted  -  outgoing','active  -  conformist','strong  -  passive','outgoing  -  hostile','shy  -  quiet','strong  -  social','outgoing  -  athletic','brainy  -  passive','quiet  -  talkative','smart  -  timid','aggressive  -  intelligent','athletic  -  shy','uneducated  -  talkative','conformist  -  threatening','family oriented  -  rule obsessed','quiet  -  conventional','shy  -  uneducated','strong  -  aggressive','scientific  -  aggressive','athletic  -  rule obsessed','hotheaded  -  intelligent','hostile  -  shy','hotheaded  -  outgoing','timid  -  hotheaded','conventional  -  obedient','reserved  -  intelligent','shy  -  ignorant','family oriented  -  dumb','intelligent  -  talkative','passive  -  uneducated'];
}

// These are for styling purpose (more properties can be found in Task.js && vote.js)
voteTask.color = 'black';
voteTask.background_color = 'rgb(175,175,175)';
voteTask.picHeight = 264; 
voteTask.width = 1000;
voteTask.height = 600;
voteTask.answerWidth = 120;
voteTask.feedbackTime = 2000;


////////////////////////////
// SET UP THE SURVEY TASK //
////////////////////////////
var surveyTask = new survey();
surveyTask.surveyList = [];
surveyTask.surveyBlocks = [1,1,1];		// randomize order of surveys belonging to same block
surveyTask.randomizeItems	= [1,1,1];	// 1 means randomize and 0 means no randomization
surveyTask.fastRespCutTime = 500;						// warning message if response time under 1000ms
surveyTask.width = 1200;
surveyTask.answerWidth = 110;
surveyTask.answerfontsize = 10;


//////////////////////////////////
// SET UP THE DEMOGRAPHICS TASK //
//////////////////////////////////
var demoTask = new demo();
demoTask.questions = [
	['age','gender','race','hispanic'],
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
voteTask.nextTask = function(){ demoTask.start();}
