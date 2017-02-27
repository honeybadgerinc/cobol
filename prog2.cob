        Identification Division.
        Program-Id. prog2.
        Date-Written. 2/14/2016.
        Author. Lucas Henry.
        Date-Compiled. 2/23/2016.

        Environment Division.

        Input-Output Section.
        File-Control.
                Select Input-File 
                       assign to "/home1/c/a/acsi203/realestate.dat".
                Select Output-File
                       assign to "prog2out.dat"
                       organization is line sequential.

        Data Division.

        File Section.
	FD	Input-File.
	01	Input-Rec.
		02	Adrs		Pic x(27).
		02	City		Pic x(15).
		02	Zip		Pic x(5).
		02	State		Pic x(2).
                02      Bedrooms        Pic 9(1).		
                02	Bathrooms       Pic 9(1).
                02      Square-Feet     Pic 9(4).
		02	Property-Type	Pic x(8).
		02	Sale-Day	Pic x(3).
		02	Filler		Pic x.
		02	Sale-Month	Pic x(3).
		02	Filler		Pic x(17).
		02	Sale-Year	Pic 9(4).
                02      Sale-Price      Pic 9(6).
		02	Filler		Pic x(17).
		02 	Filler		Pic x.

	FD	Output-File.
	01	Output-Rec		Pic x(132).


	Working-Storage Section.

	01	Eof-Flag		Pic xxx value "No".

	01	Average-line.
		02 Filler		Pic x(16) value 
			"Average Values:".
		02 Filler		Pic x(36) value spaces.
		02 Bed-accum-out	Pic Z9.9.
		02 Bath-accum-out	Pic Z9.9.
		02 Filler		Pic x(1) value spaces.
		02 SqFt-accum-out	Pic ZZZ9.9.
		02 Filler		Pic x(25) value spaces.
		02 Sale-accum-out	Pic $$$$,$$9.99.

	01	Nonzero-counter		Pic 9(3) value 0.

	01	SqFt-accum		Pic 9(8)V9 value 0.

	01	Bed-accum		Pic 9(8)V9 value 0.

	01	Bath-accum		Pic 9(8)V9 value 0.

	01	Sale-accum		Pic 9(12)V99 value 0.

	01	report-accum		Pic 9(4) value 0.

	01	Price-p-SqFt		Pic 9(4) value 0.
	
	01	Estimate-value		Pic 9(6)V99 value 0.

	01	Report-Counter.
		02 Filler		Pic x(57) value spaces.
		02 Filler		Pic x(28) value
		    "Number of Records Processed:".
		02 Counter-out		Pic ZZZ9.
                02 Filler               Pic x(58) value spaces.
	
	01	Report-Header.
		02 Filler		Pic x(54) value spaces.
		02 Filler		Pic x(36) value
		    "California Real Estate Transactions ".
                02 Filler               Pic x(54) value spaces.
	
	01	Report-Footer.
		02 Filler		Pic x(65) value spaces.	
		02 Filler		Pic x(13) value
		    	"End of Report".
		02 Filler		Pic x(66) value spaces.

	01	Column-headers.
		02 Filler		Pic x(4) value "Adrs".
		02 Filler		Pic x(24) value spaces.
		02 Filler		Pic x(4) value "City".
		02 Filler		Pic x(12) value spaces.
		02 Filler		Pic x(3) value "Zip".
		02 Filler		Pic x(3) value spaces.
		02 Filler		Pic x(2) value "St".
		02 Filler		Pic x(1) value spaces.
		02 Filler		Pic x(3) value "Bds".
		02 Filler		Pic x(1) value spaces.
		02 Filler		Pic x(3) value "Bts".
		02 Filler		Pic x(1) value spaces.
		02 Filler		Pic x(4) value "Sqft".
		02 Filler		Pic x(1) value spaces.
		02 Filler		Pic x(8) value "PropType".
		02 Filler		Pic x(2) value spaces.
		02 Filler		Pic x(5) value "SaleD".
		02 Filler		Pic x(1) value spaces.
		02 Filler		Pic x(4) value "Mnth".
		02 Filler		Pic x(1) value spaces.
		02 Filler		Pic x(4) value "Year".
		02 Filler		Pic x(1) value spaces.
		02 Filler		Pic x(5) value "Price".
		02 Filler		Pic x(7) value spaces.
		02 Filler		Pic x(13) value "Price/Sq Foot".
		02 Filler		Pic x(1) value spaces.
		02 Filler		Pic x(14) value 
						"Estimate Value".		

	01	Info-Line.
		02 Adrs-Out	        Pic x(27).
		02 Filler		Pic x(1) value spaces.
		02 City-Out		Pic x(15).
		02 Filler		Pic x(1) value spaces.
		02 Zip-Out		Pic x(5).
		02 Filler		Pic x(1) value spaces.
		02 State-Out		Pic x(2).
		02 Filler		Pic x(1) value spaces.
                02 Bedrooms-Out        	Pic 9(1).
		02 Filler		Pic x(3) value spaces.
                02 Bathrooms-Out       	Pic 9(1).
		02 Filler		Pic x(3) value spaces.
                02 Square-Feet-Out     	Pic 9(4).
		02 Filler		Pic x(1) value spaces.
		02 Property-Type-Out	Pic x(8).
		02 Filler		Pic x(2) value spaces.
		02 Sale-Day-Out		Pic x(3).
		02 Filler		Pic x(3) value spaces.
		02 Sale-Month-Out	Pic x(3).
		02 Filler		Pic x(2) value spaces.
		02 Sale-Year-Out	Pic 9(4).
                02 Filler		Pic x(1) value spaces.
		02 Sale-Price-Out      	Pic $ZZZ,ZZ9.99.
                02 Filler		Pic x(1) value spaces.
		02 Price-p-SqFt-Out	Pic $ZZ9.99.
		02 Filler		Pic x(7) value spaces.
		02 Estimate-value-out	Pic $ZZZ,ZZ9.99.	

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
		Add 1 to report-accum.
		
		IF Square-Feet > 0 THEN
			Add Square-Feet to SqFt-accum
			Add 1 to Nonzero-counter
			Divide Square-feet into Sale-Price GIVING 
				Price-p-SqFt-Out
			Add Bathrooms to Bath-accum
			Add Bedrooms to Bed-accum
			Add Sale-Price to Sale-accum
		ELSE
			Move 0 to Price-p-SqFt
			MOVE Price-p-SqFt TO Price-p-SqFt-Out

		END-IF.

		IF City = "SACRAMENTO" OR "RIO LINDA" THEN
			MULTIPLY Sale-Price BY 1.18
				GIVING Estimate-value
			MOVE Estimate-value TO Estimate-value-out

		ELSE
			MULTIPLY Sale-Price BY 1.13 
				GIVING Estimate-value
			MOVE Estimate-value TO Estimate-value-out

		END-IF.

		Write Output-Rec from Info-Line.

		Read Input-File at end move "Yes" to Eof-flag.

      * writes a line of spaces before writing the footer
      * closes input and output files
	1300-Finish.

		Move spaces to Output-Rec.
		Write Output-Rec.

		Divide Nonzero-counter into Bed-accum.

		Divide Nonzero-counter into Bath-accum

		Divide Nonzero-counter into SqFt-accum.

		Divide report-accum into Sale-accum.
		
		Move SqFt-accum to SqFt-accum-out.

		Move Bath-accum to Bath-accum-out.

		Move Bed-accum to Bed-accum-out.

		Move Sale-accum to Sale-accum-out.

		Write Output-rec from Average-line.
		
		Move report-accum to Counter-out.
		Move spaces to Output-Rec.
		Write Output-Rec.
		
		Write Output-Rec from Report-Counter.
		Move spaces to Output-Rec.
		Write Output-Rec.
		Write Output-Rec from Report-Footer.
		Close Input-File Output-File.

