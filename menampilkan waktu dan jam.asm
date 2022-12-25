org 100h

mulai:

sys_date:
    mov ah,2ah
    int 21h
   
    mov yer,cx
    mov mth,dh
    mov day,dl
    mov dow,al
   
    call cek_hari
cek_1:
    mov ah,9
    lea dx,koma
    int 21h
    call cek_tanggal
cek_2:
    call cek_bulan
cek_3:
    call pnggl_thn
cek_4: 
    mov ah,9
    lea dx,baris
    int 21h            
sys_time:
    mov ah,2ch
    int 21h
   
    mov hour,ch
    mov mnt,cl
    mov scd,dh
      
waktu:   
    tmpl_jam:
    xor ax,ax
    mov al,hour
    mov bl,10
    div bl
    push ax
   
    jam:
    pop dx
    mov a,dh
    add dl,30h
    mov ah,2
    int 21h
    mov dl,a
    add dl,30h
    int 21h
   
    mov ah,9
    lea dx,ttk2
    int 21h 
   
    tmpl_menit:
    xor ax,ax
    xor bx,bx
    mov al,mnt
    mov bl,10
    div bl
    push ax
   
    menit:
    pop dx
    mov a,dh
    add dl,30h
    mov ah,2
    int 21h
    mov dl,a
    add dl,30h
    int 21h

    mov ah,9
    lea dx,ttk2
    int 21h 
   
    detik:
    xor ax,ax
    mov al,scd
    mov bl,10
    div bl
    push ax
    pop dx
    add dl,30h
    mov ah,2
    int 21h
    mov dl,dh
    add dl,30h
    int 21h

mov dh,2
mov dl,0
mov bh,0
mov ah,2
int 10h
 
jmp sys_time
mov ah,4ch
int 21h
                 
    ret
   
   
;variable simpan            
day db ?
a db ?
b db ?
hour db ?
mnt db ?
scd db ?
dow db ?
mth db ?
yer dw ?

baris db 0ah,0dh,'$'
koma db ', $'
ttk2 db ':$'

;Procedure       
;kondisi cek
cek_hari proc
    cmp al,00h
    je label_minggu
    cmp al,01h
    je label_senin
    cmp al,02h
    je label_selasa
    cmp al,03h
    je label_rabu
    cmp al,04h
    je label_kamis
    cmp al,05h
    je label_jumat
    cmp al,06h
    je label_sabtu
    ret
    cek_hari endp
cek_tanggal proc
    xor ax,ax
    mov al,day
    mov bl,10
    div bl
   
    mov a,al
    mov b,ah
    xor ax,ax
    xor bx,bx
   
    mov al,a
    shl bl,4
    or bl,al
    mov al,b
    shl bl,4
    or bl,al
   
    call proses_
    jmp cek_2
cek_bulan proc
    cmp mth,01h
    je label_jan
    cmp mth,02h
    je label_feb
    cmp mth,03h
    je label_mar
    cmp mth,04h
    je label_apr
    cmp mth,05h
    je label_mei
    cmp mth,06h
    je label_jun
    cmp mth,07h
    je label_jul
    cmp mth,08h   
    je label_aug
    cmp mth,09h
    je label_sep
    cmp mth,0ah
    je label_okt
    cmp mth,0bh
    je label_nop
    cmp mth,0ch
    je label_des
   
pnggl_thn proc
    mov cx,4
    mov ax,yer
    mov bl,10
bagi_thn:
    div bl
    push ax
    mov ah,00

    loop bagi_thn
mov cx,4  
pop_thn:
    pop dx
    mov dl,dh
    add dl,30h
    mov ah,2
    int 21h
    loop pop_thn   
    jmp cek_4
;label
label_jan:
    mov ah,9
    lea dx,b_jan
    int 21h 
    jmp cek_3       
label_feb:
    mov ah,9
    lea dx,b_feb
    int 21h 
    jmp cek_3
label_mar:
    mov ah,9
    lea dx,b_mar
    int 21h 
    jmp cek_3
label_apr:
    mov ah,9
    lea dx,b_apr
    int 21h 
    jmp cek_3
label_mei:
    mov ah,9
    lea dx,b_mei
    int 21h 
    jmp cek_3
label_jun:
    mov ah,9
    lea dx,b_jun
    int 21h 
    jmp cek_3
label_jul:
    mov ah,9
    lea dx,b_jul
    int 21h 
    jmp cek_3
label_aug:
     mov ah,9
    lea dx,b_aug
    int 21h 
    jmp cek_3
label_sep:
    mov ah,9
    lea dx,b_sep
    int 21h 
    jmp cek_3
label_okt:
    mov ah,9
    lea dx,b_okt
    int 21h
    jmp cek_3
label_nop:
    mov ah,9
    lea dx,b_nop
    int 21h 
    jmp cek_3
label_des:
    mov ah,9
    lea dx,b_des
    int 21h 
    jmp cek_3

label_minggu:
    mov ah,9
    lea dx,baris
    int 21h
    lea dx,h_minggu
    int 21h   
    jmp cek_1
label_senin:
    mov ah,9
    lea dx,baris
    int 21h
    lea dx,h_senin
    int 21h 
    jmp cek_1
label_selasa:
    mov ah,9
    lea dx,baris
    int 21h
    lea dx,h_selasa
    int 21h    
    jmp cek_1
label_rabu:
    mov ah,9
    lea dx,baris
    int 21h
    lea dx,h_rabu
    int 21h 
    jmp cek_1
label_kamis:
    mov ah,9
    lea dx,baris
    int 21h
    lea dx,h_kamis
    int 21h 
    jmp cek_1
label_jumat:
    mov ah,9
    lea dx,baris
    int 21h
    lea dx,h_jumat
    int 21h 
    jmp cek_1
label_sabtu:
    mov ah,9
    lea dx,baris
    int 21h
    lea dx,h_sabtu
    int 21h
    jmp cek_1

proses_ proc
    mov cx,2
    top:
        mov dl,bl
        shr dl,4
       
        add dl,30h
        mov ah,2
        int 21h 
        cmp cl,1
        je bwh  
        rol bx,4
        loop top
        bwh:
        jmp cek_2
        proses_ endp

;Variable hari
h_minggu db 'Minggu$'
h_senin db 'Senin$'
h_selasa db 'Selasa$'
h_rabu db 'Rabu$'
h_kamis db 'Kamis$'
h_jumat db 'Jumat$'
h_sabtu db 'Sabtu$'

;variable bulan
b_jan db ' Januari $'
b_feb db ' Februari $'
b_mar db ' Maret $'
b_apr db ' April $'
b_mei db ' Mei $'
b_jun db ' Juni $'
b_jul db ' Juli $'
b_aug db ' Agustus $'
b_sep db ' September $'
b_okt db ' Oktober $'
b_nop db ' November $'
b_des db ' Desember $'





