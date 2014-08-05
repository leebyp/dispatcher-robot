Robot Traffic Problem
======

The prerequisite for this problem is detailed in the assignment.doc.
At the start of the problem, the program reads a list of tube station information from a file and the dispatcher reads instructions to give each robot. On separate threads, the dispatcher sends jobs to each robot, 10 at a time. For each job, the robot logs traffic information if it is < 350m away from a tube station. Once the time for a job passes 0810, the robots automatically shuts down.
Ruby is used here for its multithreading capabilities.

Quick start
------

To run the tests bundled into this directory:

1. Install ruby if not already, and run
  ```
  ruby index.rb
  ```

2. The output from the program will be logged into the console.