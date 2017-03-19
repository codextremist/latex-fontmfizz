#!/bin/sh

# Copyright 2017 Felipe Jordão A.P Mattosinho
# This work may be distributed and/or modified under the
# conditions of the MIT License, available at
# http://opensource.org/licenses/MIT.

rm -f ./dist/*

cat << EOF > ./dist/fontmfizz.sty
%% start of file 'fontmfizz.sty'.
%% Copyright 2014 Kevin Dungs (kevin.dungs@gmail.com).
%
% This is inspired by the fontawesome.sty by Xavier Danaux
% See http://mirror.ctan.org/fonts/fontawesome/
%
% This work may be distributed and/or modified under the
% conditions of the MIT License, available at
% http://opensource.org/licenses/MIT.

\NeedsTeXFormat{LaTeX2e}
\ProvidesPackage{fontmfizz}[2014/12/23]

\usepackage{fontspec}

\newfontfamily{\MF}{font-mfizz}
\newcommand*{\mficon}[1]{%
  {FA\csname mficon@#1\endcsname}}

EOF

cat ./font-mfizz/dist/font-mfizz.css | sed -rn 's/\.icon-([a-z0-9A-Z-]*):before \{ content: "\\f(.*)"; \}/\1,\2/p' >> ./dist/tmp

cat ./dist/tmp | perl -pe 's/(([^-,]{1})([^-,]*)(?:-([^-,]{1})([^-,]+))?(?:-([^-,]{1})([^-,]+))?(?:-([^-,]{1})([^-,]+))?(?:-([^-,]{1})([^-,]+))?),(?<code>[a-z0-9]*)/\\expandafter\\def\\csname mficon@\1\\endcsname {\\symbol{"F\U$+{code}}} \L\\def\\mf\U\2\L\3\U\4\L\5\U\6\L\7\U\8\L\9 {{\U\\MF\L\\csname mficon@\1\\endcsname}}/' >> ./dist/fontmfizz.sty

rm ./dist/tmp
