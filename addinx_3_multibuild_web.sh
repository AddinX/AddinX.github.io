kill -9 $(ps aux | grep '[j]ekyll' | awk '{print $2}')
clear

echo "Starting website..."
jekyll serve --config configs/addinx/config_everyone.yml

#echo "Building addinx Writers website..."
#jekyll build --config configs/addinx/config_everyone.yml
# jekyll serve --config configs/addinx/config_writers.yml
#echo "done"



#echo "Building addinx Designers websote..."
#jekyll build --config configs/addinx/config_designers.yml
# jekyll serve --config configs/addinx/config_designers.yml
#echo "done"

#echo "All finished building all the web outputs!!!"
#echo "Now push the builds to the server with . addinx_4_publish.sh"

