# Reading from sensors and stuff
import Adafruit_BBIO.GPIO as GPIO
import modules.sensor as sensor

"""
Digital Pins:
P9_11, P9_12, P9_13, P9_14,
P9_15, P9_16, P9_17, P9_18,
P9_21, P9_22, P9_23, P9_24,
P9_25, P9_26, P9_27, P9_28,
P9_29, P9_30, P9_31, P9_41,
P9_42

Analog Pins:
P9_33, P9_35, P9_36, P9_37,
P9_38, P9_39, P9_40
"""

pin_list = []

# Pedal Box
throt_pot_1 = sensor.AnalogPot('P9_39', 0.050, 0.200, 0.900, 0.990)
throt_pot_2 = sensor.AnalogPot('P9_37', 0.150, 0.300, 0.700, 0.800)

# Give the brake extreme values for now so it doesn't trip by accident.
# Because Formula Hybrid won't be using braking stuff.
# Please comment this out if judges want to see your code.
brake_pot = sensor.AnalogPot('P9_35', 0.050, 1.000, 1.000, 1.000)

pin_list.append(throt_pot_1)
pin_list.append(throt_pot_2)
pin_list.append(brake_pot)

# Dashboard
brake_regen = sensor.AnalogIn('P9_38')
ignit_btn = sensor.DigitalIn('P8_12')
perf_switch = sensor.DigitalIn('P8_10')
fault_led = sensor.DigitalOut('P8_8', GPIO.LOW)
speed_sig = sensor.DigitalOut('P8_19', GPIO.HIGH)
fuel_sig = sensor.DigitalOut('P8_13', GPIO.HIGH)

pin_list.append(brake_regen)
pin_list.append(ignit_btn)
pin_list.append(perf_switch)
pin_list.append(fault_led)
pin_list.append(speed_sig)
pin_list.append(fuel_sig)

# Accumulator
neg_air = sensor.DigitalIn('P8_18')
state_charge = sensor.AnalogIn('P9_40')
tsms = sensor.DigitalIn('P8_16')
# limit_low = sensor.DigitalIn('P8_18')

pin_list.append(neg_air)
pin_list.append(state_charge)
pin_list.append(tsms)
# pin_list.append(limit_low)

# Buzzer
hv_buzz = sensor.DigitalOut('P8_46', GPIO.HIGH)

pin_list.append(hv_buzz)

# CAN Bus
can_data = sensor.DigitalOut('P8_38', GPIO.HIGH)
can_recv = sensor.DigitalIn('P8_37')

pin_list.append(can_data)
pin_list.append(can_recv)

# Bamocar Manual
man_bmc_frg = sensor.DigitalOut('P9_25', GPIO.HIGH)
man_bmc_rfe = sensor.DigitalOut('P9_23', GPIO.HIGH)
man_throt_left = sensor.DigitalPWM('P9_21')
man_throt_right = sensor.DigitalPWM('P9_22')

pin_list.append(man_bmc_frg)
pin_list.append(man_bmc_rfe)
pin_list.append(man_throt_left)
pin_list.append(man_throt_right)

"""
Useful Functions related to IO
"""

def is_unique_pin_set():
    return len(set(map(lambda p: p.pin.lower(), pin_list))) == len(pin_list)

