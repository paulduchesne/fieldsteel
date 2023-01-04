
// Week 3: Beginning Coding with SuperCollider – MUS 499C Fall 2020
// https://www.youtube.com/watch?v=mM2FLW0neYs

s.boot

// arrays are enclosed in square brackets, and can contain any type.
x = [1, 2.7, true, {2+2}]; // 1, 2.7, true, a Function

// size of array
x.size; //  4

// at pulls an element
x.at(1) // 2.7
x.at(900) // out of range, nil

// at shortcut, same as python
x[1]; // 2.7

// put places element at index
x.put(2, false); // 1, 2.7, false, a Function

// adds to end of array, but not retained.
x.add(6000);

// issue with array having fixed size on creation, so you need to re apply
x = x.add(2700);
x; // 1, 2.7, false, a Function, 2700

// insert adds element at specific point, shifting values along
x = x.insert(2, \heck)

// some array processing methods
x = x.scramble; // scramble array
x = x.reverse; // reverse array
x = x.mirror; // there and back
x = x.sort; // sorts, triggers error because of function
x = x.rotate(2); // wraps around
x.choose; // pick random element

// math can run on arrays, although they do need to be integers/floats
[2, 6, 7, 27]+4; // [ 6, 10, 11, 31 ]

// methods for arrays
[2, 6, 7, 27].odd; // [ false, false, true, true ]

collect, do, select, reject, any

// collect for iteration, return string for each elements.
[1, 2, 3, 4].collect({"hey".postln});

// demonstrate that function fires four individual times.
[1, 2, 3, 4].collect({"hey".scramble.postln});

// make use of array element. Note method is executed before concat.
[1, 2, 3, 4].collect({ arg n; n+"paul".scramble.postln}); // [ 1 ulap, 2 ualp, 3 luap, 4 lupa ]

// define array and run function as separate events.
// note here that collect returns the results of the process.
x = [100, 101, 102, 103];
x.collect({ arg n; n.odd.postln}); // [ false, true, false, true ]

// do behaves the same, except it returns the original values.
// hence it is only used when you actually want to "do" something.
x = [100, 101, 102, 103];
x.do({ arg n; n.odd.postln}); // [ 100, 101, 102, 103 ]

// filter array using select method.
x = [100, 101, 102, 103];
x.select({ arg n; n.odd.postln}); // [ 101, 103 ]

// inverse using reject method.
x = [100, 101, 102, 103];
x.reject({ arg n; n.odd.postln}); // [ 100, 102 ]

// any is true if anything matches query
x = [100, 101, 102, 103];
x.any({ arg n; n.odd.postln}); // true

// basic do structure

(
[10, 30, 60, 90, 300].do({
	arg n;
	n.postln;
});
)

// alt syntax for arg

(
[10, 30, 60, 90, 300].do({
	|n|
	n.postln;
});
)

// pull index as well as array value.

(
[100, 200, 300, 400].do({
	arg x, i;
	[x, i].postln;
});
)

// make a new array, some array creation methods.
x = Array.new(7); // [ ]
x = Array.series(7, 18, 3); // [ 18, 21, 24, 27, 30, 33, 36 ]
x = Array.interpolation(7, 8, 162); // -> [ 8.0, 33.666666666667, 59.333333333333, 85.0, 110.66666666667, 136.33333333333, 162.0 ]
x = Array.fill(7, "hi"); // [ hi, hi, hi, hi, hi, hi, hi ]
x = Array.fill(7, {"something".scramble}); // [ hitsonmeg, otgsehnim, omnesigth, hntgeosmi, oeshmgtni, oihnstgme, oisnehgmt ]

// basic random
10.rand; // 3

// 10.do is shorthand for an array of ten things being processed
10.do({10.rand.postln});

// rrand works off a range of numbers;
rrand(2,27); // 21

// expotential rand
exprand(1, 1000); //25.297233347209

// if you provide floats in you will get floats out
rrand(0.2, 200); // 57.191058087349

// create an array of random numbers
Array.rand(7, 1, 27); // [ 5, 17, 18, 24, 12, 9, 18 ]
Array.rand(4, 1, 27.0); // [ 19.879671573639, 6.4740011692047, 10.646658420563, 10.709400415421 ]
Array.exprand(4, 2, 200); // [ 3.6616476818528, 40.011494260028, 147.28116683241, 13.46444230174 ]

// example of rand firing once vs on every element
Array.fill(8, rrand(7, 100)); // [ 42, 42, 42, 42, 42, 42, 42, 42 ]
Array.fill(8, {rrand(7, 100)}); // [ 90, 19, 68, 26, 12, 63, 41, 18 ]

// shortcut for array creation
(1..7); // [ 1, 2, 3, 4, 5, 6, 7 ]

// combining this theory into some sound generation.

(
x = Array.exprand(8, 200, 2000).round(200); // round snaps frequencies
x = x.sort; // sort numbers
x.do({
	arg n, i;
	var amp = (1/(i+1));
	amp = amp * 0.2;
	{
		var sig;
		sig = SinOsc.ar(n);
		sig = sig * amp;
		sig!2;
	}.play;
});
)

// selective control of each voice - note that the sounds array is now each running synth.

(
~fn = { // a synthdef?
	arg freq = 300;
	var sig;
	sig = SinOsc.ar(freq);
	sig = sig * 0.1;
	sig!2;
};

x = Array.exprand(16, 200, 2000);
~sounds = x.collect({
	arg n, i;
	~fn.play;

});
)

// select array and send a new freq message to each synth voice.

~sounds.do({arg x; x.set(\freq, exprand(200,2000))})
