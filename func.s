.section .data
.section .bss
.section .text

.global _start

_start:

    pushl $2
    pushl $6

    call func1

    addl $8, %esp
    pushl %eax

    pushl $3
    pushl $3

    call func1

    addl $8, %esp

    addl (%esp), %eax

    movl %eax, %ebx
    movl $1, %eax
    int $0x80


.type func1, @function
func1:
    pushl %ebp
    movl %esp, %ebp
    subl $8, %esp

    movl $1, %eax
    movl 8(%ebp), %ebx
    cmpl $0, %ebx
    je return

    movl 12(%ebp), %eax
    cmpl $1, %ebx
    je return

    cmpl $1, %eax
    je return

    pushl %eax
    pushl %ebx
    call func_mul

    je return


.type func_mul, @function
func_mul:
    pushl %ebp
    movl %esp, %ebp
    subl $8, %esp

    movl 12(%ebp), %ecx
    movl 8(%ebp), %edx

    mul_loop:
        imull 12(%ebp), %ecx
        subl $1, %edx
        cmpl $1, %edx
        jne mul_loop

    movl %ecx, %eax
    jmp return


return:
    movl %ebp, %esp
    popl %ebp

    ret
