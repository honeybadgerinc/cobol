	Identification Division.
        Program-Id. prog5.
        Date-Written. 4/4/17.
        Author. Lucas Henry.
        Date-Compiled. 4/13/17.

        Environment Division.

        Input-Output Section.
        File-Control.

                Select Real-Estate-File 
                       assign to "/home1/c/a/acsi203/realestate.dat".
		Select cityRatesFile
                       assign to "/home1/c/a/acsi203/cityrates.dat"
		       organization is line sequential.
                Select outputFile
                       assign to "prog5out.dat"
                       organization is line sequential.
		Select errorFile
			assign to "error5out.dat"
			organization is line sequential.

        Data Division.

        File Section.
	FD	cityRatesFile.
	01	cityRatesInput.
		02 cityName		Pic x(15).
		02 multiplierRate	Pic v999.

	FD	Real-Estate-File.
	01	Input-Rec.
		02 Adrs			Pic x(27).
		02 City			Pic x(15).
		02 Zip			Pic x(5).
		02 State		Pic x(2).
		88 bad-state values "CA".
                02 Bedrooms        	Pic 9(1).
                02 Bathrooms       	Pic 9(1).
                02 Square-Feet     	Pic 9(4).
		02 Property-Type	Pic x(8).
		88 bad-prop values "Resident" "Condo" "Multi-Fa".
		02 Sale-Day		Pic x(3).
		02 Filler		Pic x(1).
		02 Sale-Month		Pic x(3).
		02 Filler		Pic x(1).
		02 dayOfWeek		Pic 9(2).
		02 Filler		Pic x(1).
		02 Sale-hour		Pic 9(2).
		02 Filler		Pic x(1).
		02 Sale-minute		Pic 9(2).
		02 Filler		Pic x(1).
		02 Sale-second		Pic 9(2).
		02 Filler		Pic x(5).
		02 Sale-Year		Pic 9(4).
               	02 Sale-Price      	Pic 9(6).
		02 Latitude		Pic 9(6)v99.
		02 Longitude		Pic 9(7)v99.
		02 Filler		Pic x.

	FD	errorFile.
	01	Error-Rec		Pic x(114).

	FD	outputFile
		Linage is 58 lines with footing at 56
		lines at top 5
		lines at bottom 5.
	01	Output-Rec		Pic x(132).


	Working-Storage Section.

	77	row-index		Pic 9 value zero.
	77	column-index		Pic 9 value zero.

	01	BaBBathsHeader.
		02 filler		Pic x(7) value spaces.
		02 filler		Pic x(5) value "Baths".
		02 filler		Pic x(5) value spaces.
		02 filler		Pic x(1) value "1".
		02 filler		Pic x(19) value spaces.
		02 filler		Pic x(1) value "2".
		02 filler		Pic x(19) value spaces.
		02 filler		Pic x(1) value "3".
		02 filler		Pic x(19) value spaces.
		02 filler		Pic x(1) value "4".
		02 filler		Pic x(19) value spaces.
		02 filler		Pic x(1) value "5".
		

	01	BaBBedsHeader		Pic x(6) value "Bedrms".
		

	01	BaBSaleAccum		Pic 9(14).

	01	bedAndBathTableOut.
		03 filler		Pic x(6) value spaces.
		02 row-index-out	Pic 9 value zero.
		02 BaB-price-out occurs 6 times.
			03 filler		Pic x(2) value spaces.	
			03 BaB-total-out	Pic $zzz,zzz,zz9.99.
			03 filler		Pic x(3) value spaces.	

	01	Bed-and-bath-table.
		02 BaB-beds occurs 6 times.
		   03 BaB-baths occurs 5 times
	             Pic 9(14)V99 value 0.
	
	01      WS-EOF 			PIC A(1).

	01	City-Rates-Table.
		02 City-Rates-Data occurs 22 times
			Ascending Key is City-Code 
			INDEXED BY city-index.
		03 City-Code		Pic x(15).
		03 Exp-City-Code	Pic v999.

	01	Beds-and-sale-price.
		02 Beds-per-sale-price	Pic x(5).
		02 filler		Pic x(7) value spaces.
		02 Sale-price-per-beds  Pic $zzz,zzz,zz9.99.

	01	Price-per-bedrooms-headers.
		02 filler		Pic x(8) value "Bedrooms".
		02 filler		Pic x(5) value spaces.
		02 filler		Pic x(10) value "Sale accum".

	01	Bedroom-index		Pic 9(1) value zero.

	01	Sale-table.
		02 sale-prices occurs 7 times Pic 9(12) value zero.

	01	Bedroom-data.
		02 filler		Pic x(5) value "Zero ".
		02 filler		Pic x(5) value "One  ".
		02 filler		Pic x(5) value "Two  ".
		02 filler		Pic x(5) value "Three".
		02 filler		Pic x(5) value "Four ".
		02 filler		Pic x(5) value "Five ".
		02 filler		Pic x(5) value "Six  ".
		
	01	Bedroom-table redefines Bedroom-data.
		02 beds occurs 7 times Pic x(5).

	01	Line-spaces		Pic x(132) value spaces.

	01	Page-number-line.
		02 filler		Pic x(64) value spaces.
		02 filler		Pic x value "-".
		02 Page-number		Pic 99 value 1.
		02 filler		Pic x value "-".
		02 filler		Pic x(64) value spaces.		

	01	Eop-Flag		Pic x(3) value "no".
		88 eop-reached value "yes".

	01	Eof-Flag		Pic x(3) value "no".
		88 end-reached value "yes".

	01	Invalid-flag		Pic x(3) value "no".
		88 bad-record value "yes".

	01	Average-line.
		02 Filler		Pic x(16) value 
			"Average Values:".
		02 Filler		Pic x(36) value spaces.
		02 Bed-accum-out	Pic Z9.9.
		02 Filler		Pic x(2) value spaces.
		02 Bath-accum-out	Pic Z9.9.
		02 Filler		Pic x(1) value spaces.
		02 SqFt-accum-out	Pic ZZZ9.9.
		02 Filler		Pic x(33) value spaces.
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
	
	01	Report-Header.
		02 Filler		Pic x(54) value spaces.
		02 Filler		Pic x(37) value
		    "California Real Estate Transactions -".
		02 Filler		Pic x(1) value spaces.
		02 Date-line		Pic x(10).
	
	01 Todays-Date.
		02 Todays-year		Pic 9999.
		02 Todays-month		Pic 99.
		02 Todays-day		Pic 99.
	
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
		02 Filler		Pic x(2) value "Bd".
		02 Filler		Pic x(5) value spaces.
		02 Filler		Pic x(2) value "Bt".
		02 Filler		Pic x(1) value spaces.
		02 Filler		Pic x(4) value "Sqft".
		02 Filler		Pic x(1) value spaces.
		02 Filler		Pic x(8) value "PropType".
		02 Filler		Pic x(1) value spaces.
		02 Filler		Pic x(2) value "SD".
		02 Filler		Pic x(2) value spaces.
		02 Filler		Pic x(3) value "Mth".
		02 Filler		Pic x(1) value spaces.
		02 Filler		Pic x(2) value "DW".
		02 Filler		Pic x(1) value spaces.
		02 Filler		Pic x(2) value "Hr".
		02 Filler		Pic x(1) value spaces.
		02 Filler		Pic x(2) value "Mn".
		02 Filler		Pic x(1) value spaces.
		02 Filler		Pic x(2) value "Sc".
		02 Filler		Pic x(1) value spaces.
		02 Filler		Pic x(4) value "Year".
		02 Filler		Pic x(1) value spaces.
		02 Filler		Pic x(5) value "Price".
		02 Filler		Pic x(7) value spaces.
		02 Filler		Pic x(6) value "$/SqFt".
		02 Filler		Pic x(2) value spaces.
		02 Filler		Pic x(9) value "Estim-Val".
		

	01	Info-Line.
		02 Adrs-Out		Pic x(27).
		02 Filler		Pic x(1) value spaces.
		02 City-Out		Pic x(15).
		02 Filler		Pic x(1) value spaces.
		02 Zip-Out		Pic x(5).
		02 Filler		Pic x(1) value spaces.
		02 State-Out		Pic x(2).
		02 Filler		Pic x(1) value spaces.
                02 Bedrooms-word       	Pic x(5).
		02 Filler		Pic x(2) value spaces.
                02 Bathrooms-Out       	Pic 9(1).
		02 Filler		Pic x(2) value spaces.
                02 Square-Feet-Out     	Pic 9(4).
		02 Filler		Pic x(1) value spaces.
		02 Property-Type-Out	Pic x(8).
		02 Filler		Pic x(1) value spaces.
		02 Sale-Day-Out		Pic x(3).
		02 Filler		Pic x(1) value spaces.
		02 Sale-Month-Out	Pic x(3).
		02 Filler		Pic x(1) value spaces.
		02 dayOfWeek-Out	Pic 9(2).
		02 Filler		Pic x(1) value spaces.
		02 sale-hour-Out	Pic 9(2).
		02 Filler		Pic x(1) value spaces.
		02 sale-min-Out		Pic 9(2).
		02 Filler		Pic x(1) value spaces.
		02 sale-sec-Out		Pic 9(2).
		02 Filler		Pic x(1) value spaces.
		02 Sale-Year-Out	Pic 9(4).
                02 Filler		Pic x(1) value spaces.
		02 Sale-Price-Out     	Pic $ZZZ,ZZ9.99.
                02 Filler		Pic x(1) value spaces.
		02 Price-p-SqFt-Out	Pic $ZZ9.99.
		02 Filler		Pic x(1) value spaces.
		02 Estimate-value-out	Pic $ZZZ,ZZ9.99.	
		02 Filler		Pic x(1) value spaces.
		02 Latitude-Out		Pic Z9.99.
		02 Filler		Pic x(1) value spaces.
		02 Longitude-Out	Pic Z9.99.

	Procedure Division.

      * Executes 'Init', 'Main-Loop', and 'Finish', in that order
	0000-Main-Logic.

		Perform 1000-Init.

		Perform 1200-Main-Loop until end-reached.

		Perform 1300-Finish.

		Stop Run.

      * opens Real-Estate-File and outputFile, writes report header
      * writes line of spaces, then writes column headers
      * and writes the first output-rec
	1000-Init.

		
		Open Input Real-Estate-File
			   cityRatesFile. 
               	Open Output outputFile
		     	   errorFile.

		Move function current-date to Todays-Date.

		String Todays-month '/' Todays-day '/' Todays-year
			Delimited by Size into Date-line
		End-String.

		Move Report-Header to Output-Rec.

		Write Output-Rec from Report-Header.

		Move spaces to Output-Rec.

		Write Output-Rec.

		Write Output-Rec from Column-headers.

		Move spaces to Output-Rec.

		Write Output-Rec.

		Read Real-Estate-File at end move "yes" to Eof-Flag.

		Perform 1066-Read-City-Data
		varying city-index from 1 by 1 until city-index > 22.
		
      * reads the cityrates.dat file into a one-dimensional table
	1066-Read-City-Data.

	Read cityRatesFile into 
			City-Rates-Data(city-index).

      * performs 2100-Validation, and if the record is bad, 2999-Error is performed; else, 2200-Process is performed
	1200-Main-Loop.
	
	Perform 2100-Validation.

	If bad-record
		Perform 2999-Error
	Else 
		Perform 2200-Process.

	
	Read Real-Estate-File at end move "yes" to Eof-Flag.


      * checks validity of state, property-type, bedrooms, bathrooms, square-feet, and sale price data
	2100-Validation.

		If not bad-state or not bad-prop or Bedrooms not
		numeric or Bathrooms not numeric or Square-Feet not 
		numeric or Sale-Price not numeric then

		Move "yes" to Invalid-flag.

      * writes error record line-by-line with the data on one line, and the associated error message beneath it
	2999-Error.

		Write Error-Rec from Input-Rec.

		If not bad-state 

			Move "invalid state data" to Error-Rec
	
			Write Error-Rec.

		If not bad-prop 

			Move "invalid property-type data" to Error-Rec

			Write Error-Rec.

		If Bedrooms not numeric

			Move "bedrooms not numeric" to Error-Rec

			Write Error-Rec.

		If Bathrooms not numeric

			Move "bathrooms not numeric" to Error-Rec

			Write Error-Rec.

		If Square-Feet not numeric

			Move "square feet not numeric" to Error-Rec

			Write Error-Rec.

		If Sale-Price not numeric then

			Move "sale price not numeric" to Error-Rec

			Write Error-Rec.
		
		Move "no" to Invalid-flag.

      * moves data from file section to working storage
	2200-Process.

		SEARCH ALL City-Rates-Data
		when City-Code(city-index)
		= City

		Compute BaBSaleAccum = 
		Sale-Price * (1 + Exp-City-Code(city-index)).

		Move BaBSaleAccum to Sale-Price-Out.

		If Bedrooms > 0 and Bathrooms > 0

		Add BaBSaleAccum to BaB-baths(Bedrooms, Bathrooms)

		End-if.

		Move Adrs to Adrs-Out.

		Move City to City-Out.

		Move Zip to Zip-Out.

		Move State to State-Out.
		
		Move Bathrooms to Bathrooms-Out.

		Move Square-Feet to Square-Feet-Out.

               	Move Property-Type to Property-Type-Out.

		Move Sale-Day to Sale-Day-Out.

                Move Sale-Month to Sale-Month-Out.

                Move Sale-Year to Sale-Year-Out.
		
		Move dayOfWeek to dayOfWeek-Out.

		Move Sale-hour to sale-hour-Out.

		Move Sale-minute to sale-min-out.

		Move Sale-second to sale-sec-Out.

		Add 1 to report-accum.

		Compute Bedroom-index = Bedrooms + 1.

		Move beds(Bedroom-index) to Bedrooms-word.

		if Bedrooms > 0

			Add BaBSaleAccum to sale-prices(Bedrooms).
		
		IF Square-Feet > 0 THEN
			Add Square-Feet to SqFt-accum
			Add 1 to Nonzero-counter
			Divide BaBSaleAccum into Sale-Price GIVING 
				Price-p-SqFt-Out
			Add Bathrooms to Bath-accum
			Add Bedrooms to Bed-accum
			Add BaBSaleAccum to Sale-accum
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


	Write Output-Rec from Info-Line
	at EOP perform 1999-Page-End.
		

      * writes a line of spaces before writing the footer
      * closes input and output files
	1300-Finish.

		Move spaces to Output-Rec.

		Write Output-Rec.

		Move spaces to Output-Rec.

		Write Output-Rec.

		Divide Nonzero-counter into Bed-accum.

		Divide Nonzero-counter into Bath-accum

		Divide Nonzero-counter into SqFt-accum.

		Divide Nonzero-counter into Sale-accum.
		
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
		
		Perform 3001-Blank-line until Eop-Flag = "yes".

		Write Output-Rec from Page-number-line.

		If Eof-Flag = "yes"

		    Write Output-Rec from Price-per-bedrooms-headers
		    after advancing page.

		Perform 3002-Final-Loop varying Bedroom-index
		from 1 by 1 until Bedroom-index > 6.		

		Perform 3001-Blank-line until Eop-Flag = "yes".
		Add 1 to Page-number.

		Write Output-Rec from Page-number-line.

		Write Output-Rec from BaBBathsHeader
		    after advancing page.

		Write Output-Rec from BaBBedsHeader.

		Perform 3003-Baths-and-beds-table-loop
		   varying row-index from 1 by 1 until 
		row-index > 6.

		Move "no" to Eop-Flag.

		Perform 3001-Blank-line until Eop-Flag = "yes".

		Add 1 to Page-number.
			
		Perform 3001-Blank-line until Eop-Flag = "yes".

		Write Output-Rec from Page-number-line.
		
		Close Real-Estate-File outputFile errorFile 
		cityRatesFile.

      * moves each value of the table on page 7 to the table that actually gets printed
	3301-Print-BaB-row.
	
		Move BaB-baths(row-index, column-index) to 
		BaB-total-out(column-index).

      * paragraph that actually writes the table to the Output-Rec
	3003-Baths-and-beds-table-loop.
		
		Move row-index to row-index-out.

		Perform 3301-Print-BaB-row varying column-index from 1
		   by 1 until column-index > 5.

		Write Output-Rec from bedAndBathTableOut.

      * prints blank lines until the end of each page
	3001-Blank-line.

		Write Output-Rec from Line-spaces
		at eop move "yes" to Eop-Flag.

      * writes each page number line and column headers
	1999-Page-End.
		
		Write Output-Rec from Page-number-line after
		advancing 2 lines.
	
		Write Output-Rec from Column-headers after
		advancing page.

		Add 1 to Page-number.

      * creates table on page 6, which has the total prices for each number of bathrooms
	3002-Final-Loop.

		Move "no" to Eop-Flag.

		Move beds(Bedroom-index + 1) to Beds-per-sale-price.

		Move sale-prices(Bedroom-index) to 
		Sale-price-per-beds.

		Write Output-Rec from Beds-and-sale-price.

