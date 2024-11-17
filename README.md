# LISP English Sentence Parser

This is a simple demo of LISP's power. It's effectively a recursive-descent parser in less than 50 lines of code.
You might say a simple English sentence follows this grammar:
```bnf
sentence ::= [ article ] { adjective } noun verb [ { modifying-adverb } adverb ]
```
with the terminals being members of various lists, defined in the program. The program verifies that a sentence follows
this grammar, and returns either `T` or `NIL` when it accepts or rejects.

### Usage

Load the program in your LISP REPL with the standard command `:load Program3.lsp`, and then use the functions
like so:
```lisp
> (SENTENCE '(THE DOG RUNS))
T
> (SENTENCE '(THE SMALL LIGHT WHITETAIL JUMPS EXTREMELY HIGH))
T
```

---
Completed for Dr. Rainwater's course COSC 5340—Comparative Study of Programming Languages, in the Fall 2024 Semester at UT Tyler.

