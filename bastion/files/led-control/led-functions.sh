#!/bin/sh

GREEN_LED='0'
RED_LED='1'

function led_off() {
    echo "$1" | grep -iv 'red' > /dev/null 2>&1
    echo none > "/sys/class/leds/led{$?}/trigger"
}

function led_on() {
    echo "$1" | grep -iv 'red' > /dev/null 2>&1
    echo default-on > "/sys/class/leds/led{$?}/trigger"
}

function led_heartbeat() {
    # modprobe -q ledtrig_heartbeat
    echo "$1" | grep -iv 'red' > /dev/null 2>&1
    echo heartbeat > "/sys/class/leds/led{$?}/trigger"
}

# none                No trigger
# kbd-scrolllock      Keyboard scroll lock
# kbd-numlock         Keyboard num lock
# kbd-capslock        Keyboard caps lock
# kbd-kanalock        Keyboard kana lock
# kbd-shiftlock       Keyboard shift
# kbd-altgrlock       Keyboard altgr
# kbd-ctrllock        Keyboard ctrl
# kbd-altlock         Keyboard alt
# kbd-shiftllock      Keyboard left shift
# kbd-shiftrlock      Keyboard right shift
# kbd-ctrlllock       Keyboard left ctrl
# kbd-ctrlrlock       Keyboard right ctrl
# timer               Flash at 1 second intervals
# oneshot             Flash only once
# heartbeat           Flash like a heartbeat (1-0-1-00000)
# backlight           Always on
# gpio                Flash when a certain GPIO is high???
# cpu0                Flash on cpu0 usage
# cpu1                Flash on cpu1 usage
# cpu2                Flash on cpu2 usage
# cpu3                Flash on cpu3 usage
# default-on          Always on
# [input]             Default state
# panic               Flash on kernel panic
# mmc0                Flash on mmc0 (primary SD Card interface) activity
# mmc1                Flash on mmc1 (secondary SD Card interface) activity
# rfkill0             Flash on wifi activity
# rfkill1             Flash on bluetooth activity
