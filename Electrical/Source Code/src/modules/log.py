import os
import logging as log
from time import gmtime, strftime

def now_str():
    return strftime('%Y%b%d-%H:%M:%S', gmtime())

# src/log/
log_target = os.path.dirname(os.path.dirname(os.path.realpath(__file__))) + \
             '/log/' + now_str()
log.basicConfig(filename=log_target, level=log.DEBUG)

console = log.StreamHandler()
console.setLevel(log.DEBUG)
log.getLogger('').addHandler(console)


def debug(msg):
    log.debug("[%s] %s", now_str(), msg)

def info(msg):
    log.info("[%s] %s", now_str(), msg)

def warn(msg):
    log.warn("[%s] %s", now_str(), msg)

def critical(msg):
    log.critical("[%s] %s", now_str(), msg)

