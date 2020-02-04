function giffify() {
    ffmpeg -i $1 -r 15 -vf scale=1300:-1 -ss 00:00:00 -to 00:00:05 giffify.gif
}
