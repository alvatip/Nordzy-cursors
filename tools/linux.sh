#!/bin/bash

# Renders all the cursors for linux and create the archives at the appropriate place.

theme_name="Nordzy-cursors Nordzy-cursors-lefthand Nordzy-cursors-white"

animation(){
	frames=(". .. ...")
	while kill -0 ${1} 2&>1 /dev/null
	do
		for frame in ${frames}
		do
			printf "Rendering PNGs for ${2} ${frame}  \r"
			sleep 0.5
		done
	done
	printf "PNGs for ${2} finished \n"
}
png_render(){
	./render-pngs.py svgs/nordzy-templates/"${1}.svg"
	./render-pngs.py svgs/nordzy-templates/"${1}-spinner.svg"
}

if [ -d ../archives ]
then
	# Clean old archives
	rm -rf ../archives/*
	echo "Cleaning old archives"
fi

for theme in ${theme_name}
do 
	# Remove old theme
	rm -rf ../${theme}
	# Renders PNGs
	png_render ${theme} 2&>1 /dev/null &
	pid=$!
	animation $pid ${theme}
	# Make X11 cursors
	echo "Making the X11 cursors for ${theme}..."
	# If this is a lefthand variant, we must use the lefthand hostspot file
	if [[ ${theme} =~ .*lefthand ]]; then
		./make.sh ${theme} '-lefthand'
	else
		./make.sh ${theme}
	fi
	

	# Create archives
	echo "Making the archives for ${theme}..."
	{
		tar -zcf "${theme}.tar.gz" ${theme}/
		mv "${theme}"/ ../
		zip -r "${theme}-PNGs.zip" pngs/
	} &> /dev/null

	# Create windows cursors
	if [ -e animated/${theme}/"progress.ani" ] && [ -e animated/${theme}/"wait.ani" ]
	then
		echo "Making the windows cursors for ${theme}..."
		{
			./win_cursors.sh "${theme}-windows"
			cp Install.inf "${theme}-windows"/
			cp animated/${theme}/*.ani "${theme}-windows"/
			zip -r "${theme}-windows".zip "${theme}-windows"/
			rm -rf "${theme}-windows"
		} &> /dev/null
	else
		echo "You are missing progress.ani and/or wait.ani cursors"
	fi
done

# Move the archives to the right folder
extensions="zip gz"
for archive in ${extensions}
do
	mv *${archive} ../archives/
done
echo "The cursors theme is finished!"