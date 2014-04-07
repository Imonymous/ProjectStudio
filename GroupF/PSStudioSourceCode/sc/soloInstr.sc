(
var spk_gain , speedFactor, signFactor;


spk_gain = {arg posX, posY, factor;
	var distanceSound, gain;
	distanceSound = sqrt( (posX*posX) + (posY*posY)  )/factor;
	("distance sound: "+distanceSound).postln;
	if( distanceSound < 1.0, {  distanceSound = 1.00 ;} );
	gain = 1/(distanceSound*distanceSound);

};

speedFactor = {arg posX, posY, prevX,prevY, deltaTime;
	var distanceSound, speed, factor, distancePosSound,distancePreSound ;
	distancePosSound = sqrt( (posX*posX) + (posY*posY)  );
	distancePreSound = sqrt( (prevX*prevX) + (prevY*prevY)  );

	speed = (distancePosSound -distancePreSound)/deltaTime;

	if( abs(speed) > 500, {  speed = 500*sign(speed) ;});
	speed/25;

};

signFactor = {arg posX, posY, prevX,prevY;
	var distanceSound, factor, distancePosSound,distancePreSound ;
	distancePosSound = sqrt( (posX*posX) + (posY*posY)  );
	distancePreSound = sqrt( (prevX*prevX) + (prevY*prevY)  );

	sign(distancePosSound -distancePreSound);


};



SynthDef("marcatoSound",{ arg out=0,bufnum=0, duration, ratePitch, gain ;
	var sigOut, env ;

	e = Env.new( [1.0, 1.0, 0.0], [0.99, 0.01] );
	env = EnvGen.ar( e, timeScale: duration, doneAction: 2 ) ;

	// PlayBuf.ar(numChannels,bufnum,rate,trigger,startPos,loop)
	sigOut  = PlayBuf.ar(1,bufnum, ratePitch*BufRateScale.kr(bufnum)) ;

	Out.ar(out, gain* sigOut * env ) ;

}).load(s) ;



r = Routine({
	var duration, bufferUP,bufferDOWN,buffer, soundFileName, sFile, midiPitch, posX,posY,prevX,prevY , maxX,maxY, sourceX, sourceY,roomFactor ;
	var currentTime, previousTime, speed , rateSpeed,tickTime,gain;
	var spfactor, spbase;

	0.1.wait ;

	sFile = SoundFile.new;
	thisProcess.nowExecutingPath.dirname.postln;
	soundFileName = thisProcess.nowExecutingPath.dirname +/+ "TICK_UP.wav" ; midiPitch = 79 ;
	sFile.openRead(soundFileName);
	duration = sFile.numFrames / sFile.sampleRate ;
	bufferUP = Buffer.read( s,soundFileName);

	soundFileName = thisProcess.nowExecutingPath.dirname +/+"TICK_DOWN.wav" ; midiPitch = 79 ;
	sFile.openRead(soundFileName);
	//duration = sFile.numFrames / sFile.sampleRate ;
	bufferDOWN = Buffer.read( s,soundFileName);

	("Max X: " +Window.screenBounds.width).postln;
	("Max Y: " +Window.screenBounds.height).postln;
	roomFactor =10.0;
	maxX = Window.screenBounds.width;
	maxY = Window.screenBounds.height;

	sourceX = maxX/2.0;
	sourceY =0.0;

	5.wait;
	previousTime =thisThread.seconds;
	prevX = GUI.cursorPosition.x-sourceX;
	prevY = GUI.cursorPosition.y-sourceY;
	spbase = 40;
	tickTime = 5.0/spbase;
	gain = 1.0;
	3000.do({arg note;

		if( (note%2) == 0, {  buffer = bufferUP ;} , { buffer = bufferDOWN ;});

		//Gain computing
		currentTime = thisThread.seconds;
		posX =GUI.cursorPosition.x-sourceX;
		posY = GUI.cursorPosition.y-sourceY;
		("current time "+currentTime).postln;
		if( note > 5, {
			spfactor = speedFactor.value(posX, posY, prevX,prevY, (currentTime - previousTime)).postln;
			("Speed Add"	+ spfactor).postln;
			spbase = 50.00 +spfactor;
		});





		tickTime = 5.0/spbase;
		speed = spbase*signFactor.value(posX, posY, prevX,prevY);
		("Speed "	+ speed).postln;
		rateSpeed = 343.0/(343.0+speed);
		("factor: "+rateSpeed).postln;

		gain = spk_gain.value(posX, posY , 300.00);


		if( (GUI.cursorPosition.x > (maxX/1.1)), {
			var damping = 1 + ((GUI.cursorPosition.x - (maxX/1.1))/10) ;
			("damping X"	+ damping).postln;
			gain = gain/damping;
		});

		if( (GUI.cursorPosition.y > (maxY/1.1)), {
			var damping = 1 + ((GUI.cursorPosition.y - (maxY/1.1))/10) ;
			("damping Y"	+ damping).postln;
			gain = gain/damping;
		});

		("gain: "+gain).postln;

		Synth( "marcatoSound", [
			\out, 0,
			\bufnum, buffer.bufnum,
			\duration, duration,
			\ratePitch, rateSpeed,
			\gain, gain
		] );
		("Note: " ++ note).postln ;
		("Current X"+ posX).postln;
		("Current Y"+ posY).postln;
		(tickTime ).wait ;
		prevX = posX;
		prevY = posY;
		previousTime = currentTime;
	});

bufferUP.free ;
bufferDOWN.free ;
});

//SystemClock.play(r);
AppClock.play(r);
)