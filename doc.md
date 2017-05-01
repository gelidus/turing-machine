# FLP - Turing Machine

Author: Peter Malina

## Introduction
The goal of this project was to implement non-deterministic Turing machine,
which will be able to parse input consisting of rules and an input tape,
outputing each configuration of the machine until the turing machine stops
on the final state.

## Implementation
The project is implemented using swi-prolog and uses `make` for orchestration.
The application first loads given rules and tape from `stdin`. Rules are then
constructed as a Prolog facts. These facts are then iterated using function
`run(Tape)`. 

## Experiments

## Conclusion