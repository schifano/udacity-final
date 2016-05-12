//: Playground - noun: a place where people can play

import UIKit

// assign to var or constant
let f = {(x:Int) -> Int
    in
    return x + 42}

// Int -> Int : Takes one int and returns an int

f(9)
f(76)

// Closures in an array (or a dictionary, or a set, etc)
//let closures = [f]

let closures = [f,
    {(x:Int) -> Int in return x * 2},
    {x in return x - 8},
    {x in x * x}, // No return, when closer has one statement, the return is implicit
    {$0 * 42}] // can access position of parameter, $0 (first param * 42)

for fn in closures {
    fn(42)
}

/* Exercise:
    Create an array with two closures, one that takes two integers and returns the sum as another int
    Take two floats and return the sum as a float
*/

let a = {(x:Int, y:Int) -> Int
    in
    return x + y}

let b = {(x:Float, y:Float) -> Float
    in
    return x + y}

// let abClosures = [a,b] : Will not compile because of the different types

// Functions and Closures are the exact same thing, different syntax




