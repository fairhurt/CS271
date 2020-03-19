

; Author:Tyson Fairhurst
; Course / Project ID    CS 271  Homework 3           Date:2/26/2020
; Description: This program will prompt the user to choose integer or floating point arthmetic, input 5 numbers and display the sum and average for them. It will loop until the user wants to quit.
INCLUDE Irvine32.inc

UPPER=1; upper bound of user input
LOWER=0; lower bound of user input
checkcount=5; the loop structure checks to see if it is equal to this value
floatdiv = 5

.data

	;preliminary data for the program/instructions
	prog_title BYTE "Integer and Floating point Arithmetic", 10 ,0
	myName BYTE "Programmed by Tyson Fairhurst", 10,0
	signoff BYTE "Results certified by Tyson Fairhurst", 10,0
	user_Name BYTE "What is your name?", 10,0
	greet BYTE "Hello, ",0
	instructions BYTE "Press 0 for integer and press 1 for floating point arithmetic", 10,0
	instructions2 BYTE "Do you want to perform another calculation? Please enter 0 for no or 1 for yes", 10, 0
	userInput BYTE "Input should be a 0 or 1", 10,0
	valid BYTE "The input is valid",0
	invalid BYTE "The input is invalid, Please enter a term between 0 and 1",0
	spaces BYTE "    ",0
	answer_1 BYTE "You have chosen Integer",10,0
	int_prompt BYTE "Please enter a Integer: ",0
	float_prompt BYTE "Please enter a floating point number: ",0
	sum_prompt BYTE "The Sum is: ",0
	div_prompt BYTE "The average is: ",0 
	div_float REAL8 5.0

	;variables to hold the users inputs
	var1 DWORD ?
	userName BYTE 10 DUP(0)
	
	
	
	; variables for holding the fibonacci terms
	edx1 DWORD ?

	
	;variables for loops structure
	count DWORD ?
	count2 DWORD ?
	

	;prompts for saying goodbye
	bye BYTE "Goodbye, ",0
	
	

.code
main PROC
	; introduces the program/ programmer
	Introduction:
		
		mov EDX, OFFSET prog_title ; displays title
		call WriteString
				
		mov EDX, OFFSET myName; displays myName
		call WriteString
		
		mov EDX, OFFSET user_Name; displays the instructions
		call WriteString
		mov EDX, OFFSET userName
		mov ECX, 10
		call ReadString
		

		

		mov EDX, OFFSET greet; displays the instructions
		call WriteString
		mov EDX, OFFSET userName
		call WriteString
		call Crlf


			   	
	User_Instructions:
		
		mov EDX, OFFSET instructions; press 0 for int and 1 for floating point
		call WriteString
				
				
	Get_the_data:
	
				
			mov EDX, OFFSET userInput; should be a 0 or 1
			call Writestring
			call Readint
			mov var1, EAX; 
			mov EAX, var1
			cmp EAX, UPPER; if it =1
			je answer1; 
			cmp EAX, LOWER; if it =0
			je answer0
			jmp outofif; 
		

		answer1:
		mov EDX, OFFSET answer_1
		call Writestring
		call get_floatingpoint
			

		answer0:; if the number is 0
			mov EDX, OFFSET valid
			call WriteString
			call crlf
			jmp get_integer; jump to the top of the do while loop
			
		;if the results are valid
		outofif:
			mov EDX, OFFSET invalid	; the result is valid and continues on to get the data from the user
			call WriteString
			call crlf
			call crlf
			jmp Get_the_data

		
		
		;get the integers
	
		get_integer:
			mov ECX,  checkcount	
		push ebp
		mov ebp, esp
		l1:
		mov EDX, OFFSET int_prompt; prompt user for input
		call WriteString
		call ReadInt 
		push eax
		call writedec
		call crlf
		loop l1
		jmp Calculate_integer

		get_floatingpoint:
		mov ecx , checkcount
		finit
		l2:
		mov edx, offset float_prompt
		call writestring
		call readfloat
		call writefloat
		call crlf
		loop l2
		jmp calculate_float
		









		
	Calculate_Sum:

	Calculate_integer:
		mov eax, 0		
		add EAX, DWORD PTR [ebp-4]
		add EAX, DWORD PTR[ebp-8]
		add EAX, DWORD PTR[ebp-12]
		add EAX , DWORD PTR[ebp-16]
		add eax , DWORD PTR[ebp-20]
		jmp Display_Numbers_int_sum

	calculate_float:
		fadd ST(0), ST(1)
		fadd ST(0), ST(2)
		fadd ST(0), ST(3)
		fadd ST(0), ST(4)
		jmp Display_Numbers_float_sum

		
		
	
	Calculate_Average:
		calculate_int_average:
			cdq
			mov ebx, 5
			div ebx
			jmp Display_Numbers_int_div
		calculate_float_average:
			
			fdiv div_float
			jmp display_float_average

	Display_Numbers:
			Display_Numbers_int_sum:
			mov edx, OFFSET sum_prompt
			call writestring
			call writedec
			call crlf
			jmp calculate_int_average

			Display_Numbers_int_div:
			mov edx, OFFSET div_prompt
			call writestring
			
			call writedec
			call crlf
			jmp Choose_Between_Continue_and_Exit

			Display_Numbers_float_sum:
			mov edx, OFFSET sum_prompt
			call writestring
			
			call writefloat
			call crlf
			jmp calculate_float_average

			display_float_average:
			mov edx, OFFSET div_prompt
			call writestring
			
			call writefloat
			call crlf
			jmp Choose_Between_Continue_and_Exit



	Choose_Between_Continue_and_Exit:
	mov EDX, OFFSET instructions2
	call WriteString
			
			mov EDX, OFFSET userInput;get the user input
			call Writestring
			call Readint
			
			mov var1, EAX; 
			mov EAX, var1
			cmp EAX, UPPER; if it equals 1
			je ans1; jump to top of program (reset)
			cmp EAX, LOWER ;if it equals 0
			je ans0
			jmp invalidnum2; esle prompt for valid input
		
		ans1:; if the number is invalid the user will be prompted to reenter a new number
			jmp User_Instructions ; jump to the top of the do while loop
			
		;if the results are valid
		ans0:
			call crlf
			jmp Say_Goodbye
	invalidnum2:
			mov EDX, OFFSET invalid
			call WriteString
			call crlf
			jmp Choose_Between_Continue_and_Exit; jump to the top of the do while loop
	   	  
	Say_Goodbye:
		call crlf
		call crlf
		mov EDX, OFFSET signoff
		call WriteString
		call crlf
		mov EDX, OFFSET bye; displays the goodbye
		call WriteString
		mov EDX, OFFSET userName; displays the users name
		call WriteString
		call Crlf



	exit	; exit to operating system
main ENDP



END main
