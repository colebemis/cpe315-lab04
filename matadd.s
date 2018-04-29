    /* This function has 5 parameters, and the declaration in the
       C-language would look like:

       void matadd (int **C, int **A, int **B, int height, int width)

       C, A, B, and height will be passed in r0-r3, respectively, and
       width will be passed on the stack.

       You need to write a function that computes the sum C = A + B.

       A, B, and C are arrays of arrays (matrices), so for all elements,
       C[i][j] = A[i][j] + B[i][j]

       You should start with two for-loops that iterate over the height and
       width of the matrices, load each element from A and B, compute the
       sum, then store the result to the correct element of C. 

       This function will be called multiple times by the driver, 
       so don't modify matrices A or B in your implementation.

       As usual, your function must obey correct ARM register usage
       and calling conventions. */

	.arch armv7-a
	.text
	.align	2
	.global	matadd
	.syntax unified
	.arm

/*
 * r0: C
 * r1: A
 * r2: B
 * r3: height
 * on stack: width
 *
 * r4: i
 * r5: j
 */

matadd:
  push {r4, r5, r6, r7, r8, r9, r10, lr}

  @ save width
  ldr r10, [sp, #32]
  
  @ initialize i (r4) to height
  mov r4, r3

  @ldr r0, =print
  @bl printf

loop1:
  cmp r4, #0
  beq end

  @ decrement r4 if it doesn't equal 0
  sub r4, r4, #1

  @ initialize j (r5) to width
  ldr r5, [sp, #32]

loop2:
  cmp r5, #0
  beq loop1

  @ decrement r5 if it doesn't equal 0
  sub r5, r5, #1

  mul r9, r10, r4 @ width * row
  add r9, r9, r5 @ col + (width * row)

  @ load value of A[i][j] into r6
  ldr r6, [r1, r9]
  @ldr r6, [r6, r5]

  @ldr r0, =print
  @bl printf
  

  @ load value of B[i][j] into r7
  ldr r7, [r2, r9]
  @ldr r7, [r7, r5]

  @ add r6 and r7, store in r8
  add r8, r6, r7

  @ load address of C[i][j] into r9
  @ldr r9, [r0, r4]

  @ store r8 into address stored in r9
  str r8, [r0, r9]

  b loop2

end:
  pop {r4, r5, r6, r7, r8, r9, r10, pc}

print:
  .asciz "%x\n"
