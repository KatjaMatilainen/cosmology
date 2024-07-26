;------------------------------------------------------------------------;
; Introduction to cosmology - Computer assignment for advanced students
;------------------------------------------------------------------------;

;  PART I

;------------------------------------------------------------------------;
; Use the subroutine PsPlot to save results in a postscript plot 
; (written by Heikki Salo)
;------------------------------------------------------------------------;

pro PsPlot,routine,filename
	thisdir=getenv('PWD')+'/'
	psopen,/color,dir=thisdir,filename
	call_procedure,routine
	psclose		
end
;------------------------------------------------------------------------;


;------------------------------------------------------------------------;
;  MAIN PROGRAM starts here
;------------------------------------------------------------------------;

pro advanced_part1

; Solve the first Friedmann equation for a multi-component universe,
; and plot the results as (log(a),log(h0*t))

;------------------------------------------------------------------------;
; Constants (use the benchmark model first)
;------------------------------------------------------------------------;

; Relative energy densities (divided by critical density)

; Radiation:
om_r0=8.4d0*10^(-5.d0)
; Mass:
om_m0=0.3d0
; Cosmological constant:
om_l0=0.7d0
; Total:
om_0=om_r0+om_m0+om_l0

; Important epochs (as log(a))

; Radiation-matter equality
a_rm=alog10(0.00028d0)
;print,'a_rm'
;print,a_rm
; Matter-cosmological constant equality
a_ml=alog10(0.75d0)
;print,'a_ml'
;print,a_ml

;----------------------------------------------------------------------;
; Scale factor:
;----------------------------------------------------------------------;

; Reduce the total steps needed by increasing stepsize as a increases.

; Between a=0 and a=0.001 (1000 steps)
a1=findgen(1000)*0.000001d0
; Between a=0.001 and a=0.01 (900 steps)
a2=findgen(900)*0.00001d0+0.001d
; Between a=0.01 and a=0.1 (900 steps)
a3=findgen(900)*0.0001d0+0.01d0
; Between a=0.1 and a=1 (900 steps)
a4=findgen(900)*0.001d0+0.1d0
; Between a=1 and a=10 (900 steps)
a5=findgen(900)*0.01d0+1.d0
; Between a=10 and a=100 (900 steps)
a6=findgen(900)*0.1d0+10.d0

; Different parts combined:
a=[a1,a2,a3,a4,a5,a6]
print,n_elements(a)
print,a

;----------------------------------------------------------------------;
; Time:
;----------------------------------------------------------------------;
n=n_elements(a)
h0t=findgen(n)*0.0d0

;----------------------------------------------------------------------;
; H-L law
;----------------------------------------------------------------------;

;Make a loop that solves h0t[n] from a[n] and saves the results to
;the vector h0t

;Starting values
i=1
h0t[0]=0.0d0

; The loop:
while i lt n do begin
; Define da
   da=a[i]-a[i-1]
; Use midpoint rule for a
   a_temp=(a[i]+a[i-1])/2.d0
; Actual equation
   h0t[i]=h0t[i-1] + (om_r0/a_temp^2+om_m0/a_temp+om_l0*a_temp^2+(1-om_0))^(-1/2.d0)*da
; Increase index i
   i=i+1
endwhile

print,h0t

;---------------------------------------------------------------------;
; Plot the results as (log(H0t),log(a))
;---------------------------------------------------------------------;

aa=alog10(a)
hh0t=alog10(h0t)

;nwin
;plot_stamp,'advanced_part1'
plot,hh0t,aa,title='Part 1) Benchmark model of the universe',xtitle="!6log(H!I0!Nt!X)",ytitle="!6log(a)!X",xrange=[-10,1],yrange=[-6,2]

;---------------------------------------------------------------------;
; Present moment t=t0, a=1 -> log(a)=0
;---------------------------------------------------------------------;
oplot,[-10,0],[0,0],linestyle=1
oplot,[0,0],[0,-6],linestyle=1
xyouts, 0.1,-2, '!3t!I0', charsize=1.5

;---------------------------------------------------------------------;
; Radiation - matter equality t=t_rm, a=a_rm
;---------------------------------------------------------------------;

oplot,[-10,-5.5],[a_rm,a_rm],linestyle=1
oplot,[-5.5,-5.5],[a_rm,-6],linestyle=1
xyouts, -5.4,-5, '!3t!Ir-m', charsize=1.5

;--------------------------------------------------------------------;
; Matter - cosmological constant equality t=t_ml, a=a_ml
;--------------------------------------------------------------------;

oplot,[-10,-0.15],[a_ml,a_ml],linestyle=1
oplot,[-0.15,-0.15],[a_ml,-6],linestyle=1

;Greek letters don't function well with psplot, so in IDL the
;result looks weird. In the ps file lambda is correctly displayed.
;Swap !9L to !4K for IDL.

xyouts, -0.6,-3, '!3t!Im-!9L!X', charsize=1.5

end

;--------------------------------------------------------------------;
; Save the results to a PostScript file using PsPlot
;--------------------------------------------------------------------;

pro Plot_everything
PsPlot, 'advanced_part1', 'advanced_part1.ps'
end
