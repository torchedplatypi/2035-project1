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
MatchChecks:	.alloc 2

.text
IconMatch:	addi	$1, $0, CandBase	# point to base of Candidates
		swi	584			# generate puzzle icons

		# your code goes here
		#initialize variables i'll need
		addi	$3,$0,476 #start index for finding color
		addi	$8,$0,576

		#initial loop for colored pixel.
FindColorLoop:	lw	$4,PatternBase($3)	#load pixel value
		addi	$3,$3,-4		#decrement index
		beq	$4,$0,FindColorLoop	#if black, loop.
		
		#once a pixel of color is found, I'll be here.
		addi	$5,$0,7			#set candidate index
ColorFound:	mult	$5,$8			#calculate index
		mflo	$6			#per candidate
		add	$6,$6,$3		#based on 7-0 index
		lw	$7,CandBase($6)		#load candidate pix val
		beq	$7,$4,PixelMatch
		addi	$5,$5,-1		#decrement index
JumpBack:	slt	$2,$5,$0
		bne	$2,$0, IconsChecked	
		j	ColorFound

PixelMatch:	sb	$4,MatchChecks($5)
		j	JumpBack

IconsChecked:	addi	$2,$0,0



                #addi    $2, $0, 0               # temp: guess the first icon
		swi	544			# submit answer and check
		jr	$31			# return to caller
