;------------------------------------------------------------------------;
; Introduction to cosmology - Computer assignment for advanced students
;------------------------------------------------------------------------;

;  PART II - modified benchmark model

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

pro advanced_part2

; Solve the first Friedmann equation for a multi-component universe,
; and plot the results as (log(a),log(h0*t))

;------------------------------------------------------------------------;
; Constants
;------------------------------------------------------------------------;

; Relative energy densities (divided by critical density)

; Radiation:
om_r0=8.4d0*10^(-5.d0)
; Mass:
om_m0=0.3d0
; Cosmological constant:
om_l0=0.d0
; Total:
om_0=om_r0+om_m0+om_l0

; Important epochs (as log(a))

; Radiation-matter equality is the same as in benchmark model
a_rm=alog10(om_r0/om_m0)
;print,a_rm

; Matter-cosmological constant equality doesn't exist in this version
;a_ml=alog10(om_m0/om_l0)

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


;---------------------------------------------------------------------;
; Plot the results as (log(H0t),log(a))
;---------------------------------------------------------------------;

aa=alog10(a)
hh0t=alog10(h0t)

;nwin
;plot_stamp,'advanced_part2'
plot,hh0t,aa,title='Part 2) No cosmological constant; curved universe',xtitle="!6log(H!I0!Nt!X)",ytitle="!6log(a)!X",xrange=[-10,1],yrange=[-6,2]

;---------------------------------------------------------------------;
; Present moment t=t0, a=1 -> log(a)=0
;---------------------------------------------------------------------;
oplot,[-10,-0.1],[0,0],linestyle=1
oplot,[-0.1,-0.1],[0,-6],linestyle=1
xyouts, 0.1,-3, '!3t!I0', charsize=1.5

;---------------------------------------------------------------------;
; Radiation - matter equality t=t_rm, a=a_rm
;---------------------------------------------------------------------;
; Is the same as in the benchmark model

oplot,[-10,-5.5],[a_rm,a_rm],linestyle=1
oplot,[-5.5,-5.5],[a_rm,-6],linestyle=1
xyouts, -5.4,-5, '!3t!Ir-m', charsize=1.5

;--------------------------------------------------------------------;
; Matter - cosmological constant equality t=t_ml, a=a_ml
;--------------------------------------------------------------------;
; Doesn't exist in this version of the universe

;--------------------------------------------------------------------;
; Matter - curvature equality t=t_mc, a=a_mc
;--------------------------------------------------------------------;
;The universe behaves as if it had an additional component.
;Negative curvature -> positive energy density.

a_mc=alog10(om_m0/(1-om_0))
print,'a_mc'
print,a_mc

oplot,[-10,-0.55],[a_mc,a_mc],linestyle=1
oplot,[-0.55,-0.55],[a_mc,-6],linestyle=1
xyouts, -1.1,-4, '!3t!Im-!9k!X!N', charsize=1.5

end

;--------------------------------------------------------------------;
; Save the results to a PostScript file using PsPlot
;--------------------------------------------------------------------;

pro Plot_everything2
PsPlot, 'advanced_part2', 'advanced_part2.ps'
end
