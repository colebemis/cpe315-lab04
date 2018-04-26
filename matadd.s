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

matadd:
  push {r4, r5, r6, r7, r8, r9, r10, lr}

  ldr r10, [sp, #32]

  mul r4, r3, r10

loop:
  cmp r4, #0
  beq end
  sub r4, r4, #1

  @ A[i][j]
  ldr r5, [r1, r4]

  @ B[i][j]
  ldr r6, [r2, r4]

  @ A[i][j] + B[i][j]
  add r7, r5, r6

  @ C[i][j] = r7
  str r7, [r0, r4]

  b loop

end:
  pop {r4, r5, r6, r7, r8, r9, r10, pc}

/*
matadd:
  push {r4, r5, r6, r7, r8, r9, r10, lr}

  ldr r10, [sp, #32] @ store width

  mov r4, r3 @ initialize i to height

loop1:
  cmp r4, #0
  beq end
  sub r4, r4, #1
  ldr r0, =height
  mov r1, r4
  bl printf

  ldr r5, [sp, #32] @ initialize j to width

loop2:
  cmp r5, #0
  beq loop1
  sub r5, r5, #1
  
  ldr r0, =width
  mov r1, r5
  bl printf

  @ row * width + col
  @ mul r10, r4, r7
  @ add r10, r10, r5


  @ load value A[i][j] into r6
  @ ldr r6, [r1, r10]
  ldr r0, =width
  mov r1, r7
  bl printf


  @ load valsdfaue B[i][j] into r7
  


  @ add r6 and r7 and store r8
  @ load address C[i][j] in r9
  @ store r8 at r9

  b loop2
  
  ldr r0, =height
  mov r1, r4
  bl printf


  ldr r0, =width
  mov r1, r5
  bl printf
end:
  pop {r4, r5, r6, r7, r8, r9, r10, pc}

string:
 .asciz "Hello world\n"
height:
  .asciz "height: %d\n"
width:
  .asciz "width: %d\n"

 * r4: i (height)
 * r5: j (width)
matadd:
  push {r4, r5, r6, r7, r8, r9, lr}
  
  mov r4, r3 @ initialize i to height

loop1:
  cmp r4, #0
  beq end
  sub r4, r4, #1

  ldr r5, [sp, #28] @ initialize j to width

loop2:
  cmp r5, #0
  beq loop1
  sub r5, r5, #1

  @ load value A[i][j] into r6
  ldr r6, [r1, r4]
  ldr r6, [r6, r5]

  @ load value B[i][j] into r7
  ldr r7, [r2, r4]
  ldr r7, [r7, r5]

  @ add r6 and r7 and store r8
  add r8, r6, r7

  @ load address C[i][j] in r9
  ldr r9, [r0, r4]

  @ store r8 at r9
  str r8, [r9, r5]

  b loop2

end:
  pop {r4, r5, r6, r7, r8, r9, pc}
*/
