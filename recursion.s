.section .data
.section .bss
.section .text

.global _start

_start:
    pushl $1
    call factor

    jmp exit


.type fatcor, @function
factor:
    pushl %ebp
    movl %esp, %ebp
    subl $8, %esp

    movl 8(%ebp), %ebx
    cmpl $1, %ebx
    jne recursion

    movl $1, %eax
    jmp return

    recursion:
        subl $1, %ebx
        pushl %ebx
        call factor

    imull 8(%ebp), %eax
    jmp return


exit:
    movl %eax, %ebx
    movl $1, %eax
    int $0x80

return:
    movl %ebp, %esp
    popl %ebp
    ret
