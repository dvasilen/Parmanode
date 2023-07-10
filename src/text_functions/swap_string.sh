function swap_string {
#will replace entire line containing search string with the new line
input_file="$1"
search_string="$2"
new_line="$3"

if [[ ! -f "$input_file" ]]; then
    echo "Error: $input_file does not exist."
    enter_continue
    return 1
fi

if [[ $OS == "Mac" ]] ; then 
sudo sed -i "" '/$search_string/c\\$new_line/g' "$input_file"
fi

if [[ $OS == "Linux ]] ; then
sudo sed -i '/$search_string/c\\$new_line/g' "$input_file"
fi

}
