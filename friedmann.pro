;------------------------------------------------------------------;
; friedmann.pro
;------------------------------------------------------------------;

; Description:

; Function for solving the first Friedmann equation for a
; multi-component universe.
; Creates vector a and solves h0t for those values of a.
; Uses given values for energy densities in solving the 
; 1st Friedmann equation.

; Input: 
;   relative energy densities as a vector
;   (om_r0,om_m0,om_l0)
; = (radiation, mass, cosmological constant)

; Output: array (h0t,a)
;--------------------------------------------------------------------;

function friedmann,densities

;Take relative energy densities from the input
;Radiation
om_r0=densities(0)
;Mass
om_m0=densities(1)
;Cosmological constant
om_l0=densities(2)
;Total:
om_0=om_r0+om_m0+om_l0

;----------------------------------------------------------------------;
; Scale factor:
;----------------------------------------------------------------------;

; Reduce the total steps needed by increasing stepsize as a increases.

; For the purpose of the last cosmology exercises, I will modify a so 
; that it  ends at the present time a=1.
; This is useful for determining lookback times.
; If you want to use the program for other purposes, just uncomment
; the missing parts of a, and of course, choose the latter option of
; a4 and a (I wanted the final value of a to be exactly a=1).

; Between a=0 and a=0.001 (1000 steps)
a1=findgen(1000)*0.000001d0
; Between a=0.001 and a=0.01 (900 steps)
a2=findgen(900)*0.00001d0+0.001d
; Between a=0.01 and a=0.1 (900 steps)
a3=findgen(900)*0.0001d0+0.01d0
; Between a=0.1 and a=1 (901 steps)
a4=findgen(901)*0.001d0+0.1d0

; Between a=0.1 and a=1 (900 steps)
;a4=findgen(900)*0.001d0+0.1d0
; Between a=1 and a=10 (900 steps)
;a5=findgen(900)*0.01d0+1.d0
; Between a=10 and a=100 (900 steps)
;a6=findgen(900)*0.1d0+10.d0

; Different parts combined:
a=[a1,a2,a3,a4]
;a=[a1,a2,a3,a4,a5,a6]

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

;Result array is [[h0t],[a]]
result=[[h0t],[a]]

return,result

end
