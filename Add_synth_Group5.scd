(
s.waitForBoot({
	var keys,osc,decay,sustainLevel,sound;
	var attack0 = 0.005, release0 = 2, master0 = 1;
	var attack1 = 0.02, release1 = 0.7, master1 = 1;
	var attack2 = 0.02, release2 = 0.7, master2 = 1;
	var attack3 = 0.02, release3 = 0.7, master3 = 1;
	decay = 0.7;
	keys = Array.newClear(128);
	MIDIClient.init;
	MIDIIn.connectAll;

	//******************************************** SynthDefs ********************************************
	SynthDef("risset", {
		arg out= 0, pan= 0, freq= 400, amp= 0.1, t_trig=1, master = 1, attack = 0.005, decay = 0, sustainLevel = 0, release = 2;
		var amps= [1, 0.67, 1, 1.8, 2.67, 1.67, 1.46, 1.33, 1.33, 1, 1.33];
		var durs= [1, 0.9, 0.65, 0.55, 0.325, 0.35, 0.25, 0.2, 0.15, 0.1, 0.075];

		var frqs= [0.56, 0.56, 0.92, 0.92, 1.19, 1.7, 2, 2.74, 3, 3.76, 4.07];
		var dets= [0, 1, 0, 1.7, 0, 0, 0, 0, 0, 0, 0];    // Detune
		// Mix.fill(n,function) n= size of array to create, function: array filling function
		var src= Mix.fill(11, {
			arg i;
			var env = EnvGen.ar(Env.perc(attack, release*durs[i], amps[i], -4.5), t_trig);
			SinOsc.ar(freq*frqs[i]+dets[i], 0, amp*env);
		});
		var sig = 0.1*master*Pan2.ar(src, pan);
		Out.ar(out, sig);
		DetectSilence.ar(sig, doneAction: Done.freeSelf);
	}).add;

	SynthDef("Piano", {
		arg out= 0, pan= 0, freq= 440, amp= 1, attack = 0.02, decay = 0.7, sustainLevel = 0, release = 0.2,  speed=0.5, mod_type = 0, master=1;
		var f_start=1,f_end=1,a_start=1,a_end=1;
		var freq_var = Select.kr(mod_type,[XLine.kr(f_start,f_end,speed),SinOsc.kr(1/speed,0,(f_start+f_end))]);
		var freq_env =freq*freq_var;
		var amp_var = Select.kr(mod_type,[XLine.kr(a_start,a_end,speed),SinOsc.kr(1/speed,0,(a_start-a_end))]);
		var amp_env = amp_var;
		var fr = [440, 882.76, 1334.1, 449.93, 1790.33, 417.72, 50.18, 58.45, 1330.48, 66.17, 115.79, 1332.13, 104.76];
		var am = [1.0, 0.294, 0.065, 0.053, 0.046, 0.042, 0.04, 0.036, 0.0325, 0.031, 0.023, 0.0234, 0.0234];
		var env = EnvGen.ar(Env.adsr(attack,decay,sustainLevel,release),doneAction:2);
		var sig = Mix(SinOsc.ar(freq_env*(fr/440),0,am/2));
		sig = Splay.ar(sig,0,amp,pan)*master;
		sig = 1.5*sig*env*amp*amp_env;
		Out.ar(out, sig);
		DetectSilence.ar(sig, doneAction: Done.freeSelf);
	}).add;


	SynthDef("Bass", {
		arg out = 0, freq = 440, attack = 0.02, decay = 0.7, sustainLevel = 0, release = 0.2, pan = 0, amp=1, speed=0.5, mod_type = 0, master=1;
		var f_start=1,f_end=1,a_start=1,a_end=1;

		var freq_var = Select.kr(mod_type,[XLine.kr(f_start,f_end,speed),SinOsc.kr(1/speed,0,(f_start+f_end))]);
		var freq_env =freq*freq_var;
		var amp_var = Select.kr(mod_type,[XLine.kr(a_start,a_end,speed),SinOsc.kr(1/speed,0,(a_start-a_end))]);
		var amp_env = amp_var;
		var fr=[440, 216.72, 664.93, 880, 50.9, 1037.6, 1316.72, 2423.28, 1546.6, 2199.99, 1436.57, 2643.28, 1794.5];
		var am=[1.0, 0.881, 0.462, 0.185, 0.0931, 0.0528, 0.0399, 0.0245, 0.0239, 0.0224, 0.0152, 0.0107, 0.0107];
		var env = EnvGen.ar(Env.adsr(attack,decay,sustainLevel,release,(am)/13),doneAction:2);
		var sig = Mix(SinOsc.ar(freq_env*(fr/880),0,(am)/13))*amp*amp_env;
		sig = sig*env*master*10;
		sig = LPF.ar(sig, 300, 13, 0);
		sig = Splay.ar(sig,0,amp,pan);
		Out.ar(out, sig);
		DetectSilence.ar(sig, doneAction: Done.freeSelf);
	}).add;


	SynthDef("Bleep", {
		arg out = 0, freq = 440, attack = 0.02, decay = 0.7, sustainLevel = 0, release = 0.2, pan = 0, amp=1, speed=0.5, master=1;
		var f_start=1,f_end=1,a_start=1,a_end=1;

		var freq_env = freq*XLine.kr(f_start,f_end,speed);
		var amp_env = XLine.kr(a_start,a_end,speed);
		var env = EnvGen.ar(Env.adsr(attack,decay,sustainLevel,release),doneAction:2);

		var sig = Blip.ar(freq_env,mul:1)+SinOsc.ar(freq_env,mul:0.5)*master;
		sig = sig * env*0.2;
		sig = Pan2.ar(sig, pan);
		Out.ar(out,sig);
		DetectSilence.ar(sig, doneAction: Done.freeSelf);
	}).add;

	//******************************************** OscDefs ********************************************
	osc = NetAddr("127.0.0.1",57120);
	osc.sendMsg("/sendMeAllValues", "there");

	OSCdef('OSCKnob',{
		arg msg;
		postln("knob" + msg);

		if(msg.size > 2) {
			master0 = msg[1];
			attack0 = msg[2];
			release0 = msg[3];
			master1 = msg[4];
			attack1 = msg[5];
			release1 = msg[6];
			master2 = msg[7];
			attack2 = msg[8];
			release2 = msg[9];
			master3 = msg[10];
			attack3 = msg[11];
			release3 = msg[12];
		}  {postln("Error: Empty msg")};
	},"/knob");

	//******************************************** MIDI ********************************************
	~noteOnFunc = {
		arg src, chan, num, val;
		var node;
		node = keys.at(num);

		if(node.notNil, {
			node.release;
			keys.put(num, nil);
		});
		Array.fill(1, {Synth("risset", [\freq, num.midicps, \amp, val/(127), \master, master0, \sustainLevel, sustainLevel, \attack, attack0, \release, release0], addAction: \addToTail)});

		Array.fill(1, {Synth("Piano", [\freq, num.midicps, \amp, val/(127), \master, master1, \sustainLevel, sustainLevel, \attack, attack1, \decay, release1], addAction: \addToTail)});

		Array.fill(1, {Synth("Bass", [\freq, num.midicps, \amp, val/(127), \master, master2, \sustainLevel, sustainLevel, \attack, attack2, \decay, release2], addAction: \addToTail)});

		Array.fill(1, {Synth("Bleep", [\freq, num.midicps, \amp, val/(127), \master, master3, \sustainLevel, sustainLevel, \attack, attack3, \decay, release3], addAction: \addToTail)});

		keys.put(num, node);

		postln("MIDI message: "+[chan,num,val]);
	};

	MIDIIn.addFuncTo(\noteOn, ~noteOnFunc);

	~noteOffFunc = {
		arg src, chan, num, vel;
		var node;
		node = keys.at(num);

		if(node.notNil, {
			node.set(\gate, 0);
			node.release;
			keys.put(num, nil);
		});
	};

	MIDIIn.addFuncTo(\noteOff, ~noteOffFunc);

});
)

q.value();