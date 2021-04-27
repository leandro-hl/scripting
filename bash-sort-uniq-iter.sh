MY_FILE=processes;
touch $MY_FILE.txt
for i in {0..2}
do
    pgrep 'bash' >> $MY_FILE.txt
done
sort -r $MY_FILE.txt | uniq | cat > result.txt
vim result.txt