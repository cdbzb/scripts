for file in *.aif; do
	mv "$file" "$(echo "$file" | sed 's/.aif$//')";
   done;

