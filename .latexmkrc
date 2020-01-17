# Search for files in ./figs and its subdirectories
ensure_path('TEXINPUTS','./figs//');

# Always treat bbl files as regeneratable (can be cleaned up).
$bibtex_use = 2;

# Used to generate pdf_tex files from pdf via inkscape
add_cus_dep('svg','pdf_tex',0,'svg2pdf');
sub svg2pdf {
    system("echo $_[0]; inkscape -D -z --file=$_[0].svg --export-pdf=$_[0].pdf --export-latex");
}

# https://tex.stackexchange.com/a/44316/194524 - make glossaries
add_cus_dep('glo', 'gls', 0, 'run_makeglossaries');
add_cus_dep('acn', 'acr', 0, 'run_makeglossaries');

sub run_makeglossaries {
  if ( $silent ) {
    system "makeglossaries -q '$_[0]'";
  }
  else {
    system "makeglossaries '$_[0]'";
  };
}

push @generated_exts, 'glo', 'gls', 'glg';
push @generated_exts, 'acn', 'acr', 'alg';
push @generated_exts, 'pdf_tex', 'nav', 'run.xml', 'snm';
$clean_ext .= ' %R.ist %R.xdy';
$clean_ext .= ' %R.bbl %R.run.xml';
