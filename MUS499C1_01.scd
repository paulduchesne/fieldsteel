
// Week 1: Beginning Coding with SuperCollider – MUS 499C Fall 2020
// https://www.youtube.com/watch?v=QyAsr4FSJKs

// shift + ctrl + p wipes out post window.

// shift + ctrl + d brings up document search.

// object-oriented so everything is an object, and inherits traits from superclasses.
// classes, abstract representations: integers, floats, booleans.

// example of integer
4
-27

// floats
0.027
4.0

// characters
$p
$2

// strings
"hello paul"
"here is some text"

// arrays, can contain any type/class
[1, 3, 29, 7.5, $f, "some text"]

// symbols
\some_symbol
'can_also_use_single_quotes'

// boolean
true
false

// functions
{8+8}

// note that many of the above are literals - an integer 8 is self-evident.

// window is class, we are instantiating a new individual (or instance) based on the model of the class and assigning to a variable.
w = Window.new;

// now apply a method to the individual.
w.front;

// methods are passed to classes, generally receiver.method;
// alternate syntax is method(receiver);

5.squared;
squared(5);

// executing code, shift + enter on selected line.

// use class method to find class of object.

4.class; // Integer
"hello again".class; // String
'hello again'.class; // Symbol
true.class; // True

// basic math functions.

2 + 2;
10 - 17;
26 / 278;
167 * 245;

// rounding

6.785.round; // 7.0

// adding arguments to methods in both syntax.

6.785.pow(4); // 2119.33...
pow(6.785, 4); // 2119.33...

-200.abs; // 200
abs(-200); // 200

// div mod, good for sequencers.

430.div(100); // 4
430.mod(100); // 30

// string methods.

"hello paul".size; // 10
"hello paul".reverse; // luap olleh
"hello paul".scramble; // ohlula pel
"hello" ++ " " ++ "paul" // hello paul

// methods are defined by class, can mean different things in for different classes.

// local variables can be defined via var, but are limited to a single evaluation.
// can select multiple lines and shift + enter to run chunk of code

var value;
value = 9;
value = value + 18;
value = value / 2;

// better to evaluate multiple lines within brackets and ctrl + enter.

(
var value;
value = 9;
value = value + 18;
value = value / 2;
)

// variables can be declared with a tilde which are for global variables.
// variable name cannot start with uppercase, numbers etc but anything can follow.
// these also carry across projects, although will be lost on reboot.

~something = "hello";

// single lowercase letters are also global, note "s" is reserved by default for the server.

x = "something";

// comparitive operators, which return boolean results

3 > 2;
3 < 2;
3 >= 2;
3 <= 27;
"hello" == "hello";
"hello" != "paul";

// also && for boolean "AND" and || for "OR".

// use ctrl + d with phrase highlighted to bring up doc.

// using if with boolean logic.
// also postln to post to post window.

(
x = 10.rand.postln;
if(x == 4,
	{"four!"},
	{"not four"}
);
)

// order of operation, or not.
2 + 6 * 3; // 24, always naive left to right

// brackets can be used to force execution.
2 + (6 * 3); // 20

// define a function.
(
~myfunction = {
	var thing;
	thing = 20;
	thing = thing+7
}
)

// value will return function value.
~myfunction.value;


// feeding in arguments to function.
(
~newfunction = {
	arg input;
	var thing;
	thing = 20;
	thing = thing+input;
}
)

// with execution argument.
~newfunction.value(6);

// note that functions always return last line only.
