function! SetTabWidth(tabwidth, noexpand)
  exec "setlocal tabstop=". a:tabwidth
  exec "setlocal softtabstop=". a:tabwidth
  exec "setlocal shiftwidth=". a:tabwidth
  exec "setlocal breakindentopt=shift:". a:tabwidth

  if a:noexpand
    setlocal list listchars=tab:\ \ ,trail:·
    setlocal noexpandtab
	else
		setlocal list listchars=tab:→\ ,trail:·
    setlocal expandtab
	endif	
endfunction
