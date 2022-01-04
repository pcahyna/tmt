#!/bin/bash
# vim: dict+=/usr/share/beakerlib/dictionary.vim cpt=.,w,b,u,t,i,k
. /usr/share/beakerlib/beakerlib.sh || exit 1

REBOOT_COUNT=${REBOOT_COUNT:-0}

rlJournalStart
    rlPhaseStartSetup
        rlRun "set -o pipefail"
    rlPhaseEnd

    if [ "$REBOOT_COUNT" -eq 0 ]; then
        rlPhaseStartTest "Reboot using rhts-reboot"
            rlRun "rhts-reboot" 0 "Reboot the machine"
        rlPhaseEnd
    elif [ "$REBOOT_COUNT" -eq 1 ]; then
        rlPhaseStartTest "Reboot using rstrnt-reboot"
            rlLog "After first reboot"
            rlRun "rstrnt-reboot" 0 "Reboot the machine"
        rlPhaseEnd
    elif [ "$REBOOT_COUNT" -eq 2 ]; then
        rlPhaseStartTest "Reboot using tmt-reboot"
            rlLog "After second reboot"
            rlRun "tmt-reboot" 0 "Reboot the machine"
        rlPhaseEnd       
    elif [ "$REBOOT_COUNT" -eq 3 ]; then
        rlPhaseStartTest "Finish"
            rlLog "After third reboot"
        rlPhaseEnd
        rlJournalEnd
    fi

# nothing, do rlJournalEnd after the third reboot, or not at all
