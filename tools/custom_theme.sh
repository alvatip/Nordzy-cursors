#!/bin/bash

svg_template_main="svgs/nordzy-templates/Nordzy-cursors-template.svg"
svg_template_spinner="svgs/nordzy-templates/Nordzy-cursors-spinner-template.svg"

# Display ascii art
ascii_art() {
  cat < ../nordzy-ascii-art.txt
  sleep 0.5
}

# Show help
usage() {
cat << EOF
$0 helps you create Nordzy-cursor custom theme on your computer.

Usage: $0 [OPTION]...

OPTIONS:
	-a, --accent COLOR 			Change accent color (default: Nord_turquoise) to the specified color in hexadecimal format.
  -b, --border COLOR      Change border color (default: white) to the specified color in hexadecimal format.
  -f, --fill COLOR        Change fill color (default: black) to the specified color in hexadecimal format.
  -g, --green COLOR 			Change green color (default: green) to the specified color in hexadecimal format.
  -h, --help              Show help.
  -n, --name NAME         Specify theme name (Default: default_name).
  -o, --orange COLOR 			Change orange color (default: orange) to the specified color in hexadecimal format.
  -p, --purple COLOR 			Change purple color (default: purple) to the specified color in hexadecimal format.
  -r, --red COLOR 				Change red color (default: red) to the specified color in hexadecimal format.

EOF
}

# Display an animation during long working time (ex. Creation of the theme)
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
	./render-pngs.py svgs/themes/"${theme_name:-default_name}.svg"
	./render-pngs.py svgs/themes/"${theme_name:-default_name}-spinner.svg"
}

change_color(){
	# Create backup/copy of template file
	cp ${svg_template_main} "${svg_template_main}.bck"
	cp ${svg_template_spinner} "${svg_template_spinner}.bck"

	# Change the fill color (black/#000000)
	sed -i "s/#000000/${theme_color_fill:-#000000}/g" ${svg_template_main}
	sed -i "s/#000000/${theme_color_fill:-#000000}/g" ${svg_template_spinner}

	# Change the border color (white/#ffffff)
	sed -i "s/#ffffff/${theme_color_border:-#ffffff}/g" ${svg_template_main}
	sed -i "s/#ffffff/${theme_color_border:-#ffffff}/g" ${svg_template_spinner}

	# Change the accent color (nord/#8fbcbb)
	sed -i "s/#8fbcbb/${theme_color_accent:-#8fbcbb}/g" ${svg_template_spinner}

	# Change the green color - plus sign (Green/#00ff00)
	sed -i "s/#00ff00/${theme_color_green:-#00ff00}/g" ${svg_template_main}

	# Change the red color (Red/#ff0000)
	sed -i "s/#ff0000/${theme_color_red:-#ff0000}/g" ${svg_template_main}

	# Change the purple color (Purple/#800080)
	sed -i "s/#800080/${theme_color_purple:-#800080}/g" ${svg_template_main}

	# Change the orange color (Orange/#ff7f2a)
	sed -i "s/#ff7f2a/${theme_color_orange:-#ff7f2a}/g" ${svg_template_main}

	# Rename files with theme name.
	# It will overwrite any existing theme with same name.
	mv ${svg_template_main} "svgs/themes/${theme_name:-default_name}.svg"
	mv ${svg_template_spinner} "svgs/themes/${theme_name:-default_name}-spinner.svg"

	# Restore template file
	mv "${svg_template_main}.bck" ${svg_template_main}
	mv "${svg_template_spinner}.bck" ${svg_template_spinner}
}


run(){
	# Remove old theme
	rm -rf ../${theme_name}
	# Renders PNGs
	png_render ${theme_name} 2&>1 /dev/null &
	pid=$!
	animation $pid ${theme_name}
	# Make X11 cursors
	echo "Making the X11 cursors for ${theme_name}..."
	# If this is a lefthand variant, we must use the lefthand hostspot file
	if [[ ${theme} =~ .*lefthand ]]; then
		./make.sh ${theme_name} '-lefthand'
	else
		./make.sh ${theme_name}
	fi
	

	# Create archives
	echo "Making the archives for ${theme_name}..."
	{
		tar -zcf "${theme_name}.tar.gz" ${theme_name}/
		if [ -d ../themes/${theme_name} ]; then
			rm -rf ../themes/${theme_name}
		fi
		mv "${theme_name}"/ ../themes/
		zip -r "${theme_name}-PNGs.zip" pngs/
	} &> /dev/null

	# Move the archives to the right folder
	extensions="zip gz"
	rm -rf ../archives/*
	for archive in ${extensions}
	do
		mv *${archive} ../archives/
	done
	echo "The cursors theme is finished!"
}

ascii_art
while [[ "$#" -gt 0 ]]; do
  case "${1:-}" in
    -h|--help)
      usage
      exit 0
      ;;
    -n|--name)
		  theme_name=${2}
		  shift 2
		  ;;
		-f|--fill)
		  theme_color_fill=${2}
		  shift 2
		  ;;
		-b|--border)
		  theme_color_border=${2}
		  shift 2
		  ;;
  	-a|--accent)
		  theme_color_accent=${2}
		  shift 2
		  ;;
		-p|--purple)
		  theme_color_purple=${2}
		  shift 2
		  ;;
		-g|--green)
		  theme_color_green=${2}
		  shift 2
		  ;;
		-r|--red)
		  theme_color_red=${2}
		  shift 2
		  ;;
		-o|--orange)
		  theme_color_orange=${2}
		  shift 2
		  ;;
    *)
      echo "Unrecognized parameter ${1}"
      exit 1
      ;;
  esac
done
change_color
run