FILES=`find ./ -name "*.tex" -not -name '__latexindent_temp.tex'`
result=''
for file in $FILES;do
    result=$result$file' '
done
echo $result
latexindent $result -c=/workdir/backups -l -w -s -rv