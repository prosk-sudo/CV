$pdf_mode = 1;
$do_cd = 1;
$ENV{'TEXINPUTS'} = getcwd() . ':' . getcwd() . '/images:' . ($ENV{'TEXINPUTS'} // '');
@default_files = ('*/*.tex', '*/*/*.tex');
