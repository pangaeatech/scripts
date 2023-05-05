#!/bin/sh

# Converts the specified tab-delimited text file(s) into SQL scripts which create a new table and loads it with the data

for input in "$@"; do
    table=`echo "$input" | sed -e 's/\.[^.]*$//' -e 's/[^a-zA-Z0-9]/_/g'`;
    rm -f $table.sql;
    echo "CREATE TABLE $table (" >> $table.sql;
    cat "$input" | head -1 | tr "\t" "\n" | tr -d "\r" | sed -e 's/[^a-zA-Z0-9]/_/g' -e 's/^/\t/' -e 's/$/\t\tvarchar(255)\tNOT NULL\tDEFAULT %%,/' | tr "%" "'" >> $table.sql;
    cat "$input" | head -1 | cut -f 1 | tr -d "\r" | sed -e 's/[^a-zA-Z0-9]/_/g' -e 's/^/\tPRIMARY KEY (/' -e 's/$/)/' >> $table.sql;
    echo ');' >> $table.sql;
    row=`cat "$input" | head -1 | tr -d "\r" | sed -e 's/[^a-zA-Z0-9\t]/_/g' -e 's/\t/,/g'`;
    cat "$input" | tr -d "\r" | sed -e '1d' -e "s/'/''/g" -e "s/\\t/','/g" -e 's/$/);/' | tr "" "'" | sed -e "s/^/INSERT INTO $table ($row)\\n    VALUES ('/" | tr -c '[:print:]\n' "?" >> $table.sql;
done
