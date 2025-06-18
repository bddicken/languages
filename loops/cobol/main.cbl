       IDENTIFICATION DIVISION.
       PROGRAM-ID. looopy.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 INPUT-NUMBER              PIC 9(05) VALUE ZERO.
       01 RANDOM-NUMBER             PIC 9(06) VALUE zero.
      * Array of 10k elements initialized to 0
       01 ARRAY                     OCCURS 10000 TIMES INDEXED BY IDX.
           05 ELEMENT               PIC S9(10) COMP VALUE ZERO.
       01 I                         PIC 9(05) VALUE 1.
       01 J                         PIC 9(06) VALUE 1.
       01 MODULO-RESULT             PIC S9(05) COMP.
       01 ELEMENT-RESULT            PIC S9(10) COMP.

       PROCEDURE DIVISION.
       MAIN-PROCESS.
      * Get an input number from the command line
           Accept INPUT-NUMBER from command-line 
      * Get a random number 0 <= r < 10k
           COMPUTE RANDOM-NUMBER = FUNCTION RANDOM * 10000

      * 10k outer loop iterations
           PERFORM VARYING I FROM 1 BY 1 UNTIL I > 10000
      * 100k inner loop iterations, per outer loop iteration
               PERFORM VARYING J FROM 1 BY 1 UNTIL J > 100000
      *  Simple sum
                   ADD function MOD(J, INPUT-NUMBER)
                   TO ELEMENT OF ARRAY (I)
               END-PERFORM
      * Add a random value to each element in array
               ADD RANDOM-NUMBER TO ELEMENT OF ARRAY (I)
           END-PERFORM.

           MOVE ELEMENT OF ARRAY (RANDOM-NUMBER + 1) TO ELEMENT-RESULT
      * Print out a single element from the array
           DISPLAY ELEMENT-RESULT
           STOP RUN.

       END PROGRAM looopy.

