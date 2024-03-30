# RISC-V Assembly Expression Interpreter

## Overview
This project showcases the development of various algorithms in RISC-V assembly, closely mirroring their C implementations. Emphasizing adherence to RISC-V function calling conventions, the project validates computational accuracy across both implementations. The objective was to understand low-level programming nuances and execute predefined as well as custom assembly programs efficiently.

## Main Code
The core logic and functionality of this project are encapsulated in the **`eval_s.s`** file. This assembly script is pivotal, as it contains the main code for evaluating simple arithmetic expressions recursively, demonstrating complex assembly programming techniques and robust problem-solving capabilities.

## Features
- **Functionality Replication:** Developed RISC-V assembly versions of specified problems, ensuring identical output to C implementations.
- **Calling Conventions:** Followed RISC-V function calling conventions for accurate emulation of program logic.
- **Makefile Compilation:** Utilized a Makefile for organized and efficient compilation of assembly programs.

## Implemented Problems
- **String Reversal:** Implemented both iterative (`rstr`) and recursive (`rstr_rec`) string reversal functions.
- **Expression Evaluation:** Developed a recursive evaluator (`eval`) for simple arithmetic expressions.
- **Byte Manipulation:** Created functions for packing (`pack_bytes`) and unpacking (`unpack_bytes`) bytes into and from integers.
- **Bit Sequence Extraction:** Constructed utilities to extract bit sequences as unsigned (`get_bitseq`) and signed (`get_bitseq_signed`) integers.

## Testing and Validation
- Employed autograder tests to ensure functional parity between C and assembly implementations.
- Manual testing conducted to verify correct program execution across various input scenarios.

### Running Tests:
- Tests were performed using an autograder system, alongside manual checks, to confirm the correctness of assembly solutions against their C counterparts.

## Development Process
The development involved translating C program logic into RISC-V assembly, focusing on understanding and applying assembly programming techniques such as stack management, function calls, and register manipulation. Special attention was given to emulating complex logic like recursive expression evaluation and bit manipulation accurately.

## Challenges and Solutions
- **Recursive Logic in Assembly:** Mastering recursion in assembly, particularly for expression evaluation, required a deep dive into stack management and function calling conventions.
- **Bit Manipulation:** Implementing bit sequence extraction posed challenges in accurately shifting and masking bits, resolved through careful planning and testing.

## Conclusion
This project deepened my understanding of RISC-V assembly through practical problem-solving, highlighting the intricacies of translating high-level logic into low-level assembly instructions. It was a comprehensive exercise in applying theoretical knowledge to real-world programming challenges. 

### See main 
