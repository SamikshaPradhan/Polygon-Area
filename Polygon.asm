; Program: Polygon
; Description: Write a program to find the area of any polygon given its vertexes. 
;   Inputs:	The input is the set of polygons. 
;   Outputs:	Label and print the area value for each input.
;   Restrictions:	You are to use one-dimensional array(s) to hold vertex values.
;   You are to use Functions/Procedures in your implementation.  
;   DO NOT repeat code for each polygon, but loop through one set of code
;   for every polygon.
;   Print your output into a file.
;   Consider:	Area = (1/2) E^(N-1)_(i=1) ( (X_(i+1).Y_i) - (X_i.Y_(i+1)) )
;   Repeat the first point in the polygon in setting up the list of points for the above loop.  
;   Loop through the points in a clockwise process form point to point.

INCLUDE Irvine32.inc
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.data
p1		dword	0,0,0,4,8,4,8,0, 0,0, 999	; sentinel value 999 indicating the end of a list
p2		dword	0,0,12,4,12,0, 0,0, 999		; repeat first point
p3		dword	0,0,0,8,9,6,9,-2, 0,0, 999				
p4		dword	0,0,2,4,-2,6,3,6,4,11,5,6,10,6,6,4,7,0,4,3, 0,0, 999
p5		dword	0,0,6,7,16,3,24,7,21,-1,16,1,14,-4,11,-1,4,-2,8,2, 0,0, 999
area		dword	?
diff		dword	?
product	dword	?

NULL EQU 0
CR EQU 13
LF EQU 10

print    byte	".  Polygon area = "			; check if there are even no. of characters
areaAns	 byte	8 dup(?), CR, LF, NULL		; an array that holds 8 chars

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.code

	findArea PROC
	mov product,0
	mov diff,0
	mov area,0
	mov ecx,999				; sentinel value	
		loopIt: mov eax,8[esi]	; X_i+1[esi+8]=3rd element because dword=4bytes			
		imul eax,4[esi]		; (X_i+1).(Y_i)
		mov product,eax		; product = (X_i+1).(Y_i)
		mov eax,0[esi]			; X_i			
		imul eax,12[esi]		; eax = (X_i).(Y_i+1)
		mov ebx,product		; ebx = (X_i+1).(Y_i)
		sub ebx,eax			; (X_i+1).(Y_i) - (X_i).(Y_i+1)
		add diff,ebx			; diff = (X_i+1).(Y_i) - (X_i).(Y_i+1)
		add esi,8				; esi point at 2nd point
		cmp [esi],ecx			; 999?			
		jne loopIt
	mov eax,diff				; eax=sum of diff
	mov ebx,2					; div by 2
	mov edx,0					; set edx=0 before every div
	idiv ebx					; eax/ebx
	mov area,eax
	ret
	findArea endp
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	WriteLine PROC				; deals with byte size ASCII char
		next: mov al,[esi]		; use al instead of eax, al is 8 bits (1 byte)
		cmp al,NULL			; sentinal value
		je outOfHere
		call Writechar
		inc esi				; +1 instead of +4 because esi has 1 byte data
		jmp next
	outOfHere: ret
	WriteLine endP
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	blankOut PROC				; fill array with blanks
	mov al, ' '				; al = ' '
		goon: mov [esi],al		; array element = ' '
		inc esi				; next position
		dec ecx				; count--
		cmp ecx,0
		jne goon
	ret
	blankOut endP
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	ItoA PROC
	mov ebx,10				; divide by 10 to separate each digit
	again: cmp eax,0
		je outOfHere
          mov edx,0				; remainder register needs to be zero before every division
	     idiv ebx
	     add edx, '0'			; to convert a no. to ASCII char
	     dec esi				; esi points at the end of array at first due to blankOut
	     mov [esi],dl			; remainder (start from last digit)
	     jmp again
	outOfHere: ret
	ItoA endP
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	polygonPrint PROC
		call findArea
		mov ecx,8				; count = 8 for array to hold answer
		lea esi,areaAns		; esi holds the address of the array and point to the 1st char
		call blankOut			; fill array with blanks
		mov eax,area			; make sure eax = area
		call ItoA				; convert to ASCII char
		lea esi, print			; points to output
		call writeLine
	ret
	polygonPrint endP
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

main PROC

mov al,'1'
call Writechar 
lea esi, p1					; make esi point to the first point of p1
call polygonPrint

mov al,'2'
call Writechar 
lea esi, p2					; make esi point to the first point of p2
call polygonPrint

mov al,'3'
call Writechar 
lea esi, p3					; make esi point to the first point of p3
call polygonPrint

mov al,'4'
call Writechar 
lea esi, p4					; make esi point to the first point of p4
call polygonPrint

mov al,'5'
call Writechar 
lea esi, p5					; make esi point to the first point of p5
call polygonPrint

	call DumpRegs
	exit
main ENDP

END main
