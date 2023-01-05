
// Week 4: Beginning Coding with SuperCollider – MUS 499C Fall 2020
// https://www.youtube.com/watch?v=nuqvp2toJq8

s.boot

// boost signal and then softclip to change sine shape.

(
{
	var sig;
	sig = SinOsc.ar(370);
	sig = sig * 8;
	sig = sig.softclip;
	sig = Pan2.ar(sig, -1, 0.2);
}.play
)

// separate synth def and execution.

(
f = {
	var sig;
	sig = SinOsc.ar(370);
	sig = sig * 8;
	sig = sig.softclip;
	sig = Pan2.ar(sig, -1, 0.2);
};
)

x = f.play;
x.free;

// add args to synthdef, and set new arguments.

(
f = {
	arg freq=250, boost=4;
	var sig;
	sig = SinOsc.ar(freq);
	sig = sig * boost;
	sig = sig.softclip;
	sig = Pan2.ar(sig, -1, 0.2);
};
)

x = f.play;
x.set(\freq, 200, \boost, 9);
x.set(\freq, exprand(100, 2000).round(200));
x.release(2); // fades out signal
x.free; // kills straight

// can also instantiate with args

x = f.play(args: [\freq, 240, \boost, 9])

// use midi notes instead of freqs using conversion method

x = f.play(args: [\freq, 48.midicps, \boost, 9])

// choose a note out of array
x = f.play(args: [\freq, (40, 45..70).choose.midicps]);

// add synths to array
a = []; // empty array
a = a.add(f.play(args: [\freq, (40, 42..50).choose.midicps]));
a.choose.release(1); // works but chance that it will action a dead synth.
a.do({arg n; n.release(1)}); // better

// trigger multiple notes

(
7.do({
	a = a.add(f.play(args: [\freq, (40, 42..70).choose.midicps]));
});
)

// release with random duration
a.do({arg n; n.release(exprand(2, 10))})

// add pan with rand from a set range.

(
~f2 = {
	arg freq=250, pan=0;
	var sig;
	sig = SinOsc.ar(freq);
	sig = sig * 4;
	sig = sig.softclip;
	sig = Pan2.ar(sig, pan, 0.05);
};

8.do({
	a = a.add(~f2.play(args: [\freq, (40, 42..70).choose.midicps, \pan, rrand(-0.8, 0.8).postln]));
});
)

a.do({arg n; n.release(exprand(2, 10))})

// envelopes, define the shape of the envelope.
// interesting concept, is this not the curve concept that you have through about.
// EnvelopeView allows for editing an env directly.

(
Env.new(
	[0, 1, 0.2, 0.2, 0], // points, y axis
	[1, 2.5, 2, 3], // duration, x axis
	[0, 3, 0, 0] // changes curve shape
).plot;
)

(
~f3 = {
	arg freq=250, boost=4, pan=0, amp=0.1;
	var sig, env;
	env = EnvGen.ar(
		Env.new(
			[0, 1, 0.2, 0.2, 0], // points, y axis
			[1, 2.5, 2, 3], // duration, x axis
			[0, 3, -4, 0] // changes curve shape
		));
	sig = SinOsc.ar(freq);
	sig = sig *  boost;
	sig = sig.softclip;
	sig = Pan2.ar(sig, pan, amp);
	sig = sig * env;
});

a = [];
8.do({a = a.add(~f3.play(args: [\freq, (40, 42..70).choose.midicps, \pan, rrand(-0.8, 0.8).postln]))});

// doneActions, clean up when envelope has finished.

(
~f4 = {
	arg freq=250, boost=4, pan=0, amp=0.1;
	var sig, env;
	env = EnvGen.ar(
		Env.new(
			[0, 1, 0.2, 0.2, 0], // points, y axis
			[1, 2.5, 2, 3], // duration, x axis
			[0, 3, -4, 0] // changes curve shape
		),
		doneAction: 2;
	);
	sig = SinOsc.ar(freq);
	sig = sig *  boost;
	sig = sig.softclip;
	sig = Pan2.ar(sig, pan, amp);
	sig = sig * env;
});

a = [];
8.do({a = a.add(~f4.play(args: [\freq, (40, 42..70).choose.midicps, \pan, rrand(-0.8, 0.8).postln]))});

// query sample rate which ar runs at
s.sampleRate; // 48000

// query block size which kr run at
s.options.blockSize; // 64

// compare ar and kr curves.

(
{
	[
		SinOsc.ar(100),
		SinOsc.kr(100)
	]
}.plot(0.1);
)
