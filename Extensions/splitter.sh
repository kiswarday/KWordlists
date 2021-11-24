#! /bin/sh

if [ ! -f "$1" ]
then
	echo "Source file not supplied"
	exit 1
fi
src_file=$1

echo 'To work properly, all EOL (in the source file) will be converted to LF'
read -p "Press Y to continue: " choice
if [ "$choice" != "Y" ] && [ "$choice" != "y" ]
then
	exit 1
fi

tmp_src_file="ktmp_src_sorted.txt"
tmp_src_file_EOL="ktmp_src_sorted_EOL.txt"
content_types_file="content-types.txt"
extensions_file="extensions.txt"

#sort and remove duplicate
sort $src_file | uniq > $tmp_src_file

#convert EOL
sed "s/\r$//" $tmp_src_file > $tmp_src_file_EOL

#splitting src_file => extensions + content-types
sed "s/^[0-9A-Za-z]* //" $tmp_src_file_EOL > $content_types_file
sed "s/ .*$//" $tmp_src_file_EOL > $extensions_file

#delete tmp files
rm $tmp_src_file
mv $tmp_src_file_EOL $src_file