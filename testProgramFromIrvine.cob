	Identification Division.
	Program-Id. First-One.
	Date-Written. 01/05/2014.
	Date-Compiled.

	Environment Division.
	Input-Output Section.
	File-Control.
		Select Input-File 
                       assign to "/home1/c/a/acsi203/company.dat".
		Select Output-File 
                       assign to "prog1.out"
                       organization is line sequential.

	Data Division.
	File Section.
	FD	Input-File.
	01	Input-Rec.
		02	Last-Name	Pic X(10).
		02	First-Name	Pic x(20).
		02	Filler		Pic x(57).
		02	Hired		Pic x(10).
                02      SSN             Pic 9(7).		
                02	Mar-Stat        Pic X.
                02      Emp-Stat        Pic x.
		02	Salary          Pic 99v99.
                02      Filler          Pic X.

	FD	Output-File.
	01	Output-Rec		Pic x(132).


	Working-Storage Section.
	01	Eof-Flag		Pic xxx value "No".
	
	01	Report-Header.
		02 Filler		Pic x(59) value spaces.
		02 Filler		Pic x(14) value
			"Payroll Report".
                02 Filler               Pic x(59) value spaces.

	01	Info-Line.
		02 Last-Name-Out	Pic x(10).
		02 Filler		Pic x(5) value spaces.
		02 First-Name-Out	Pic x(10).
		02 Filler		Pic x(5) value spaces.
		02 Salary-Out		Pic 99.99.
                02 Filler               Pic x(97).

	Procedure Division.
	0000-Main-Logic.
		Perform 1000-Init.
		Perform 1200-Main-Loop until Eof-Flag = "Yes".
		Perform 1300-Finish.
		Stop Run.

	1000-Init.
		Open Input Input-File 
                     output Output-File.
		Write Output-Rec from Report-Header.
		Read Input-File at end move "Yes" to Eof-Flag.

	1200-Main-Loop.
		  Move Last-Name to Last-Name-Out.
		  Move First-Name to First-Name-Out.
		  Move Salary to Salary-Out.
		  Write Output-Rec from Info-Line.
		  Read Input-File at end move "Yes" to eof-flag.

	1300-Finish.
		Close Output-File Input-File.

