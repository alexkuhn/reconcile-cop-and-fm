
#A.STRUCTURE

- ’framework’: code of the framework.
- ‘application’: code of the ERS application.


#B. HOW TO RUN

Use the following command at the current directory, to run the ERS application:

	$ ruby application/main.rb

#C. KNOWN ISSUES

1. Unresolved bug at the 2nd step of the scenario.
	=> Infinite loop in the Activatable Petri Net.
	=> Due to implementation, NOT the model.