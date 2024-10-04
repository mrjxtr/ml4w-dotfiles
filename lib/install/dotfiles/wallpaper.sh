# ------------------------------------------------------
# Install wallpapers
# ------------------------------------------------------

if [ -d ~/wallpaper/ ]; then
    echo "~/wallpaper folder already exists."
else
    echo -e "${GREEN}"
    figlet -f smslant "Wallpapers"
    echo -e "${NONE}"

    mkdir ~/wallpaper
    cp $wallpaper_directory/* ~/wallpaper/
    echo ":: Default wallpapers installed successfully."
    echo
    echo "You can download and install additional wallpapers from https://github.com/mylinuxforwork/wallpaper/ ?"
    echo ""
    if gum confirm "Do you want to download the repository?" ;then
        if [ -d ~/Downloads/wallpaper ] ;then
            rm -rf ~/Downloads/wallpaper
        fi
        git clone --depth 1 https://github.com/mylinuxforwork/wallpaper.git ~/Downloads/wallpaper
        rsync -a -I --exclude-from=$install_directory/includes/excludes.txt ~/Downloads/wallpaper/. ~/wallpaper/
        echo "Wallpapers from the repository installed successfully."
    elif [ $? -eq 130 ]; then
        exit 130
    else
        echo ":: Installation of wallpaper repository skipped."
    fi
fi
echo

# ------------------------------------------------------
# Copy default wallpaper files to .cache
# ------------------------------------------------------

# Cache file for holding the current wallpaper
cache_file="$HOME/.config/ml4w/cache/current_wallpaper"
rasi_file="$HOME/.config/ml4w/cache/current_wallpaper.rasi"

# Create cache file if not exists
if [ ! -f $cache_file ] ;then
    touch $cache_file
    echo "$HOME/wallpaper/default.jpg" > "$cache_file"
fi

# Create rasi file if not exists
if [ ! -f $rasi_file ] ;then
    touch $rasi_file
    echo "* { current-image: url(\"$HOME/wallpaper/default.jpg\", height); }" > "$rasi_file"
fi
