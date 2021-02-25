.model tiny
.code

org 100h
Start:		;mov ax, 0b800h
		;mov es, ax
		;mov di, (80 + 40) * 2
		;mov ah, 4eh
		;cld			; clear destination flag 
				
Next:		;in al, 60h
		;stosw
		;mov es:[di], ax
		;cmp al, 1
		;jne Next

		mov bx, 0
		mov es, bx		; �������, ������ ���� (����� ������������ � ������� ����������)
		mov bx, 9 * 4		; 9 - ����� ����������, 4 - ������ ������
		mov ax, es:[bx]
		mov Old09_ofs, ax	; ������ �����
		mov ax, es:[bx+2]	; ������� ����� ������
		mov Old09_seg, ax	; 

		;----------------- ������ � �������� ���������� ---------------------
		cli			; ��������� ����������, ����� �������� ������� � ��������
		mov es:[bx], offset New09	; ����� ��������
		mov ax, cs		; ������ �������
		mov es:[bx+2], ax       	; ����� �������
		sti			; ��������� ����������

		mov ax, 4c00h		; 4c - ����������� ������ ����� ���������� - ����� ����� ������
					; (�����-�� ���������, � ��� ���������� ����������)
		mov ax, 3100h		; Terminate 
		mov dx, offset EndProgram	; Memory size - � ���������� - ������� ����� ����� ������ (1 ���. = 16 ����)		
		shr dx, 4		; ����� �� 16
		inc dx			; ����� ����� �� ������ �������� 
                int 21h

New09	proc
		push es di ax
		
		mov di, 0b800h
		mov es, di
		mov di, (80 + 40) * 2
		mov ah, 4eh
		in al, 60h   		; ������ �� ����� ������
		mov es:[di], ax
		
		cmp al, 02h		; ���������� ������ �� ����-����� 2
		jne EOI

		mov es:[di+4],  ax	; ���� ������� �������, �� ����� ������ ��� ��

		in al, 61h  		; ������� ������
		mov ah, al
		or al, 80h 		; ��������� ������� ���
		out 61h, al
		mov al, ah
		out 61h, al

		mov al, 20h
		out 20h, al

		pop ax di es
		iret

EOI:		pop ax di es    	; �������������� ���������

		db 0eah			; ������������������� ��� (������ �� ������ ����������) 		
Old09_ofs	dw 0
Old09_seg	dw 0
		
		;iret

New09	endp		
                    

EndProgram:	
		
end		Start			
