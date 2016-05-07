#Given a text file file.txt, transpose its content.

#You may assume that each row has the same number of columns and each field is separated by the ' ' character.

#For example, if file.txt has the following content:

#name age
#alice 21
#ryan 30
#Output the following:

#name alice ryan
#age 21 30
#Subscribe to see which companies asked this question

echo 'ryan 30\nname age' | tee >( cut -d' ' -f1 | tr '\n' ' '; echo '\n') |  cut -d' ' -f2 | tr '\n' ' '
 for f in 1 2  ; do cut -d ' ' -f $f foo | xargs echo ; done

#NF is number of field NR is current field
awk '
{
    for (i = 1; i <= NF; i++) {
        if(NR == 1) {
            s[i] = $i;
        } else {
            s[i] = s[i] " " $i;
        }
    }
}
END {
    for (i = 1; s[i] != ""; i++) {
        print s[i];
    }
}' foo
