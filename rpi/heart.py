from pulsesensor import Pulsesensor
import time

    
def heartrate_measure()

    p = Pulsesensor()
    p.startAsyncBPM()
    bpm = p.BPM
    time.sleep(1)
    
    while bpm <= 0:
        bpm = p.BPM
    
    p.stopAsyncBPM()
    return bpm
            