# general sound stuff

export BEEP=/usr/share/sounds/ubuntu/notifications/Positive.ogg

alias beep='paplay $BEEP'

function headset_volume_fix() {
    # Fight WebRTC!
    # https://askubuntu.com/questions/279407/how-to-disable-microphone-from-auto-adjusting-its-input-volume/736655#736655
    while true;
    do
        amixer -c 0 set 'Headset Mic Boost' 11db > /dev/null;
        amixer -c 0 set 'Capture' 35db > /dev/null;
        sleep 0.1
    done;
}

function headset_mute() {
    while true;
    do
        amixer -c 0 set 'Headset Mic Boost' 0db > /dev/null;
        amixer -c 0 set 'Capture' 0db > /dev/null;
        sleep 0.1
    done;
}

# function speak_selected() {
#     # https://askubuntu.com/questions/815828/text-to-speech-for-selected-text-ubuntu-16-04
#     # I ended up actually just putting this as executable /bin/speak_selected. Leaving here for posterity.
#     xclip -out -selection primary | xclip -in -selection clipboard; xsel --clipboard | tr "\n" " " | espeak -g 4 -k5 -s 145
# }
# function speak_selected() {
#     # https://askubuntu.com/questions/815828/text-to-speech-for-selected-text-ubuntu-16-04
#     # I ended up actually just putting this as executable /bin/speak_selected. Leaving here for posterity.
#     xclip -out -selection primary | xclip -in -selection clipboard; xsel --clipboard | tr "\n" " " | espeak -g 4 -k5 -s 145
# }
