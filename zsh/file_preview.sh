#copy from https://github.com/charleschetty/dotfile/blob/main/zsh/file_preview.sh
#!/usr/bin/bash
mime=$(file -bL --mime-type "$1")
category=${mime%%/*}
if [ -d "$1" ]; then
	exa -l --no-user --no-time --icons --no-permissions --no-filesize "$1" 2>/dev/null
elif [ "$category" = text ]; then
	(bat -p --style numbers --color=always "$1") 2>/dev/null | head -1000
elif [ "$mime" = application/pdf ]; then
	pdftotext $1 - | less
elif [ "$category" = image ]; then
	($HOME/.config/zsh/img_preview.sh $1) 2>/dev/null
else
	echo $1 is a $category file
fi