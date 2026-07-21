$pdf_mode = 1;
$do_cd = 1;
$ENV{'TEXINPUTS'} = '..:' . ($ENV{'TEXINPUTS'} // '');
@default_files = ('EN/*.tex', 'DE/*.tex');
