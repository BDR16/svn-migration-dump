import time
import sys
import csv

import Adafruit_BBIO.GPIO as GPIO
import Adafruit_BBIO.PWM as PWM
import Adafruit_BBIO.ADC as ADC

# Pin definitions
PIN_CELL_VOLTAGE = 'P9_39'
PIN_CELL_CURRENT = 'P9_40'
PIN_RELAY_CONTROL = 'P8_14'
PIN_SET_VOLTAGE = 'P8_13'
# AGND is P9_34

# Cell voltage constants
CELL_VOLTAGE_MAX = 4.2
CELL_VOLTAGE_START = 3.05
CELL_VOLTAGE_MIN = 2.7

# Battery tester circuit resistance values
R1 = 1000
R2 = 510
RSHUNT = 0.005

# PWM constants
# 27.8 for 10A
# 49.5 for 20A
PWM_DUTY_CYCLE = 49.5
PWM_FREQUENCY = 10000

# Other constants
WAIT_TIME = 0.5
DATA_FILE_NAME = 'data.csv'

# Setup the GPIO and ADC
GPIO.setup(PIN_RELAY_CONTROL, GPIO.OUT)
GPIO.output(PIN_RELAY_CONTROL, GPIO.LOW)
ADC.setup()

def get_cell_voltage():
    return ADC.read_raw(PIN_CELL_VOLTAGE) * (R1 + R2) / (1000 * R2)

def get_cell_current():
    return ADC.read_raw(PIN_CELL_CURRENT) / (1000 * RSHUNT)

def check_cell_voltage(cell_voltage):
    if cell_voltage > CELL_VOLTAGE_MAX:
        print 'ERROR: Cell is overcharged or the analog input "%s" is disconnected.' %PIN_CELL_VOLTAGE
        print 'ERROR: If the former is true then discharge below %0.2fV immediately.\n' %CELL_VOLTAGE_MAX
    elif cell_voltage < CELL_VOLTAGE_MIN:
        print 'ERROR: Cell is undercharged. Either recharge immediately or properly dispose of the cell.\n'
    else:
        return False
    return True

def shut_down(times, voltages, currents):
    # Shut down the GPIO and PWM
    GPIO.output(PIN_RELAY_CONTROL, GPIO.LOW)
    PWM.stop(PIN_SET_VOLTAGE)
    GPIO.cleanup()
    PWM.cleanup()

    # Output the data
    with open(DATA_FILE_NAME, 'wb') as f:
        writer = csv.writer(f)
        writer.writerows([times, voltages, currents])

# Prompt the user to attach a battery for testing
print '\nConnect a fully charged battery to the test clips to begin discharging.'
raw_input('Press Enter to continue...\n')

# Check the analog inputs for valid values
cell_voltage = get_cell_voltage()
if check_cell_voltage(cell_voltage):
    sys.exit()
elif cell_voltage < CELL_VOLTAGE_START:
    print 'ERROR: Cell has a low voltage of %0.2f for being fully charged. Ensure that the cell is fully charged before beginning.\n' %cell_voltage
    sys.exit()

# Start the discharging
PWM.start(PIN_SET_VOLTAGE, PWM_DUTY_CYCLE, PWM_FREQUENCY)
time.sleep(1)
GPIO.output(PIN_RELAY_CONTROL, GPIO.HIGH)

# Run the main discharge loop
first_time = time.time()
cell_voltage = get_cell_voltage()
cell_current = get_cell_current()
cell_times = [0]
cell_voltages = [cell_voltage]
cell_currents = [cell_current]
try:
    while cell_voltage > CELL_VOLTAGE_MIN:
        # Sleep so that we don't get data overload
        time.sleep(WAIT_TIME)

        # Gather data
        current_time = time.time()
        cell_voltage = get_cell_voltage()
        cell_current = get_cell_current()

        # Append data to lists
        cell_times.append(current_time - first_time)
        cell_voltages.append(cell_voltage)
        cell_currents.append(cell_current)

        print current_time - first_time, cell_voltage, cell_current
except KeyboardInterrupt:
    shut_down(cell_times, cell_voltages, cell_currents)
    print 'ERROR: Discharge interrupted. Data was output to "%s".\n'

# Shut it down
shut_down(cell_times, cell_voltages, cell_currents)
print 'Discharge complete. Disconnect the cell from the test clips.'
print 'Data was output to "%s".' %DATA_FILE_NAME
raw_input('Press Enter after disconnecting the cell...\n')
