# calculadorarRPN
pasos para conpilacion y ejecucion del proyecto 
1. nasm -f elf nombarchivo+ .asm
2. revisar si genero el archivo con .o
2. ld -m elf_i386 nombrearchivo + .o -o nombrearchivo sin extension 
3. revisar si genero el ejecutable 
4. ./nombre archivo sin extension 
