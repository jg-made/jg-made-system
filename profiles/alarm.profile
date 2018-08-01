# sometimes I have to use my laptop as an alarm clock
# for posterity - end the morning torture with a simple alarms_clear_all if there is truly no getting up

export ALARM_CRON_FILE=/etc/cron.d/alarm

alarms_see_all() {
    cat $ALARM_CRON_FILE 2>/dev/null
}

alarms_clear_all() {
    sudo rm $ALARM_CRON_FILE 2>/dev/null
}

alarms_set_mm_hh_weekdays_alarmfile() {
    if [ $# -ne 4 ];
    then
        echo "you need to specify 4 arguments: mm hh weekdays alarm_file_name_without_suffix"
        echo "e.g. alarms_set_mm_hh_weekdays_alarmfile 30 09 1-5 'Alarm\ clock'"
        if [ $# -ne 0 ];
        then
            echo "the given arguments are $@"
        fi
    else
        echo "$1 $2 * * $3 $USER paplay --device=0 /usr/share/sounds/ubuntu/ringtones/$4.ogg 2>/dev/null" | sudo tee -a $ALARM_CRON_FILE > /dev/null
        echo "$1 $2 * * $3 $USER paplay --device=1 /usr/share/sounds/ubuntu/ringtones/$4.ogg 2>/dev/null" | sudo tee -a $ALARM_CRON_FILE > /dev/null
        echo "$1 $2 * * $3 $USER paplay --device=2 /usr/share/sounds/ubuntu/ringtones/$4.ogg 2>/dev/null" | sudo tee -a $ALARM_CRON_FILE > /dev/null
        echo "$1 $2 * * $3 $USER paplay --device=3 /usr/share/sounds/ubuntu/ringtones/$4.ogg 2>/dev/null" | sudo tee -a $ALARM_CRON_FILE > /dev/null
    fi
}

alarms_reset_to_usual() {
    alarms_clear_all;
    alarms_set_mm_hh_weekdays_alarmfile 00 09 1-5 'Celestial'
    alarms_set_mm_hh_weekdays_alarmfile 05 09 1-5 'Wind\ chime'
    alarms_set_mm_hh_weekdays_alarmfile 15 09 1-5 'Alarm\ clock'
    alarms_set_mm_hh_weekdays_alarmfile 30 09 1-5 'Alarm\ clock'
    alarms_set_mm_hh_weekdays_alarmfile 45 09 1-5 'Alarm\ clock'
    alarms_set_mm_hh_weekdays_alarmfile 00 10 1-5 'Alarm\ clock'
}

alarms_reset_to_london() {
    alarms_clear_all;
    alarms_set_mm_hh_weekdays_alarmfile 00 08 1-5 'Celestial'
    alarms_set_mm_hh_weekdays_alarmfile 05 08 1-5 'Wind\ chime'
    alarms_set_mm_hh_weekdays_alarmfile 15 08 1-5 'Alarm\ clock'
    alarms_set_mm_hh_weekdays_alarmfile 30 08 1-5 'Alarm\ clock'
    alarms_set_mm_hh_weekdays_alarmfile 45 08 1-5 'Alarm\ clock'
    alarms_set_mm_hh_weekdays_alarmfile 00 09 1-5 'Alarm\ clock'
}

alias alarms_see_all=alarms_see_all;
alias alarms_clear_all=alarms_clear_all;
alias alarms_set_mm_hh_weekdays_alarmfile=alarms_set_mm_hh_weekdays_alarmfile
alias alarms_reset_to_usual=alarms_reset_to_usual
alias alarms_reset_to_london=alarms_reset_to_london
