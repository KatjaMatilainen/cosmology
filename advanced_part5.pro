;------------------------------------------------------------------------;
; Introduction to cosmology - Computer assignment for advanced students
;------------------------------------------------------------------------;

;  PART V

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

; Plot the lookback time (t0-te) as a function of redshift z for the
; four models that were computed in parts 1-3 of the assignment.

pro advanced_part5

;------------------------------------------------------------------------;
;  Constant(s)
;------------------------------------------------------------------------;
;H-L constant (km/Mpc)/s
;h0=70

;Can't use 1/s unit, in which h0 would be
;h0=70.d0/(3.08567756d0)*10^(-19)
;so a unit transformation is needed at a later point when solving times

; Use 10^(-19) 1/s as the unit
h0=70.d0/(3.08567756d0)

;------------------------------------------------------------------------;
;  1st Friedmann equation
;------------------------------------------------------------------------;
; Use the function 'friedmann' to solve the first Friedmann equation
; for different universes.
; Input: vector of relative energy densities [om_r0,om_m0,om_l0]
; Output: array result=[[h0t],[a]]

;-----------------------------------------------------------------------;
; 1st Friedmann) First model: benchmark
;-----------------------------------------------------------------------;
; Radiation:
om_r01=8.4d0*10^(-5.d0)
; Mass:
om_m01=0.3d0
; Cosmological constant:
om_l01=0.7d0

result1=friedmann([om_r01,om_m01,om_l01])

;Separate a and h0t from each other
h0t1=result1[*,0]
a1=result1[*,1]

;-----------------------------------------------------------------------;
;  1st Friedmann) Second model: no cosmological constant
;-----------------------------------------------------------------------;
; Radiation:
om_r02=8.4d0*10^(-5.d0)
; Mass:
om_m02=0.3d0
; Cosmological constant:
om_l02=0.d0

result2=friedmann([om_r02,om_m02,om_l02])

;Separate a and h0t from each other
h0t2=result2[*,0]
a2=result2[*,1]

;-----------------------------------------------------------------------;
;  1st Friedmann) Third model
;-----------------------------------------------------------------------;
; Radiation:
om_r03=8.4d0*10^(-5.d0)
; Mass:
om_m03=0.32d0
; Cosmological constant:
om_l03=0.7d0

result3=friedmann([om_r03,om_m03,om_l03])

;Separate a and h0t from each other
h0t3=result3[*,0]
a3=result3[*,1]

;-----------------------------------------------------------------------;
;  1st Friedmann) Fourth model
;-----------------------------------------------------------------------;
; Radiation:
om_r04=8.4d0*10^(-5.d0)
; Mass:
om_m04=0.3d0
; Cosmological constant:
om_l04=0.72d0

result4=friedmann([om_r04,om_m04,om_l04])

;Separate a and h0t from each other
h0t4=result4[*,0]
a4=result4[*,1]

;-----------------------------------------------------------------------;
;  Lookback time (t0-te)
;-----------------------------------------------------------------------;
;-----------------------------------------------------------------------;
; Times of emission te are taken from h0t -vectors
;-----------------------------------------------------------------------;

; First model (benchmark)
te1=h0t1/h0

;Second model
te2=h0t2/h0

;Third model
te3=h0t3/h0

;Fourth model
te4=h0t4/h0

;-----------------------------------------------------------------------;
; Present time t0 is when a=1
;-----------------------------------------------------------------------;
; Last element of vector a is a=1, so the present time t0 is the last 
; element  of the corresponding time vector te.

index=n_elements(a1)-1

;First model
t01=te1[index]
;Second model
t02=te2[index]
;Third model
t03=te3[index]
;Fourth model
t04=te4[index]

;--------------------------------------------------------------------;
; Redshift z for the different models
;--------------------------------------------------------------------;

; Redshift can be solved from a(te):
; (1+z)=a(t0)/a(te) -> z=1/a(te)-1
; Result is a vector of the same lenght as a and te.

; First model (benchmark)
z1=1.d0/a1-1

; 2nd model
z2=1.d0/a2-1

; 3rd model
z3=1.d0/a3-1

; 4th model
z4=1.d0/a4-1

;--------------------------------------------------------------------;
; Plot the lookback times (t0-te) as a function of redshift z
;--------------------------------------------------------------------;

; Note: the original unit for the times is 10^19 s because of the 
; chosen unit for H-L constant

; Change to Gy (10^9 years)
; 1 Gy = 10^9*365*24*60^2 s = 3.1536*10^16 s
; so 10^19 s = 317.0979198 Gy

;---------------------------------------------------------------------;
; First model: Benchmark
;---------------------------------------------------------------------;
t_lb1=(t01-te1)*317.0979198

nwin
plot,z1,t_lb1,title='Model 1) Benchmark',xtitle='z',ytitle='t!I0!N-t!Ie!N (Gyr)',xrange=[0,15],yrange=[0,15],charsize=1.5
oplot,[11.9,11.9],[0,13.1],linestyle=1
oplot,[0,11.9],[13.1,13.1],linestyle=1
xyouts, 5,13.5, '(t!I0!N-t!Ie!N)=13.1', charsize=1.5
xyouts, 12.1,7, 'z=11.9', charsize=1.5

;---------------------------------------------------------------------;
; Second model: om_l0=0
;---------------------------------------------------------------------;
t_lb2=(t02-te2)*317.0979198

nwin
plot,z2,t_lb2,title='Model 2) !9W!IL!X,0!N=0',xtitle='z',ytitle='t!I0!N-t!Ie!N (Gyr)',xrange=[0,15],yrange=[0,15],charsize=1.5
oplot,[11.9,11.9],[0,10.95],linestyle=1
oplot,[0,11.9],[10.95,10.95],linestyle=1
xyouts, 5,11.5, '(t!I0!N-t!Ie!N)=10.95', charsize=1.5
xyouts, 12.1,7, 'z=11.9', charsize=1.5

;---------------------------------------------------------------------;
; Third model: om_m0=0.32,om_l0=0.7
;---------------------------------------------------------------------;
t_lb3=(t03-te3)*317.0979198

nwin
plot,z3,t_lb3,title='Model 3) !9W!I!Xm,0!N=0.32, !9W!IL!X,0!N=0.7',xtitle='z',ytitle='t!I0!N-t!Ie!N (Gyr)',xrange=[0,15],yrange=[0,15],charsize=1.5
oplot,[11.9,11.9],[0,12.95],linestyle=1
oplot,[0,11.9],[12.95,12.95],linestyle=1
xyouts, 5,13.4, '(t!I0!N-t!Ie!N)=12.95', charsize=1.5
xyouts, 12.1,7, 'z=11.9', charsize=1.5

;---------------------------------------------------------------------;
; Fourth model: om_m0=0.3,om_l0=0.72
;---------------------------------------------------------------------;
t_lb4=(t04-te4)*317.0979198

nwin
plot,z4,t_lb4,title='Model 4) !9W!I!Xm,0!N=0.3, !9W!IL!X,0!N=0.72',xtitle='z',ytitle='t!I0!N-t!Ie!N (Gyr)',xrange=[0,15],yrange=[0,15],charsize=1.5
oplot,[11.9,11.9],[0,13.2],linestyle=1
oplot,[0,11.9],[13.2,13.2],linestyle=1
xyouts, 5,13.5, '(t!I0!N-t!Ie!N)=13.2', charsize=1.5
xyouts, 12.1,7, 'z=11.9', charsize=1.5

end

;--------------------------------------------------------------------;
; Save the results to a PostScript file using PsPlot
;--------------------------------------------------------------------;

pro Plot_everything5
PsPlot, 'advanced_part5', 'advanced_part5.ps'
end
