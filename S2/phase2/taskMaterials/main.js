"use strict";
var subjID, IP;
var study = "ratings/scrSt3Pt2"; 				// data save path
subjID = getSubjID(7); 							// length of subjID
preventTouch(); 


///////////////////////////
// SET UP SCREENING FORM //
///////////////////////////
var screenerTask = new Screener();
screenerTask.questions = [['MTurkID', 'age', 'bornUS', 'english', 'attention']]; 
screenerTask.checkCustomEligibilities = function () {
	var age = $('input:text[name=age]').val();
   if ($('input:radio[name=attention]:checked').val()=='Other' && $('input:radio[name=english]:checked').val()=='yes' && (''+parseInt(age))==age && parseInt(age)>=18 && parseInt(age)<=60) {
       return true;
   }
    return false;
}


/////////////////////////
// SET UP CONSENT PAGE //
/////////////////////////
var consentPage = new Consent();
consentPage.imagesToLoad = ['CS.jpg','SC.jpg','CS1.jpg','SC1.jpg','CS2.jpg','SC2.jpg','CS3.jpg','SC3.jpg','CS4.jpg','SC4.jpg'];
consentPage.consentTitle = ['Study on Perceiving People'];
consentPage.consentText = ['You are invited to take part in a research study named Seeing Faces to learn more about how we perceive and form impressions of faces. The research is being conducted by Prof. David Amodio, who is a faculty member in the Psychology department in the Graduate School of Arts and Sciences at New York University.',
'If you agree to be in this study, you will be asked to: complete a task that involves forming impressions of people and fill out questionnaires assessing demographic information, and social attitudes. Your participation will take about 6 minutes. You will be paid $0.60 (60 cents) for completing this study. If you withdraw at any time, you will not receive payment for the time you have completed.',
'There are no known risks associated with your participation in this research beyond those of everyday life.  Although you will receive no direct benefits for participation in this study, it may make you more aware of how knowledge is discovered in psychology and help the investigator better understand how people make decisions.',
'Taking part in this study is voluntary. You have the right to skip or not answer any questions you prefer not to answer. When you complete the study, a thorough written explanation of it will be provided.',
'Confidentiality of your research records will be maintained by assigning unique, confidential identification number codes to your responses. Information not containing identifiers may be used in future research or shared with other researchers without your additional consent.',
'The researcher cannot keep information confidential if they have concerns that someone is hurting children, that someone is hurting you, or that you might hurt yourself or someone else. In such cases, they will inform people in authority about their concerns.',
'If there is anything about the study or taking part in it that is unclear or that you do not understand, or if you have questions or wish to report a research-related problem, you may contact the principal investigator, Prof. Amodio at join.snlab@gmail.com.',
'For questions about your rights as a research participant, you may contact the University Committee on Activities Involving Human Subjects (UCAIHS), NYU, (212) 998-4808 or ask.humansubjects@nyu.edu, 665 Broadway, Suite 804, New York, NY 10012.'
 ]; 
consentPage.consentBold = [ 
	'DO NOT use your browser\'s back or reload buttons!',
	'You will receive the code for Mechanical Turk at the end of the study.',
	'Clicking below indicates that you are at least 18 years old, and consent to participate.'
	];

///////////////////////////////
// SET UP THE Learning Phase //
///////////////////////////////
var learnPhase = new voteObjMultiComp();
learnPhase.name = 'learnPhase';
learnPhase.picHeight = 310;
learnPhase.background_color = 'white';
learnPhase.screen_color = 'white';
learnPhase.color = 'black'; 
learnPhase.fontSize = 20; 
learnPhase.fastRespCutTime = 1000;
learnPhase.feedbackTime = 2000;
learnPhase.prompt='';
learnPhase.instructions = ['Thank you for participating in our study! <br> Previous work has shown that people can be highly accurate in inferring traits from faces. In this study, we are interested in people\'s ability to infer traits from faces even when facial cues are difficult to detect. <br> In the following task, you will be asked about your impressions of several people presented to you. The faces you will see may appear similar in some ways, but they will also differ, and the picture quality is low. <br> On every trial, you will see a pair of faces. You will be asked to consider a certain trait, personal quality, or ability, and then decide which of the two people it describes better. <br> For each trial, please carefully read the question and try to answer to the best of your ability. There are no right or wrong answers.'];
learnPhase.trialScale = ['Definitely Left','Mostly Left','Slightly Left','Slightly Right','Mostly Right','Definitely Right'];     // Change this part to an actual scale if you want to make it a rating task
learnPhase.possibleStims = ['CS1.jpg','SC1.jpg','CS2.jpg','SC2.jpg','CS3.jpg','SC3.jpg','CS4.jpg','SC4.jpg'];

learnPhase.picArray = [	''+learnPhase.possibleStims[randint(0,7)]+'//Please select the option on the far left.',	
						''+learnPhase.possibleStims[randint(0,7)]+'//Please select the option on the far right.',
						
						''+learnPhase.possibleStims[randint(0,7)]+'//Who is more curious?',	   					
						''+learnPhase.possibleStims[randint(0,7)]+'//Who is more content?',	   					
						''+learnPhase.possibleStims[randint(0,7)]+'//Who is more conscientious?',	   					
						''+learnPhase.possibleStims[randint(0,7)]+'//Who is more adventurous?',	   					
						''+learnPhase.possibleStims[randint(0,7)]+'//Who is more courageous?',	   					
						''+learnPhase.possibleStims[randint(0,7)]+'//Who is more unassuming?',
							   					
						''+learnPhase.possibleStims[randint(0,7)]+'//Who is more financially poor?',	   					
						''+learnPhase.possibleStims[randint(0,7)]+'//Who is less educated?',	   					
						''+learnPhase.possibleStims[randint(0,7)]+'//Who is more ignorant?',	   					
						''+learnPhase.possibleStims[randint(0,7)]+'//Who is more likely to be on welfare?',	   					
						''+learnPhase.possibleStims[randint(0,7)]+'//Who is unemployed?',	   					
						''+learnPhase.possibleStims[randint(0,7)]+'//Who is less intelligent?',	
						   					
						''+learnPhase.possibleStims[randint(0,7)]+'//Who is more aggressive?',	   					
						''+learnPhase.possibleStims[randint(0,7)]+'//Who is a criminal?',	   					
						''+learnPhase.possibleStims[randint(0,7)]+'//Who is more dangerous?',	   					
						''+learnPhase.possibleStims[randint(0,7)]+'//Who is more hostile?',	   					
						''+learnPhase.possibleStims[randint(0,7)]+'//Who is more rude?',	   					
						''+learnPhase.possibleStims[randint(0,7)]+'//Who is louder?',	 
						  					
						''+learnPhase.possibleStims[randint(0,7)]+'//Who is more musical?',	   					
						''+learnPhase.possibleStims[randint(0,7)]+'//Who is more rhythmic?',	   					
						''+learnPhase.possibleStims[randint(0,7)]+'//Who is more opinionated?',
						''+learnPhase.possibleStims[randint(0,7)]+'//Who is more athletic?',
						''+learnPhase.possibleStims[randint(0,7)]+'//Who is more muscular?',
						''+learnPhase.possibleStims[randint(0,7)]+'//Who is more religious?'];
						
learnPhase.setCounter = function () {
	learnPhase.counter += 1;
	$( '#progressbar' ).progressbar({ value: learnPhase.counter , max : learnPhase.length})
		.show();
}
learnPhase.randomizeOptions = false;
learnPhase.randomizeTrials  = true; 

///////////////////////////////////////
// SET UP THE DEMOGRAPHICS QUESTIONS //
///////////////////////////////////////
var demoQ = new demo();
demoQ.questions = [ ['age', 'gender', 'race', 'hispanic', 'income'] ];  // list of questions in scripts/allQuestionList.js


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
consentPage.nextTask = function(){ learnPhase.start();};
learnPhase.nextTask = function(){ demoQ.start();}; 