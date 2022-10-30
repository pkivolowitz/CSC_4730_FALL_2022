	.section	__TEXT,__text,regular,pure_instructions
	.build_version macos, 12, 0	sdk_version 12, 3
	.globl	__Z6workerjy                    ; -- Begin function _Z6workerjy
	.p2align	2
__Z6workerjy:                           ; @_Z6workerjy
	.cfi_startproc
; %bb.0:
	cbz	x1, LBB0_2
; %bb.1:
	adrp	x8, _counter@PAGE
	ldr	x9, [x8, _counter@PAGEOFF]
	add	x9, x9, x1
	str	x9, [x8, _counter@PAGEOFF]
LBB0_2:
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_main                           ; -- Begin function main
	.p2align	2
_main:                                  ; @main
Lfunc_begin0:
	.cfi_startproc
	.cfi_personality 155, ___gxx_personality_v0
	.cfi_lsda 16, Lexception0
; %bb.0:
	sub	sp, sp, #80
	stp	x24, x23, [sp, #16]             ; 16-byte Folded Spill
	stp	x22, x21, [sp, #32]             ; 16-byte Folded Spill
	stp	x20, x19, [sp, #48]             ; 16-byte Folded Spill
	stp	x29, x30, [sp, #64]             ; 16-byte Folded Spill
	add	x29, sp, #64
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	.cfi_offset w19, -24
	.cfi_offset w20, -32
	.cfi_offset w21, -40
	.cfi_offset w22, -48
	.cfi_offset w23, -56
	.cfi_offset w24, -64
	mov	x20, x1
	mov	x21, x0
	mov	w8, #34464
	movk	w8, #1, lsl #16
	str	x8, [sp]
	bl	__ZNSt3__16thread20hardware_concurrencyEv
	mov	w23, w0
	cbz	w0, LBB1_24
; %bb.1:
	lsl	x22, x23, #3
	mov	x0, x22
	bl	__Znwm
	mov	x19, x0
	mov	x1, x22
	bl	_bzero
	cmp	w21, #2
	b.lt	LBB1_3
LBB1_2:
	ldr	x0, [x20, #8]
	bl	_atol
	str	x0, [sp]
LBB1_3:
	str	wzr, [sp, #8]
	cbz	w23, LBB1_11
; %bb.4:
Lloh0:
	adrp	x20, __Z6workerjy@PAGE
Lloh1:
	add	x20, x20, __Z6workerjy@PAGEOFF
LBB1_5:                                 ; =>This Inner Loop Header: Depth=1
Ltmp0:
	mov	w0, #8
	bl	__Znwm
Ltmp1:
; %bb.6:                                ;   in Loop: Header=BB1_5 Depth=1
	mov	x21, x0
Ltmp3:
	add	x2, sp, #8
	mov	x3, sp
	mov	x1, x20
	bl	__ZNSt3__16threadC2IRFvjyEJRjRyEvEEOT_DpOT0_
Ltmp4:
; %bb.7:                                ;   in Loop: Header=BB1_5 Depth=1
	ldr	w8, [sp, #8]
	str	x21, [x19, x8, lsl #3]
	add	w8, w8, #1
	str	w8, [sp, #8]
	cmp	w8, w23
	b.lo	LBB1_5
; %bb.8:
	mov	x20, x23
	mov	x21, x19
LBB1_9:                                 ; =>This Inner Loop Header: Depth=1
	ldr	x0, [x21]
Ltmp6:
	bl	__ZNSt3__16thread4joinEv
Ltmp7:
; %bb.10:                               ;   in Loop: Header=BB1_9 Depth=1
	add	x21, x21, #8
	subs	x20, x20, #1
	b.ne	LBB1_9
LBB1_11:
Ltmp9:
Lloh2:
	adrp	x0, __ZNSt3__14coutE@GOTPAGE
Lloh3:
	ldr	x0, [x0, __ZNSt3__14coutE@GOTPAGEOFF]
Lloh4:
	adrp	x1, l_.str@PAGE
Lloh5:
	add	x1, x1, l_.str@PAGEOFF
	mov	w2, #23
	bl	__ZNSt3__124__put_character_sequenceIcNS_11char_traitsIcEEEERNS_13basic_ostreamIT_T0_EES7_PKS4_m
Ltmp10:
; %bb.12:
Ltmp11:
Lloh6:
	adrp	x0, __ZNSt3__14coutE@GOTPAGE
Lloh7:
	ldr	x0, [x0, __ZNSt3__14coutE@GOTPAGEOFF]
Lloh8:
	adrp	x1, l_.str.1@PAGE
Lloh9:
	add	x1, x1, l_.str.1@PAGEOFF
	mov	w2, #10
	bl	__ZNSt3__124__put_character_sequenceIcNS_11char_traitsIcEEEERNS_13basic_ostreamIT_T0_EES7_PKS4_m
Ltmp12:
; %bb.13:
	ldr	x8, [sp]
	mul	x1, x8, x23
Ltmp13:
	bl	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEElsEy
Ltmp14:
; %bb.14:
Ltmp15:
Lloh10:
	adrp	x1, l_.str.2@PAGE
Lloh11:
	add	x1, x1, l_.str.2@PAGEOFF
	mov	w2, #7
	bl	__ZNSt3__124__put_character_sequenceIcNS_11char_traitsIcEEEERNS_13basic_ostreamIT_T0_EES7_PKS4_m
Ltmp16:
; %bb.15:
Lloh12:
	adrp	x8, _counter@PAGE
Lloh13:
	ldr	x1, [x8, _counter@PAGEOFF]
Ltmp17:
	bl	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEElsEy
Ltmp18:
; %bb.16:
	mov	x20, x0
	ldr	x8, [x0]
	ldur	x8, [x8, #-24]
	add	x0, x0, x8
Ltmp19:
	add	x8, sp, #8
	bl	__ZNKSt3__18ios_base6getlocEv
Ltmp20:
; %bb.17:
Ltmp21:
Lloh14:
	adrp	x1, __ZNSt3__15ctypeIcE2idE@GOTPAGE
Lloh15:
	ldr	x1, [x1, __ZNSt3__15ctypeIcE2idE@GOTPAGEOFF]
	add	x0, sp, #8
	bl	__ZNKSt3__16locale9use_facetERNS0_2idE
Ltmp22:
; %bb.18:
	ldr	x8, [x0]
	ldr	x8, [x8, #56]
Ltmp23:
	mov	w1, #10
	blr	x8
Ltmp24:
; %bb.19:
	mov	x21, x0
	add	x0, sp, #8
	bl	__ZNSt3__16localeD1Ev
Ltmp26:
	mov	x0, x20
	mov	x1, x21
	bl	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEE3putEc
Ltmp27:
; %bb.20:
Ltmp28:
	mov	x0, x20
	bl	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEE5flushEv
Ltmp29:
; %bb.21:
	cbz	x19, LBB1_23
; %bb.22:
	mov	x0, x19
	bl	__ZdlPv
LBB1_23:
	mov	w0, #0
	ldp	x29, x30, [sp, #64]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #48]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #32]             ; 16-byte Folded Reload
	ldp	x24, x23, [sp, #16]             ; 16-byte Folded Reload
	add	sp, sp, #80
	ret
LBB1_24:
	mov	x19, #0
	cmp	w21, #2
	b.ge	LBB1_2
	b	LBB1_3
LBB1_25:
Ltmp25:
	mov	x20, x0
	add	x0, sp, #8
	bl	__ZNSt3__16localeD1Ev
	b	LBB1_31
LBB1_26:
Ltmp30:
	b	LBB1_30
LBB1_27:
Ltmp8:
	mov	x20, x0
	b	LBB1_32
LBB1_28:
Ltmp5:
	mov	x20, x0
	mov	x0, x21
	bl	__ZdlPv
	b	LBB1_31
LBB1_29:
Ltmp2:
LBB1_30:
	mov	x20, x0
LBB1_31:
	cbz	x19, LBB1_33
LBB1_32:
	mov	x0, x19
	bl	__ZdlPv
LBB1_33:
	mov	x0, x20
	bl	__Unwind_Resume
	.loh AdrpAdd	Lloh0, Lloh1
	.loh AdrpAdd	Lloh4, Lloh5
	.loh AdrpLdrGot	Lloh2, Lloh3
	.loh AdrpAdd	Lloh8, Lloh9
	.loh AdrpLdrGot	Lloh6, Lloh7
	.loh AdrpAdd	Lloh10, Lloh11
	.loh AdrpLdr	Lloh12, Lloh13
	.loh AdrpLdrGot	Lloh14, Lloh15
Lfunc_end0:
	.cfi_endproc
	.section	__TEXT,__gcc_except_tab
	.p2align	2
GCC_except_table1:
Lexception0:
	.byte	255                             ; @LPStart Encoding = omit
	.byte	255                             ; @TType Encoding = omit
	.byte	1                               ; Call site Encoding = uleb128
	.uleb128 Lcst_end0-Lcst_begin0
Lcst_begin0:
	.uleb128 Lfunc_begin0-Lfunc_begin0      ; >> Call Site 1 <<
	.uleb128 Ltmp0-Lfunc_begin0             ;   Call between Lfunc_begin0 and Ltmp0
	.byte	0                               ;     has no landing pad
	.byte	0                               ;   On action: cleanup
	.uleb128 Ltmp0-Lfunc_begin0             ; >> Call Site 2 <<
	.uleb128 Ltmp1-Ltmp0                    ;   Call between Ltmp0 and Ltmp1
	.uleb128 Ltmp2-Lfunc_begin0             ;     jumps to Ltmp2
	.byte	0                               ;   On action: cleanup
	.uleb128 Ltmp3-Lfunc_begin0             ; >> Call Site 3 <<
	.uleb128 Ltmp4-Ltmp3                    ;   Call between Ltmp3 and Ltmp4
	.uleb128 Ltmp5-Lfunc_begin0             ;     jumps to Ltmp5
	.byte	0                               ;   On action: cleanup
	.uleb128 Ltmp6-Lfunc_begin0             ; >> Call Site 4 <<
	.uleb128 Ltmp7-Ltmp6                    ;   Call between Ltmp6 and Ltmp7
	.uleb128 Ltmp8-Lfunc_begin0             ;     jumps to Ltmp8
	.byte	0                               ;   On action: cleanup
	.uleb128 Ltmp9-Lfunc_begin0             ; >> Call Site 5 <<
	.uleb128 Ltmp20-Ltmp9                   ;   Call between Ltmp9 and Ltmp20
	.uleb128 Ltmp30-Lfunc_begin0            ;     jumps to Ltmp30
	.byte	0                               ;   On action: cleanup
	.uleb128 Ltmp21-Lfunc_begin0            ; >> Call Site 6 <<
	.uleb128 Ltmp24-Ltmp21                  ;   Call between Ltmp21 and Ltmp24
	.uleb128 Ltmp25-Lfunc_begin0            ;     jumps to Ltmp25
	.byte	0                               ;   On action: cleanup
	.uleb128 Ltmp26-Lfunc_begin0            ; >> Call Site 7 <<
	.uleb128 Ltmp29-Ltmp26                  ;   Call between Ltmp26 and Ltmp29
	.uleb128 Ltmp30-Lfunc_begin0            ;     jumps to Ltmp30
	.byte	0                               ;   On action: cleanup
	.uleb128 Ltmp29-Lfunc_begin0            ; >> Call Site 8 <<
	.uleb128 Lfunc_end0-Ltmp29              ;   Call between Ltmp29 and Lfunc_end0
	.byte	0                               ;     has no landing pad
	.byte	0                               ;   On action: cleanup
Lcst_end0:
	.p2align	2
                                        ; -- End function
	.section	__TEXT,__text,regular,pure_instructions
	.private_extern	___clang_call_terminate ; -- Begin function __clang_call_terminate
	.globl	___clang_call_terminate
	.weak_def_can_be_hidden	___clang_call_terminate
	.p2align	2
___clang_call_terminate:                ; @__clang_call_terminate
; %bb.0:
	stp	x29, x30, [sp, #-16]!           ; 16-byte Folded Spill
	bl	___cxa_begin_catch
	bl	__ZSt9terminatev
                                        ; -- End function
	.private_extern	__ZNSt3__16threadC2IRFvjyEJRjRyEvEEOT_DpOT0_ ; -- Begin function _ZNSt3__16threadC2IRFvjyEJRjRyEvEEOT_DpOT0_
	.globl	__ZNSt3__16threadC2IRFvjyEJRjRyEvEEOT_DpOT0_
	.weak_def_can_be_hidden	__ZNSt3__16threadC2IRFvjyEJRjRyEvEEOT_DpOT0_
	.p2align	2
__ZNSt3__16threadC2IRFvjyEJRjRyEvEEOT_DpOT0_: ; @_ZNSt3__16threadC2IRFvjyEJRjRyEvEEOT_DpOT0_
Lfunc_begin1:
	.cfi_startproc
	.cfi_personality 155, ___gxx_personality_v0
	.cfi_lsda 16, Lexception1
; %bb.0:
	stp	x24, x23, [sp, #-64]!           ; 16-byte Folded Spill
	stp	x22, x21, [sp, #16]             ; 16-byte Folded Spill
	stp	x20, x19, [sp, #32]             ; 16-byte Folded Spill
	stp	x29, x30, [sp, #48]             ; 16-byte Folded Spill
	add	x29, sp, #48
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	.cfi_offset w19, -24
	.cfi_offset w20, -32
	.cfi_offset w21, -40
	.cfi_offset w22, -48
	.cfi_offset w23, -56
	.cfi_offset w24, -64
	mov	x23, x3
	mov	x24, x2
	mov	x22, x1
	mov	x20, x0
	mov	w0, #8
	bl	__Znwm
	mov	x21, x0
Ltmp31:
	bl	__ZNSt3__115__thread_structC1Ev
Ltmp32:
; %bb.1:
Ltmp34:
	mov	w0, #32
	bl	__Znwm
Ltmp35:
; %bb.2:
	mov	x19, x0
	ldr	w8, [x24]
	ldr	x9, [x23]
	stp	x21, x22, [x0]
	str	w8, [x0, #16]
	str	x9, [x0, #24]
Ltmp37:
Lloh16:
	adrp	x2, __ZNSt3__1L14__thread_proxyINS_5tupleIJNS_10unique_ptrINS_15__thread_structENS_14default_deleteIS3_EEEEPFvjyEjyEEEEEPvSA_@PAGE
Lloh17:
	add	x2, x2, __ZNSt3__1L14__thread_proxyINS_5tupleIJNS_10unique_ptrINS_15__thread_structENS_14default_deleteIS3_EEEEPFvjyEjyEEEEEPvSA_@PAGEOFF
	mov	x0, x20
	mov	x1, #0
	mov	x3, x19
	bl	_pthread_create
Ltmp38:
; %bb.3:
	cbnz	w0, LBB3_5
; %bb.4:
	mov	x0, x20
	ldp	x29, x30, [sp, #48]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #32]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #16]             ; 16-byte Folded Reload
	ldp	x24, x23, [sp], #64             ; 16-byte Folded Reload
	ret
LBB3_5:
Ltmp39:
Lloh18:
	adrp	x1, l_.str.4@PAGE
Lloh19:
	add	x1, x1, l_.str.4@PAGEOFF
	bl	__ZNSt3__120__throw_system_errorEiPKc
Ltmp40:
; %bb.6:
	brk	#0x1
LBB3_7:
Ltmp36:
	mov	x20, x0
	mov	x0, x21
	bl	__ZNSt3__115__thread_structD1Ev
	b	LBB3_12
LBB3_8:
Ltmp33:
	mov	x20, x0
	b	LBB3_12
LBB3_9:
Ltmp41:
	mov	x20, x0
	ldr	x0, [x19]
	str	xzr, [x19]
	cbz	x0, LBB3_11
; %bb.10:
	bl	__ZNSt3__115__thread_structD1Ev
	bl	__ZdlPv
LBB3_11:
	mov	x21, x19
LBB3_12:
	mov	x0, x21
	bl	__ZdlPv
	mov	x0, x20
	bl	__Unwind_Resume
	.loh AdrpAdd	Lloh16, Lloh17
	.loh AdrpAdd	Lloh18, Lloh19
Lfunc_end1:
	.cfi_endproc
	.section	__TEXT,__gcc_except_tab
	.p2align	2
GCC_except_table3:
Lexception1:
	.byte	255                             ; @LPStart Encoding = omit
	.byte	255                             ; @TType Encoding = omit
	.byte	1                               ; Call site Encoding = uleb128
	.uleb128 Lcst_end1-Lcst_begin1
Lcst_begin1:
	.uleb128 Lfunc_begin1-Lfunc_begin1      ; >> Call Site 1 <<
	.uleb128 Ltmp31-Lfunc_begin1            ;   Call between Lfunc_begin1 and Ltmp31
	.byte	0                               ;     has no landing pad
	.byte	0                               ;   On action: cleanup
	.uleb128 Ltmp31-Lfunc_begin1            ; >> Call Site 2 <<
	.uleb128 Ltmp32-Ltmp31                  ;   Call between Ltmp31 and Ltmp32
	.uleb128 Ltmp33-Lfunc_begin1            ;     jumps to Ltmp33
	.byte	0                               ;   On action: cleanup
	.uleb128 Ltmp34-Lfunc_begin1            ; >> Call Site 3 <<
	.uleb128 Ltmp35-Ltmp34                  ;   Call between Ltmp34 and Ltmp35
	.uleb128 Ltmp36-Lfunc_begin1            ;     jumps to Ltmp36
	.byte	0                               ;   On action: cleanup
	.uleb128 Ltmp37-Lfunc_begin1            ; >> Call Site 4 <<
	.uleb128 Ltmp40-Ltmp37                  ;   Call between Ltmp37 and Ltmp40
	.uleb128 Ltmp41-Lfunc_begin1            ;     jumps to Ltmp41
	.byte	0                               ;   On action: cleanup
	.uleb128 Ltmp40-Lfunc_begin1            ; >> Call Site 5 <<
	.uleb128 Lfunc_end1-Ltmp40              ;   Call between Ltmp40 and Lfunc_end1
	.byte	0                               ;     has no landing pad
	.byte	0                               ;   On action: cleanup
Lcst_end1:
	.p2align	2
                                        ; -- End function
	.section	__TEXT,__text,regular,pure_instructions
	.p2align	2                               ; -- Begin function _ZNSt3__1L14__thread_proxyINS_5tupleIJNS_10unique_ptrINS_15__thread_structENS_14default_deleteIS3_EEEEPFvjyEjyEEEEEPvSA_
__ZNSt3__1L14__thread_proxyINS_5tupleIJNS_10unique_ptrINS_15__thread_structENS_14default_deleteIS3_EEEEPFvjyEjyEEEEEPvSA_: ; @_ZNSt3__1L14__thread_proxyINS_5tupleIJNS_10unique_ptrINS_15__thread_structENS_14default_deleteIS3_EEEEPFvjyEjyEEEEEPvSA_
Lfunc_begin2:
	.cfi_startproc
	.cfi_personality 155, ___gxx_personality_v0
	.cfi_lsda 16, Lexception2
; %bb.0:
	stp	x20, x19, [sp, #-32]!           ; 16-byte Folded Spill
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	add	x29, sp, #16
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	.cfi_offset w19, -24
	.cfi_offset w20, -32
	mov	x19, x0
Ltmp42:
	bl	__ZNSt3__119__thread_local_dataEv
Ltmp43:
; %bb.1:
	ldr	x1, [x19]
	str	xzr, [x19]
	ldr	x0, [x0]
Ltmp45:
	bl	_pthread_setspecific
Ltmp46:
; %bb.2:
	ldr	x8, [x19, #8]
	ldr	w0, [x19, #16]
	ldr	x1, [x19, #24]
Ltmp47:
	blr	x8
Ltmp48:
; %bb.3:
	ldr	x0, [x19]
	str	xzr, [x19]
	cbz	x0, LBB4_5
; %bb.4:
	bl	__ZNSt3__115__thread_structD1Ev
	bl	__ZdlPv
LBB4_5:
	mov	x0, x19
	bl	__ZdlPv
	mov	x0, #0
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp], #32             ; 16-byte Folded Reload
	ret
LBB4_6:
Ltmp44:
	mov	x20, x0
	cbnz	x19, LBB4_8
	b	LBB4_11
LBB4_7:
Ltmp49:
	mov	x20, x0
LBB4_8:
	ldr	x0, [x19]
	str	xzr, [x19]
	cbz	x0, LBB4_10
; %bb.9:
	bl	__ZNSt3__115__thread_structD1Ev
	bl	__ZdlPv
LBB4_10:
	mov	x0, x19
	bl	__ZdlPv
LBB4_11:
	mov	x0, x20
	bl	__Unwind_Resume
Lfunc_end2:
	.cfi_endproc
	.section	__TEXT,__gcc_except_tab
	.p2align	2
GCC_except_table4:
Lexception2:
	.byte	255                             ; @LPStart Encoding = omit
	.byte	255                             ; @TType Encoding = omit
	.byte	1                               ; Call site Encoding = uleb128
	.uleb128 Lcst_end2-Lcst_begin2
Lcst_begin2:
	.uleb128 Ltmp42-Lfunc_begin2            ; >> Call Site 1 <<
	.uleb128 Ltmp43-Ltmp42                  ;   Call between Ltmp42 and Ltmp43
	.uleb128 Ltmp44-Lfunc_begin2            ;     jumps to Ltmp44
	.byte	0                               ;   On action: cleanup
	.uleb128 Ltmp45-Lfunc_begin2            ; >> Call Site 2 <<
	.uleb128 Ltmp48-Ltmp45                  ;   Call between Ltmp45 and Ltmp48
	.uleb128 Ltmp49-Lfunc_begin2            ;     jumps to Ltmp49
	.byte	0                               ;   On action: cleanup
	.uleb128 Ltmp48-Lfunc_begin2            ; >> Call Site 3 <<
	.uleb128 Lfunc_end2-Ltmp48              ;   Call between Ltmp48 and Lfunc_end2
	.byte	0                               ;     has no landing pad
	.byte	0                               ;   On action: cleanup
Lcst_end2:
	.p2align	2
                                        ; -- End function
	.section	__TEXT,__text,regular,pure_instructions
	.globl	__ZNSt3__124__put_character_sequenceIcNS_11char_traitsIcEEEERNS_13basic_ostreamIT_T0_EES7_PKS4_m ; -- Begin function _ZNSt3__124__put_character_sequenceIcNS_11char_traitsIcEEEERNS_13basic_ostreamIT_T0_EES7_PKS4_m
	.weak_def_can_be_hidden	__ZNSt3__124__put_character_sequenceIcNS_11char_traitsIcEEEERNS_13basic_ostreamIT_T0_EES7_PKS4_m
	.p2align	2
__ZNSt3__124__put_character_sequenceIcNS_11char_traitsIcEEEERNS_13basic_ostreamIT_T0_EES7_PKS4_m: ; @_ZNSt3__124__put_character_sequenceIcNS_11char_traitsIcEEEERNS_13basic_ostreamIT_T0_EES7_PKS4_m
Lfunc_begin3:
	.cfi_startproc
	.cfi_personality 155, ___gxx_personality_v0
	.cfi_lsda 16, Lexception3
; %bb.0:
	sub	sp, sp, #112
	stp	x26, x25, [sp, #32]             ; 16-byte Folded Spill
	stp	x24, x23, [sp, #48]             ; 16-byte Folded Spill
	stp	x22, x21, [sp, #64]             ; 16-byte Folded Spill
	stp	x20, x19, [sp, #80]             ; 16-byte Folded Spill
	stp	x29, x30, [sp, #96]             ; 16-byte Folded Spill
	add	x29, sp, #96
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	.cfi_offset w19, -24
	.cfi_offset w20, -32
	.cfi_offset w21, -40
	.cfi_offset w22, -48
	.cfi_offset w23, -56
	.cfi_offset w24, -64
	.cfi_offset w25, -72
	.cfi_offset w26, -80
	mov	x21, x2
	mov	x20, x1
	mov	x19, x0
Ltmp50:
	add	x0, sp, #8
	mov	x1, x19
	bl	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEE6sentryC1ERS3_
Ltmp51:
; %bb.1:
	ldrb	w8, [sp, #8]
	cbz	w8, LBB5_10
; %bb.2:
	ldr	x8, [x19]
	ldur	x8, [x8, #-24]
	add	x22, x19, x8
	ldr	x23, [x22, #40]
	ldr	w25, [x22, #8]
	ldr	w24, [x22, #144]
	cmn	w24, #1
	b.ne	LBB5_7
; %bb.3:
Ltmp53:
	add	x8, sp, #24
	mov	x0, x22
	bl	__ZNKSt3__18ios_base6getlocEv
Ltmp54:
; %bb.4:
Ltmp55:
Lloh20:
	adrp	x1, __ZNSt3__15ctypeIcE2idE@GOTPAGE
Lloh21:
	ldr	x1, [x1, __ZNSt3__15ctypeIcE2idE@GOTPAGEOFF]
	add	x0, sp, #24
	bl	__ZNKSt3__16locale9use_facetERNS0_2idE
Ltmp56:
; %bb.5:
	ldr	x8, [x0]
	ldr	x8, [x8, #56]
Ltmp57:
	mov	w1, #32
	blr	x8
Ltmp58:
; %bb.6:
	mov	x24, x0
	add	x0, sp, #24
	bl	__ZNSt3__16localeD1Ev
	str	w24, [x22, #144]
LBB5_7:
	add	x3, x20, x21
	mov	w8, #176
	and	w8, w25, w8
	cmp	w8, #32
	csel	x2, x3, x20, eq
Ltmp60:
	sxtb	w5, w24
	mov	x0, x23
	mov	x1, x20
	mov	x4, x22
	bl	__ZNSt3__116__pad_and_outputIcNS_11char_traitsIcEEEENS_19ostreambuf_iteratorIT_T0_EES6_PKS4_S8_S8_RNS_8ios_baseES4_
Ltmp61:
; %bb.8:
	cbnz	x0, LBB5_10
; %bb.9:
	ldr	x8, [x19]
	ldur	x8, [x8, #-24]
	add	x0, x19, x8
	ldr	w8, [x0, #32]
	mov	w9, #5
	orr	w1, w8, w9
Ltmp63:
	bl	__ZNSt3__18ios_base5clearEj
Ltmp64:
LBB5_10:
	add	x0, sp, #8
	bl	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEE6sentryD1Ev
LBB5_11:
	mov	x0, x19
	ldp	x29, x30, [sp, #96]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #80]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #64]             ; 16-byte Folded Reload
	ldp	x24, x23, [sp, #48]             ; 16-byte Folded Reload
	ldp	x26, x25, [sp, #32]             ; 16-byte Folded Reload
	add	sp, sp, #112
	ret
LBB5_12:
Ltmp65:
	b	LBB5_15
LBB5_13:
Ltmp59:
	mov	x20, x0
	add	x0, sp, #24
	bl	__ZNSt3__16localeD1Ev
	b	LBB5_16
LBB5_14:
Ltmp62:
LBB5_15:
	mov	x20, x0
LBB5_16:
	add	x0, sp, #8
	bl	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEE6sentryD1Ev
	b	LBB5_18
LBB5_17:
Ltmp52:
	mov	x20, x0
LBB5_18:
	mov	x0, x20
	bl	___cxa_begin_catch
	ldr	x8, [x19]
	ldur	x8, [x8, #-24]
	add	x0, x19, x8
Ltmp66:
	bl	__ZNSt3__18ios_base33__set_badbit_and_consider_rethrowEv
Ltmp67:
; %bb.19:
	bl	___cxa_end_catch
	b	LBB5_11
LBB5_20:
Ltmp68:
	mov	x19, x0
Ltmp69:
	bl	___cxa_end_catch
Ltmp70:
; %bb.21:
	mov	x0, x19
	bl	__Unwind_Resume
LBB5_22:
Ltmp71:
	bl	___clang_call_terminate
	.loh AdrpLdrGot	Lloh20, Lloh21
Lfunc_end3:
	.cfi_endproc
	.section	__TEXT,__gcc_except_tab
	.p2align	2
GCC_except_table5:
Lexception3:
	.byte	255                             ; @LPStart Encoding = omit
	.byte	155                             ; @TType Encoding = indirect pcrel sdata4
	.uleb128 Lttbase0-Lttbaseref0
Lttbaseref0:
	.byte	1                               ; Call site Encoding = uleb128
	.uleb128 Lcst_end3-Lcst_begin3
Lcst_begin3:
	.uleb128 Ltmp50-Lfunc_begin3            ; >> Call Site 1 <<
	.uleb128 Ltmp51-Ltmp50                  ;   Call between Ltmp50 and Ltmp51
	.uleb128 Ltmp52-Lfunc_begin3            ;     jumps to Ltmp52
	.byte	1                               ;   On action: 1
	.uleb128 Ltmp53-Lfunc_begin3            ; >> Call Site 2 <<
	.uleb128 Ltmp54-Ltmp53                  ;   Call between Ltmp53 and Ltmp54
	.uleb128 Ltmp62-Lfunc_begin3            ;     jumps to Ltmp62
	.byte	1                               ;   On action: 1
	.uleb128 Ltmp55-Lfunc_begin3            ; >> Call Site 3 <<
	.uleb128 Ltmp58-Ltmp55                  ;   Call between Ltmp55 and Ltmp58
	.uleb128 Ltmp59-Lfunc_begin3            ;     jumps to Ltmp59
	.byte	1                               ;   On action: 1
	.uleb128 Ltmp60-Lfunc_begin3            ; >> Call Site 4 <<
	.uleb128 Ltmp61-Ltmp60                  ;   Call between Ltmp60 and Ltmp61
	.uleb128 Ltmp62-Lfunc_begin3            ;     jumps to Ltmp62
	.byte	1                               ;   On action: 1
	.uleb128 Ltmp63-Lfunc_begin3            ; >> Call Site 5 <<
	.uleb128 Ltmp64-Ltmp63                  ;   Call between Ltmp63 and Ltmp64
	.uleb128 Ltmp65-Lfunc_begin3            ;     jumps to Ltmp65
	.byte	1                               ;   On action: 1
	.uleb128 Ltmp64-Lfunc_begin3            ; >> Call Site 6 <<
	.uleb128 Ltmp66-Ltmp64                  ;   Call between Ltmp64 and Ltmp66
	.byte	0                               ;     has no landing pad
	.byte	0                               ;   On action: cleanup
	.uleb128 Ltmp66-Lfunc_begin3            ; >> Call Site 7 <<
	.uleb128 Ltmp67-Ltmp66                  ;   Call between Ltmp66 and Ltmp67
	.uleb128 Ltmp68-Lfunc_begin3            ;     jumps to Ltmp68
	.byte	0                               ;   On action: cleanup
	.uleb128 Ltmp67-Lfunc_begin3            ; >> Call Site 8 <<
	.uleb128 Ltmp69-Ltmp67                  ;   Call between Ltmp67 and Ltmp69
	.byte	0                               ;     has no landing pad
	.byte	0                               ;   On action: cleanup
	.uleb128 Ltmp69-Lfunc_begin3            ; >> Call Site 9 <<
	.uleb128 Ltmp70-Ltmp69                  ;   Call between Ltmp69 and Ltmp70
	.uleb128 Ltmp71-Lfunc_begin3            ;     jumps to Ltmp71
	.byte	1                               ;   On action: 1
	.uleb128 Ltmp70-Lfunc_begin3            ; >> Call Site 10 <<
	.uleb128 Lfunc_end3-Ltmp70              ;   Call between Ltmp70 and Lfunc_end3
	.byte	0                               ;     has no landing pad
	.byte	0                               ;   On action: cleanup
Lcst_end3:
	.byte	1                               ; >> Action Record 1 <<
                                        ;   Catch TypeInfo 1
	.byte	0                               ;   No further actions
	.p2align	2
                                        ; >> Catch TypeInfos <<
	.long	0                               ; TypeInfo 1
Lttbase0:
	.p2align	2
                                        ; -- End function
	.section	__TEXT,__text,regular,pure_instructions
	.private_extern	__ZNSt3__116__pad_and_outputIcNS_11char_traitsIcEEEENS_19ostreambuf_iteratorIT_T0_EES6_PKS4_S8_S8_RNS_8ios_baseES4_ ; -- Begin function _ZNSt3__116__pad_and_outputIcNS_11char_traitsIcEEEENS_19ostreambuf_iteratorIT_T0_EES6_PKS4_S8_S8_RNS_8ios_baseES4_
	.globl	__ZNSt3__116__pad_and_outputIcNS_11char_traitsIcEEEENS_19ostreambuf_iteratorIT_T0_EES6_PKS4_S8_S8_RNS_8ios_baseES4_
	.weak_def_can_be_hidden	__ZNSt3__116__pad_and_outputIcNS_11char_traitsIcEEEENS_19ostreambuf_iteratorIT_T0_EES6_PKS4_S8_S8_RNS_8ios_baseES4_
	.p2align	2
__ZNSt3__116__pad_and_outputIcNS_11char_traitsIcEEEENS_19ostreambuf_iteratorIT_T0_EES6_PKS4_S8_S8_RNS_8ios_baseES4_: ; @_ZNSt3__116__pad_and_outputIcNS_11char_traitsIcEEEENS_19ostreambuf_iteratorIT_T0_EES6_PKS4_S8_S8_RNS_8ios_baseES4_
Lfunc_begin4:
	.cfi_startproc
	.cfi_personality 155, ___gxx_personality_v0
	.cfi_lsda 16, Lexception4
; %bb.0:
	sub	sp, sp, #112
	stp	x26, x25, [sp, #32]             ; 16-byte Folded Spill
	stp	x24, x23, [sp, #48]             ; 16-byte Folded Spill
	stp	x22, x21, [sp, #64]             ; 16-byte Folded Spill
	stp	x20, x19, [sp, #80]             ; 16-byte Folded Spill
	stp	x29, x30, [sp, #96]             ; 16-byte Folded Spill
	add	x29, sp, #96
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	.cfi_offset w19, -24
	.cfi_offset w20, -32
	.cfi_offset w21, -40
	.cfi_offset w22, -48
	.cfi_offset w23, -56
	.cfi_offset w24, -64
	.cfi_offset w25, -72
	.cfi_offset w26, -80
	mov	x19, x0
	cbz	x0, LBB6_15
; %bb.1:
	mov	x24, x5
	mov	x20, x4
	mov	x22, x3
	mov	x21, x2
	ldr	x8, [x4, #24]
	sub	x9, x3, x1
	subs	x8, x8, x9
	csel	x23, x8, xzr, gt
	sub	x25, x2, x1
	cmp	x25, #1
	b.lt	LBB6_3
; %bb.2:
	ldr	x8, [x19]
	ldr	x8, [x8, #96]
	mov	x0, x19
	mov	x2, x25
	blr	x8
	cmp	x0, x25
	b.ne	LBB6_14
LBB6_3:
	cmp	x23, #1
	b.lt	LBB6_11
; %bb.4:
	cmp	x23, #23
	b.hs	LBB6_6
; %bb.5:
	add	x25, sp, #8
	strb	w23, [sp, #31]
	b	LBB6_7
LBB6_6:
	add	x8, x23, #16
	and	x26, x8, #0xfffffffffffffff0
	mov	x0, x26
	bl	__Znwm
	mov	x25, x0
	orr	x8, x26, #0x8000000000000000
	stp	x23, x8, [sp, #16]
	str	x0, [sp, #8]
LBB6_7:
	mov	x0, x25
	mov	x1, x24
	mov	x2, x23
	bl	_memset
	strb	wzr, [x25, x23]
	ldrsb	w8, [sp, #31]
	ldr	x9, [sp, #8]
	cmp	w8, #0
	add	x8, sp, #8
	csel	x1, x9, x8, lt
	ldr	x8, [x19]
	ldr	x8, [x8, #96]
Ltmp72:
	mov	x0, x19
	mov	x2, x23
	blr	x8
Ltmp73:
; %bb.8:
	mov	x24, x0
	ldrsb	w8, [sp, #31]
	tbnz	w8, #31, LBB6_10
; %bb.9:
	cmp	x24, x23
	b.ne	LBB6_14
	b	LBB6_11
LBB6_10:
	ldr	x0, [sp, #8]
	bl	__ZdlPv
	cmp	x24, x23
	b.ne	LBB6_14
LBB6_11:
	sub	x22, x22, x21
	cmp	x22, #1
	b.lt	LBB6_13
; %bb.12:
	ldr	x8, [x19]
	ldr	x8, [x8, #96]
	mov	x0, x19
	mov	x1, x21
	mov	x2, x22
	blr	x8
	cmp	x0, x22
	b.ne	LBB6_14
LBB6_13:
	str	xzr, [x20, #24]
	b	LBB6_15
LBB6_14:
	mov	x19, #0
LBB6_15:
	mov	x0, x19
	ldp	x29, x30, [sp, #96]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #80]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #64]             ; 16-byte Folded Reload
	ldp	x24, x23, [sp, #48]             ; 16-byte Folded Reload
	ldp	x26, x25, [sp, #32]             ; 16-byte Folded Reload
	add	sp, sp, #112
	ret
LBB6_16:
Ltmp74:
	mov	x19, x0
	ldrsb	w8, [sp, #31]
	tbz	w8, #31, LBB6_18
; %bb.17:
	ldr	x0, [sp, #8]
	bl	__ZdlPv
LBB6_18:
	mov	x0, x19
	bl	__Unwind_Resume
Lfunc_end4:
	.cfi_endproc
	.section	__TEXT,__gcc_except_tab
	.p2align	2
GCC_except_table6:
Lexception4:
	.byte	255                             ; @LPStart Encoding = omit
	.byte	255                             ; @TType Encoding = omit
	.byte	1                               ; Call site Encoding = uleb128
	.uleb128 Lcst_end4-Lcst_begin4
Lcst_begin4:
	.uleb128 Lfunc_begin4-Lfunc_begin4      ; >> Call Site 1 <<
	.uleb128 Ltmp72-Lfunc_begin4            ;   Call between Lfunc_begin4 and Ltmp72
	.byte	0                               ;     has no landing pad
	.byte	0                               ;   On action: cleanup
	.uleb128 Ltmp72-Lfunc_begin4            ; >> Call Site 2 <<
	.uleb128 Ltmp73-Ltmp72                  ;   Call between Ltmp72 and Ltmp73
	.uleb128 Ltmp74-Lfunc_begin4            ;     jumps to Ltmp74
	.byte	0                               ;   On action: cleanup
	.uleb128 Ltmp73-Lfunc_begin4            ; >> Call Site 3 <<
	.uleb128 Lfunc_end4-Ltmp73              ;   Call between Ltmp73 and Lfunc_end4
	.byte	0                               ;     has no landing pad
	.byte	0                               ;   On action: cleanup
Lcst_end4:
	.p2align	2
                                        ; -- End function
	.globl	_counter                        ; @counter
.zerofill __DATA,__common,_counter,8,3
	.section	__TEXT,__cstring,cstring_literals
l_.str:                                 ; @.str
	.asciz	"All threads completed.\n"

l_.str.1:                               ; @.str.1
	.asciz	"Expected: "

l_.str.2:                               ; @.str.2
	.asciz	". Got: "

l_.str.4:                               ; @.str.4
	.asciz	"thread constructor failed"

.subsections_via_symbols
