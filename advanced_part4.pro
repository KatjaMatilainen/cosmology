;------------------------------------------------------------------------;
; Introduction to cosmology - Computer assignment for advanced students
;------------------------------------------------------------------------;

;  PART IV

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

pro advanced_part4

end

;--------------------------------------------------------------------;
; Save the results to a PostScript file using PsPlot
;--------------------------------------------------------------------;

pro Plot_everything4
PsPlot, 'advanced_part4', 'advanced_part4.ps'
end
