#!/bin/sh

# Set the name of your cursor theme
themetitle=${1}
lefthand_variant=${2}

if [ -z ${1} ]
then
	echo "You must specify a name for your theme..."
else
	# For the folder name: Replace forbidden charakters with “-”
	foldername=$(echo $themetitle | sed -e 's/[^A-Za-z0-9_-]/-/g')
	mkdir -p $foldername
	mkdir -p $foldername/cursors
	echo '[Icon Theme]
	Name="'$themetitle'"' > $foldername/index.theme

	# Go to hotspots folder, render the PNGs according to those files
	cd "hotspots${2}"/
	for f in *.in ; do
		xcursorgen "$f" ../$foldername/cursors/"${f%.in}" ;
	done

	# Create symbolic links for equivalent cursors
	cd ../$foldername/cursors
	ln -sf left_ptr default
	ln -sf left_ptr top_left_arrow
	ln -sf left_ptr left-arrow
	ln -sf left_ptr 08ffe1e65f80fcfdf9fff11263e74c48
	ln -sf right_ptr arrow
	ln -sf right_ptr top_right_arrow
	ln -sf right_ptr right-arrow
	ln -sf context-menu 08ffe1e65f80fcfdf9fff11263e74c48
	ln -sf copy 08ffe1cb5fe6fc01f906f1c063814ccf
	ln -sf copy 1081e37283d90000800003c07f3ef6bf
	ln -sf copy 6407b0e94181790501fd1e167b474872
	ln -sf copy b66166c04f8c3109214a4fbd64a50fc8
	ln -sf link alias
	ln -sf link 0876e1c15ff2fc01f906f1c363074c0f
	ln -sf link 3085a0e285430894940527032f8b26df
	ln -sf link 640fb0e74195791501fd1ed57b41487f
	ln -sf link a2a266d0498c3104214a47bd64ab0fc8
	ln -sf help question_arrow
	ln -sf help whats_this
	ln -sf help gumby
	ln -sf help 5c6cd98b3f3ebcb1f9c7f1c204630408
	ln -sf help d9ce0ab605698f320427677b458ad60b
	ln -sf pointing_hand pointer
	ln -sf pointing_hand hand
	ln -sf pointing_hand hand2
	ln -sf pointing_hand e29285e634086352946a0e7090d73106
	ln -sf openhand grab
	ln -sf openhand hand1
	ln -sf openhand 5aca4d189052212118709018842178c0
	ln -sf openhand 9d800788f1b08800ae810202380a0822
	ln -sf closedhand grabbing
	ln -sf closedhand dnd-none
	ln -sf closedhand 208530c400c041818281048008011002
	ln -sf dnd-no-drop no-drop
	ln -sf dnd-no-drop 03b6e0fcb3499374a867c041f52298f0
	ln -sf dnd-no-drop 03b6e0fcb3499374a867d041f52298f0
	ln -sf text ibeam
	ln -sf text xterm
	ln -sf vertical-text 048008013003cff3c00c801001200000
	ln -sf crosshair tcross
	ln -sf dotbox draped_box
	ln -sf dotbox icon
	ln -sf dotbox dot_box_mask
	ln -sf cross diamond_cross
	ln -sf cross cross_reverse
	ln -sf cross target
	ln -sf cell plus
	ln -sf x-cursor X_cursor
	ln -sf x-cursor wayland-cursor
	ln -sf not-allowed forbidden
	ln -sf not-allowed crossed_circle
	ln -sf not-allowed 03b6e0fcb3499374a867c041f52298f0
	ln -sf pencil draft
	ln -sf zoom-in zoom_in
	ln -sf zoom-in f41c0e382c94c0958e07017e42b00462
	ln -sf zoom-out zoom_out
	ln -sf zoom-out f41c0e382c97c0938e07017e42800402
	ln -sf pirate kill
	ln -sf move fleur
	ln -sf move size_all
	ln -sf move pointer-move
	ln -sf move 4498f0e0c1937ffe01fd06f973665830
	ln -sf move 9081237383d90e509aa00f00170e968f
	ln -sf move fcf21c00b30f7e3f83fe0dfd12e71cff
	ln -sf up-arrow up_arrow
	ln -sf up-arrow sb_up_arrow
	ln -sf right-arrow right_arrow
	ln -sf right-arrow sb_right_arrow
	ln -sf down-arrow down_arrow
	ln -sf down-arrow sb_down_arrow
	ln -sf left-arrow left_arrow
	ln -sf left-arrow sb_left_arrow
	ln -sf ns-resize size_ver
	ln -sf ns-resize size-ver
	ln -sf ns-resize v_double_arrow
	ln -sf ns-resize double_arrow
	ln -sf ns-resize 00008160000006810000408080010102
	ln -sf ns-resize split_v
	ln -sf ns-resize based_arrow_up
	ln -sf ns-resize based_arrow_down
	ln -sf ns-resize sb_v_double_arrow
	ln -sf ew-resize size_hor
	ln -sf ew-resize size-hor
	ln -sf ew-resize h_double_arrow
	ln -sf ew-resize 028006030e0e7ebffc7f7070c0600140
	ln -sf ew-resize split_h
	ln -sf ew-resize sb_h_double_arrow
	ln -sf nesw-resize size_bdiag
	ln -sf nesw-resize size-bdiag
	ln -sf nesw-resize fd_double_arrow
	ln -sf nesw-resize 50585d75b494802d0151028115016902
	ln -sf nesw-resize fcf1c3c7cd4491d801f1e1c78f100000
	ln -sf nwse-resize size_fdiag
	ln -sf nwse-resize size-fdiag
	ln -sf nwse-resize bd_double_arrow
	ln -sf nwse-resize 38c5dff7c7b8962045400281044508d2
	ln -sf nwse-resize c7088f0f3e6c8088236ef8e1e3e70000
	ln -sf n-resize top_side
	ln -sf e-resize right_side
	ln -sf s-resize bottom_side
	ln -sf w-resize left_side
	ln -sf ne-resize top_right_corner
	ln -sf se-resize bottom_right_corner
	ln -sf sw-resize bottom_left_corner
	ln -sf nw-resize top_left_corner
	ln -sf col-resize 043a9f68147c53184671403ffa811cc5
	ln -sf col-resize 14fef782d02440884392942c11205230
	ln -sf row-resize 2870a09082c103050810ffdffffe0204
	ln -sf row-resize c07385c7190e701020ff7ffffd08103c
	ln -sf progress left_ptr_watch
	ln -sf progress half-busy
	ln -sf progress 00000000000000020006000e7e9ffc3f
	ln -sf progress 08e8e1c95fe2fc01f976f1e063a24ccd
	ln -sf progress 3ecb610c1bf2410f44200f48c40d3599
	ln -sf progress 9116a3ea924ed2162ecab71ba103b17f
	ln -sf wait watch
	ln -sf wait clock
	ln -sf wait 0426c94ea35c87780ff01dc239897213
fi