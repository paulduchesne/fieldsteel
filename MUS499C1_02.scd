
// Week 2: Beginning Coding with SuperCollider – MUS 499C Fall 2020
// https://www.youtube.com/watch?v=j4ykr2-yv-o

// Supercollider is made of
// sclang - programming language and interpreter,
// scsynth - server which takes lang and creates audio signal,
// scide - which is the dev env.

// boot audio server
s.boot;

// quit
s.quit;

// legacy qui server widget
s.makeWindow;

// audio input/output meters
s.meter;

// waveform scope
s.scope;

// frequency scope
FreqScope.new;

// node tree of running synths
s.plotTree;

// basic sound function using SinOsc ugen
{ Saw.ar }.play;

// SinOsc is a class, which we need to send a method - ar, kr, ir.
// ar plays at audio rate, kr is control rate, ir runs once.

// free a synth to remove individual voices, by assigning to a variable first.
~sign = { SinOsc.ar }.play;
~sign.free;

// an array of ugens mapped to separate outputs.
{ [ SinOsc.ar, Saw.ar ] }.play;

// array shortcut
5.dup(7);

// ! shortcut
5!7;

// applied to audio
{ Saw.ar!2 }.play;

// arguments for ugen, there are defaults provided (freq 440).
{ SinOsc.ar(200, 0, 1, 0) }.play;

// can also specify arguments by name.
{ SinOsc.ar(freq:600, mul:1) }.play;

// plot ugen
{ SinOsc.ar(200) }.plot(0.02);

// function joining ugens.

(
~thing = {
	var sig;
	sig = SinOsc.ar(400, mul:0.2);
	sig = sig + SinOsc.ar(300, mul:0.3)
}.play;
)

// basic vibrato
// freq of control sinosc is duration, mul is variation and add provides centre.

(
~thing = {
	var sig, vib;
	vib = SinOsc.ar(freq:2, mul:40, add:350);
	sig = SinOsc.ar(vib, mul:0.2)!2;
}.play;
)

// rather than trying to figure out mul and add, use range method to map 0 - 1 to a - b.

(
~thing = {
	var sig, vib;
	vib = SinOsc.ar(freq:2).range(310, 390);
	sig = SinOsc.ar(vib, mul:0.2)!2;
}.play;
)

// alarm

(
~thing = {
	var sig, mod;
	mod = LFSaw.ar(1).range(0, 500);
	sig = Pulse.ar(200 + mod, 0.5, 0.1, 0)!2;
}.play;
)

// can also multiple signal rather using mul

(
~thing = {
	var sig, mod;
	mod = LFSaw.ar(1).range(0, 500);
	sig = Pulse.ar(200 + mod)!2;
	sig = sig * 0.1
}.play;
)

// multichannel expansion, argument in array automatically expands

{ SinOsc.ar( [250, 251], 0, 0.5, 0) }.play

