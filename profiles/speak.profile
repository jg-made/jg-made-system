function speak_selected() {
    # https://askubuntu.com/questions/815828/text-to-speech-for-selected-text-ubuntu-16-04
    # I ended up actually just putting this as executable /bin/speak_selected. Leaving here for posterity.
    xclip -out -selection primary | xclip -in -selection clipboard; xsel --clipboard | tr "\n" " " | espeak
}
