##these functions now live in root bin so they can be my EDITOR

# function em() {
#     emacsclient -nw "$@" 2>/dev/null
#     if [ "$?" -eq "1" ]; then
#         # echo 1
#         emacsclient -a '' "$@"
#     fi
# }

# function emw {
#     # Checks if there's a frame open and sets autofocus when opening files from terminal
#     # https://askubuntu.com/questions/283711/application-focus-of-emacsclient-frame
#     emacsclient -n -e "(if (> (length (frame-list)) 1) 't)" -e "(progn (raise-frame) (x-focus-frame (selected-frame)))" 2> /dev/null | grep t
#     # emacsclient -n -e "(if (> (length (frame-list)) 1) 't)" 2> /dev/null | grep t
#     if [ "$?" -eq "1" ]; then
#         # echo 1
#         emacsclient -a '' -nqc "$@"
#     else
#         # echo else
#         emacsclient -nqc "$@"
#     fi
# }
