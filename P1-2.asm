# P1-2
# Student Name: Alex Moore
# Date: Feb 08 2015
#
#     I c o n   M a t c h
#
#
# This routine determines which of eight candidate icons matches a pattern icon.

.data
CandBase: 	.alloc 1152
PatternBase:	.alloc 144
MatchChecks:	.word  0,0

.text
IconMatch:	addi	$1, $0, CandBase	# point to base of Candidates
#		addi	$2,$0,-1
		swi	584			# generate puzzle icons

		# your code goes here
		#initialize variables i'll need
		addi	$3,$0,524 #start index for finding color
		addi	$8,$0,576
		addi	$1,$0,1

		#initial loop for colored pixel.
FindColorLoop:	addi	$3,$3,-4		#decrement index
		lw	$4,PatternBase($3)	#load pixel value
		beq	$4,$0,FindColorLoop	#if black, loop.
		
		#once a pixel of color is found, I'll be here.
		addi	$5,$0,7			#set candidate index
		add	$27,$0,$0
ColorFound:	mult	$5,$8			#calculate index
		mflo	$6			#per candidate
		add	$6,$6,$3		#based on 7-0 index
		lw	$7,CandBase($6)		#load candidate pix val
		beq	$7,$4,PixelMatch
JumpBack:	addi	$5,$5,-1		#decrement index
		slt	$26,$5,$0#REPLACE 27 WITH 2 AFTER WRITING STORAGE
		bne	$26,$0, IconsChecked#REPLACE 27 WITH 2 AFTER STORAGE
		j	ColorFound

PixelMatch:	sb	$1,MatchChecks($5)
		add	$2,$5,$0
		add	$27,$27,$1
		j	JumpBack

IconsChecked:	bne	$27,$1,FindColorLoop 
		#addi    $2, $0, 0               # temp: guess the first icon
		swi	544			# submit answer and check
		jr	$31			# return to caller
