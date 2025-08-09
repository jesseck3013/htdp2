;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise426) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))

; [List-of 1String] N -> [List-of String]
; (bundle s n)

; 1. What is a trivially solvable problem?

; - s is '()

; 2. How are trivial problems solved?

; - since s is '(), there is nothing to be bundled, the result is still '().

;3. How does the algorithm generate new problems that are more easily solvable than the original one? Is there one new problem that we generate or are there several?

; - pick the first n items from s
; - drop the first n items from s

;4. Is the solution of the given problem the same as the solution of (one of) the new problems? Or, do we need to combine the solutions to create a solution for the original problem? And, if so, do we need anything from the original problem data?

; - all the solutions to the sub-problems should be put in a list.

;-------------------------------------------------------------

; quick-sort<

; 1. What is a trivially solvable problem?

; - alon is '()
; - (= (length alon) 1)

; 2. How are trivial problems solved?

; when alon is '() or only has 1 element, alon is sorted. The result is alon itself.

;3. How does the algorithm generate new problems that are more easily solvable than the original one? Is there one new problem that we generate or are there several?

; - pick a pivot
; - put all numbers smaller than the pivot in a list
; - put all numbers bigger than the pivot in a list
; - recursively call the quick sort on the two newly generated lists.
; - combine the results of all sub-problems.
