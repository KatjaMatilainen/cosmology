;------------------------------------------------------------------------;
; Introduction to cosmology - Computer assignment for advanced students
;------------------------------------------------------------------------;

;  PART III - slightly modified benchmark model

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

pro advanced_part3

; Solve the first Friedmann equation for two slightly different 
; multi-component universes, and plot the results as (log(a),log(h0*t))

;------------------------------------------------------------------------;
; Constants
;------------------------------------------------------------------------;

; Relative energy densities (divided by critical density)

;Case 1)
; Radiation:
om_r01=8.4d0*10^(-5.d0)
; Mass:
om_m01=0.32d0
; Cosmological constant:
om_l01=0.7d0
; Total:
om_01=om_r01+om_m01+om_l01

;Case 2)
; Radiation:
om_r02=8.4d0*10^(-5.d0)
; Mass:
om_m02=0.3d0
; Cosmological constant:
om_l02=0.72d0
; Total:
om_02=om_r02+om_m02+om_l02

; Important epochs (as log(a))

;Case 1)
; Radiation-matter equality
a_rm1=alog10(om_r01/om_m01)
;print,'a_rm1'
;print,a_rm1
; Matter-cosmological constant equality
a_ml1=alog10((om_m01/om_l01)^(1.d0/3))
;print,'a_ml1'
;print,a_ml1

;Case 2)
; Radiation-matter equality
a_rm2=alog10(om_r02/om_m02)
;print,'a_rm2'
;print,a_rm2
; Matter-cosmological constant equality
a_ml2=alog10((om_m02/om_l02)^(1.d0/3))
;print,'a_ml2'
;print,a_ml2

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
h0t1=findgen(n)*0.0d0
h0t2=findgen(n)*0.0d0

;----------------------------------------------------------------------;
; H-L law
;----------------------------------------------------------------------;

;Make a loop that solves h0t[n] from a[n] and saves the results to
;the vector h0t

;----------------------------------------------------------------------;
; For case 1)
;----------------------------------------------------------------------;

;Starting values
i=1
h0t1[0]=0.0d0

; The loop:
while i lt n do begin
; Define da
   da=a[i]-a[i-1]
; Use midpoint rule for a
   a_temp=(a[i]+a[i-1])/2.d0
; Actual equation
   h0t1[i]=h0t1[i-1] + (om_r01/a_temp^2+om_m01/a_temp+om_l01*a_temp^2+(1-om_01))^(-1/2.d0)*da
; Increase index i
   i=i+1
endwhile

;----------------------------------------------------------------------;
; For case 2)
;----------------------------------------------------------------------;

;Starting values
j=1
h0t2[0]=0.0d0

; The loop:
while j lt n do begin
; Define da
   da=a[j]-a[j-1]
; Use midpoint rule for a
   a_temp=(a[j]+a[j-1])/2.d0
; Actual equation
   h0t2[j]=h0t2[j-1] + (om_r02/a_temp^2+om_m02/a_temp+om_l02*a_temp^2+(1-om_02))^(-1/2.d0)*da
; Increase index j
   j=j+1
endwhile

;---------------------------------------------------------------------;
; Plot the results as (log(H0t),log(a))
;---------------------------------------------------------------------;

aa=alog10(a)
hh0t1=alog10(h0t1)
hh0t2=alog10(h0t2)

;---------------------------------------------------------------------;
; Case 1)
;---------------------------------------------------------------------;
;Again, for postscript, you must use different input for greek letters.
;For IDL omega=!4X,lambda=!4K and for PS omega=!9W ,lambda=!9L

nwin
;plot_stamp,'advanced_part3a'
plot,hh0t1,aa,title='!5Part 3) - Case 1: !9W!X!I!5m,0!N=0.32, !9W!IL!X,0!N=0.7',xtitle="!6log(H!I0!Nt!X)",ytitle="!6log(a)!X",xrange=[-10,1],yrange=[-6,2]

;---------------------------------------------------------------------;
; Present moment t=t0, a=1 -> log(a)=0
;---------------------------------------------------------------------;
oplot,[-10,-0.015],[0,0],linestyle=1
oplot,[-0.015,-0.015],[0,-6],linestyle=1
xyouts, 0.1,-2, '!3t!I0', charsize=1.5

;---------------------------------------------------------------------;
; Radiation - matter equality t=t_rm, a=a_rm
;---------------------------------------------------------------------;

oplot,[-10,-5.55],[a_rm1,a_rm1],linestyle=1
oplot,[-5.55,-5.55],[a_rm1,-6],linestyle=1
xyouts, -5.4,-5, '!3t!Ir-m', charsize=1.5

print,a_rm1
;--------------------------------------------------------------------;
; Matter - cosmological constant equality t=t_ml, a=a_ml
;--------------------------------------------------------------------;

oplot,[-10,-0.15],[a_ml1,a_ml1],linestyle=1
oplot,[-0.15,-0.15],[a_ml1,-6],linestyle=1
xyouts, -0.6,-3, '!3t!Im-!9L!X', charsize=1.5

print,a_ml1
;--------------------------------------------------------------------;
; Case 2)
;--------------------------------------------------------------------;

;Again, for postscript, you must use different input for greek letters.
;For IDL omega=!4X,lambda=!4K and for PS omega=!9W ,lambda=!9L

nwin
;plot_stamp,'advanced_part3b'
plot,hh0t2,aa,title='!5Part 3) - Case 2: !9W!X!I!5m,0!N=0.3, !9W!IL!X,0!N=0.72',xtitle="!6log(H!I0!Nt!X)",ytitle="!6log(a)!X",xrange=[-10,1],yrange=[-6,2]

;---------------------------------------------------------------------;
; Present moment t=t0, a=1 -> log(a)=0
;---------------------------------------------------------------------;
oplot,[-10,0],[0,0],linestyle=1
oplot,[0,0],[0,-6],linestyle=1
xyouts, 0.1,-2, '!3t!I0', charsize=1.5

;---------------------------------------------------------------------;
; Radiation - matter equality t=t_rm, a=a_rm
;---------------------------------------------------------------------;

oplot,[-10,-5.5],[a_rm2,a_rm2],linestyle=1
oplot,[-5.5,-5.5],[a_rm2,-6],linestyle=1
xyouts, -5.4,-5, '!3t!Ir-m', charsize=1.5
print,a_rm2
;--------------------------------------------------------------------;
; Matter - cosmological constant equality t=t_ml, a=a_ml
;--------------------------------------------------------------------;

oplot,[-10,-0.15],[a_ml2,a_ml2],linestyle=1
oplot,[-0.15,-0.15],[a_ml2,-6],linestyle=1
xyouts, -0.6,-3, '!3t!Im-!9L!X', charsize=1.5
print,a_ml2

end

;--------------------------------------------------------------------;
; Save the results to a PostScript file using PsPlot
;--------------------------------------------------------------------;

pro Plot_everything3
PsPlot, 'advanced_part3', 'advanced_part3.ps'
end
