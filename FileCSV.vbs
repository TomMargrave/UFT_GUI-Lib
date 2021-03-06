

'**********************************************************************
' Function Name: getFileLineContains
' Purpose: Returns the first line that contains string provided from input
'   parameters
' Author: Tom Margrave at QualiTest Group
' Input: sFilePath String containing path to CSV file to be read
'        sContains  String value to search for in line.
' Return: Returns string of the line containing search value.  If
'          not found then returns <NOT_FOUND>
' Prerequisites:
' Location: https://github.com/TomMargrave/UFT_GUI-Lib
'**********************************************************************
Function getFileLineContains(sFilePath, sContains)
	ForReading = 1
    Set fso=CreateObject("Scripting.FileSystemObject")
    
    'check to see if file exist
    If NOT(fso.FileExists(sFilePath)) Then
    	getFileLineContains = "<FILE_DOES_NOT_EXIST>"
    	Exit Function
    End If
    
    Set inputFile = fso.OpenTextFile(sFilePath, ForReading)
    'Set var to see if found.
    check = 0
    ' Read each line until line found or EOF
    Do while not inputFile.AtEndOfLine

        ' Retrieve line from file
        getFileLineContains = inputFile.ReadLine

        'Check to see if sContains is in line read.'
        if instr(getFileLineContains, sContains)>0 then
            check = 1
            Exit do
        end if
    Loop
	
	'Mark output if string not found
    if check = 0 then
        getFileLineContains = "<NOT_FOUND>"
    end if
    
    'Close file and objects'
    inputFile.Close
    Set inputFile = nothing
    Set fso = nothing
End Function


'**********************************************************************
' Function Name: getFileLineContainsByColumn
' Purpose: Returns the first line that contains string provided from input
'   parameters which is in Column
' Author: Tom Margrave at QualiTest Group
' Input: sFilePath String containing path to CSV file to be read
'        sContains  String value to search for in line.
' Return: Returns string of the line containing search value.  If
'          not found then returns <NOT_FOUND>
' Prerequisites:
' Location: https://github.com/TomMargrave/UFT_GUI-Lib
'**********************************************************************
Function getFileLineContainsByColumn(sFilePath, sContains, iColumn)
	ForReading = 1
    Set fso=CreateObject("Scripting.FileSystemObject")
        
    'check to see if file exist
    If NOT(fso.FileExists(sFilePath)) Then
    	getFileLineContains = "<FILE_DOES_NOT_EXIST>"
    	Exit Function
    End If
    
    Set inputFile = fso.OpenTextFile(sFilePath, ForReading)

    'Set var to see if found.
    check = 0

    ' Read each line until line found or EOF
    Do while not inputFile.AtEndOfLine

        ' Retrieve line from file
        aLine = split( inputFile.ReadLine, ",")
        
        'Check to see if array is too small
        If Ubound(aLine) >= iColumn Then
        	sValue = aLine(iColumn)
        	
                'Check to see if sContains is in column read.'
        	If instr(sValue, sContains) > 0 then
        	    check = 1
        	    getFileLineContainsByColumn = sValue
        	    Exit do
        	end if
        End If
    Loop
	
	'Mark output if string not found
    if check = 0 then
        getFileLineContainsByColumn = "<NOT_FOUND>"
    end if
    
	'Close file and objects'
    inputFile.Close
    Set inputFile = nothing
    Set fso = nothing
End Function



'**********************************************************************
' Function Name: getFileLineByRC
' Purpose: Returns the Row and column from input parameters from CSV file
' Author: Tom Margrave at QualiTest Group
' Input: sFilePath String containing path to CSV file to be read
'        iRow  The line of the file to recover
'		 iColumn  The column of the line 
' Return: Returns string value of the  Row and Column. If
'          not found then returns <NOT_FOUND>
' Prerequisites:
' Location: https://github.com/TomMargrave/UFT_GUI-Lib
'**********************************************************************
Function getFileLineByRC(sFilePath, iRow, iColumn)
	ForReading = 1
    Set fso=CreateObject("Scripting.FileSystemObject")
        
    'check to see if file exist
    If NOT(fso.FileExists(sFilePath)) Then
    	getFileLineByRC = "<FILE_DOES_NOT_EXIST>"
    	Exit Function
    End If
    
    Set inputFile = fso.OpenTextFile(sFilePath, ForReading)

    'Set var to see if found.
    check = 0
    cnt = 0

    ' Read each line until line found or EOF
    Do while not inputFile.AtEndOfLine
    	
    	sLine = inputFile.ReadLine
    	
    	If cnt = iRow Then
    		print "Found row"
	        ' Retrieve line from file
	        aLine = split( sLine, ",")
	        
	        'Check to see if array is too small
	        If Ubound(aLine) >= iColumn Then
	        	print " found column"
	        	sValue = aLine(iColumn)
	        	check = 1
	        	getFileLineByRC = sValue
	        	Exit do
	        End If
        End If
        cnt = cnt +1
    Loop
	
	'Mark output if string not found
    if check = 0 then
        getFileLineByRC = "<NOT_FOUND>"
    end if
    
	'Close file and objects'
    inputFile.Close
    Set inputFile = nothing
    Set fso = nothing
End Function
