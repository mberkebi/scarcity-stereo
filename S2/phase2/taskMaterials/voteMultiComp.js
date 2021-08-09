// last update: 09/13/2018
// DongWon Oh (dongwoh@gmail.com)
//
// Vote function with multiple components, i.e., a verbal description with an image
//
// SUPER IMPORTANT: Use to distinguish different components within a stim array element, use "//" instead of "/"
//                  This is to allow users to be able to use HTML formatting (e.g., text color, embolding, italicization)
"use strict";

function voteObjMultiComp() {
	thisTask = this;
	this.csvHeader = 'SubjID,Study,Name,Trial,Stimulus,Rating,Response Time,Instructions Time\n';
	this.answerWidth = 110;
	this.answerHeight = 70;
	this.answerfontsize = 11;
	this.$prompt = $('<h2 id="prompt" style="display:none">Rate this picture</h2>');
	this.$stim = $('<div id="stim"></div>');
	this.$answerDiv = $('<div id="answerDiv"></div>');
	this.folder = 'ratings';
	this.suffix = '_ratings';
	this.csvLines = [];

	this.hideParts = function () {
		this.$answerDiv.hide();
		this.$stim.hide();
	}

	this.showParts = function () {
		this.$answerDiv.show();
		this.$stim.show();
		this.$prompt.show();

		// This is the new part in voteMultiComp.js, the verbal stimulus above the image.
///		var parts = this.picsToDisplay[0].split('/');
	//	var stim = parts[0];
	//	var verbalstim = parts[1];
//		
	}

	this.writeStim = function () {
		// This is the new part in voteMultiComp.js, the verbal stimulus above the image.
		//var stim = this.currentStim;
		var parts = this.picsToDisplay[0].split('//');
		var stim = parts[0];
		var verbalstim = parts[1];
		if (isPicFiletype(stim)){
			var $toAppend = this.appendImg(stim);
		} else {
			var $toAppend = this.appendP(stim);
		}
		this.$prompt.html(verbalstim)       // sentence
		this.$stim.empty().html($toAppend);
	}

	this.writeLine = function () {
		this.csvLine = subjID + ",";
		this.csvLine += study + ",";
		this.csvLine += this.name + ",";
		this.csvLine += this.counter + ",";
		this.csvLine += this.picsToDisplay[0][1] + ",";
		this.csvLine += this.currentResp + ",";
		this.csvLine += this.trialRT + ",";
		this.csvLine += this.instructionsTime + "\n";
	}

	this.setAnswerCSS = function () {		
		this.$answerDiv.css('width',this.answerWidth*this.trialScale.length)
			.css('height',this.answerHeight)
			.css('display','block')
			.css('margin','auto');
		$('.answer').css('white-space', 'normal')
			.css('font-size', this.answerfontsize)
			.css('width',this.answerWidth)
			.css('height',this.answerHeight)
			.css('word-wrap','break-word')
			.css('border', '1px solid black');
	}

	this.writeAnswers = function () {
		this.$answerDiv.empty().attr('class','btn-group')
		for (var i = 1; i <= this.trialScale.length; i++) {
			var $button = $('<button type="button"></button>');
			$button.attr('id', i)
				.attr('class', 'btn btn-default answer')
				.css('color','black')
				.html(this.trialScale[i-1])
				.on('click', function () {
					thisTask.makeResponse($(this).attr('id'));
				});
			this.$answerDiv.append($button);
		};
	};
	
	this.setCounter = function () {
		this.counter += 1;
		$( "#progressbar" ).progressbar({ value: this.counter , max : this.length})
			.show();
	}
}
voteObjMultiComp.prototype = new Task();
