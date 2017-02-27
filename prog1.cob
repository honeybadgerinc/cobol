        Identification Division.
        Program-Id. prog1.
        Date-Written. 2/2/2016.
        Author. Lucas Henry.
        Date-Compiled.

        Environment Division.
        Input-Output Section.
        File-Control.
                Select Input-File 
                       assign to "/home1/c/a/acsi203/realestate.dat".
                Select Output-File
                       assign to "prog1out.dat"
                       organization is line sequential.

        Data Division.
        File Section.
	FD	Input-File.
	01	Input-Rec.
		02	Adrs		Pic x(27).
		02	City		Pic x(15).
		02	Zip		Pic x(5).
		02	State		Pic x(2).
                02      Bedrooms        Pic x(1).		
                02	Bathrooms       Pic x(1).
                02      Square-Feet     Pic x(4).
		02	Property-Type	Pic x(8).
		02	Sale-Day	Pic x(3).
		02	Filler		Pic x.
		02	Sale-Month	Pic x(3).
		02	Filler		Pic x(17).
		02	Sale-Year	Pic 9(4).
                02      Sale-Price      Pic x(6).
		02	Filler		Pic x(17).
		02 	Filler		Pic x.

	FD	Output-File.
	01	Output-Rec		Pic x(132).


	Working-Storage Section.

	01	Eof-Flag		Pic xxx value "No".

	01	Report-Counter.
		02 Filler		Pic x(49) value spaces.
		02 Filler		Pic x(29) value
		    "Number of Records Processed: ".
		02 counter		Pic 9(4) value 0.
                02 Filler               Pic x(50) value spaces.
	
	01	Report-Header.
		02 Filler		Pic x(48) value spaces.
		02 Filler		Pic x(35) value
		    "California Real Estate Transactions".
                02 Filler               Pic x(49) value spaces.
	
	01	Report-Footer.
		02 Filler		Pic x(59) value spaces.	
		02 Filler		Pic x(13) value
		    	"End of Report".
		02 Filler		Pic x(60) value spaces.

	01	Column-headers.
		02 Filler		Pic x(7) value "Address".
		02 Filler		Pic x(20) value spaces.
		02 Filler		Pic x(4) value "City".
		02 Filler		Pic x(14) value spaces.
		02 Filler		Pic x(3) value "Zip".
		02 Filler		Pic x(5) value spaces.
		02 Filler		Pic x(5) value "State".
		02 Filler		Pic x(3) value spaces.
		02 Filler		Pic x(4) value "Beds".
		02 Filler		Pic x(2) value spaces.
		02 Filler		Pic x(4) value "Bath".
		02 Filler		Pic x(3) value spaces.
		02 Filler		Pic x(4) value "Sqft".
		02 Filler		Pic x(5) value spaces.
		02 Filler		Pic x(9) value "Prop-Type".
		02 Filler		Pic x(4) value spaces.
		02 Filler		Pic x(2) value "SD".
		02 Filler		Pic x(6) value spaces.
		02 Filler		Pic x(2) value "SM".
		02 Filler		Pic x(6) value spaces.
		02 Filler		Pic x(2) value "SY".
		02 Filler		Pic x(7) value spaces.
		02 Filler		Pic x(2) value "SP".

	01	Info-Line.
		02 Adrs-Out	        Pic x(27).
		02 City-Out		Pic x(15).
		02 Filler		Pic x(3) value spaces.
		02 Zip-Out		Pic x(5).
		02 Filler		Pic x(5) value spaces.
		02 State-Out		Pic x(2).
		02 Filler		Pic x(5) value spaces.
                02 Bedrooms-Out        	Pic x(1).
		02 Filler		Pic x(5) value spaces.
                02 Bathrooms-Out       	Pic x(1).
		02 Filler		Pic x(5) value spaces.
                02 Square-Feet-Out     	Pic x(4).
		02 Filler		Pic x(5) value spaces.
		02 Property-Type-Out	Pic x(8).
		02 Filler		Pic x(5) value spaces.
		02 Sale-Day-Out		Pic x(3).
		02 Filler		Pic x(5) value spaces.
		02 Sale-Month-Out	Pic x(3).
		02 Filler		Pic x(5) value spaces.
		02 Sale-Year-Out	Pic 9(4).
                02 Filler		Pic x(5) value spaces.
		02 Sale-Price-Out      	Pic x(6).		
                02 Filler          	Pic x(5).

	Procedure Division.
      * Executes 'Init', 'Main-Loop', and 'Finish', in that order
	0000-Main-Logic.
		Perform 1000-Init.
		Perform 1200-Main-Loop until Eof-Flag = "Yes".
		Perform 1300-Finish.
		Stop Run.

	1000-Init.
      * opens input-file and output-file, writes report header
      * writes line of spaces, then writes column headers
      * and writes the first output-rec
		Open Input Input-File 
                     output Output-File.
		Move Report-Header to Output-Rec.
		Write Output-Rec from Report-Header.
		Move spaces to Output-Rec.
		Write Output-Rec.
		Write Output-Rec from Column-headers.
		Move spaces to Output-Rec.
		Write Output-Rec.
		Read Input-File at end move "Yes" to Eof-Flag.

	1200-Main-Loop.
      * moves data from file section to working storage
		Move Adrs to Adrs-Out.
		Move City to City-Out.
		Move Zip to Zip-Out.
		Move State to State-Out.
		Move Bedrooms to Bedrooms-Out.
		Move Bathrooms to Bathrooms-Out.
		Move Square-Feet to Square-Feet-Out.
                Move Property-Type to Property-Type-Out.
		Move Sale-Day to Sale-Day-Out.
                Move Sale-Month to Sale-Month-Out.
                Move Sale-Year to Sale-Year-Out.
		Move Sale-Price to Sale-Price-Out.
		Add 1 to counter.
		Write Output-Rec from Info-Line.
		Read Input-File at end move "Yes" to Eof-flag.
      * writes a line of spaces before writing the footer
      * closes input and output files
	1300-Finish.
		Move spaces to Output-Rec.
		Write Output-Rec.
		Write Output-Rec from Report-Footer.
		Write Output-Rec from Report-Counter.
		Close Input-File Output-File.

