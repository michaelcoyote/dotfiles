
import builtins
# import os
import sys


sys.ps1 = '\x01\033[95m\x02>>> \x01\033[0m\x02 '
sys.ps2 = '\x01\x1b[1;49;33m\x02>>>\x01\x1b[0m\x02 '


# call with `name / help` or `help / name`
class _Help:
    def __call__(self, o):
        return builtins.help(o)

    def __truediv__(self, o):
        return builtins.help(o)

    def __rtruediv__(self, o):
        return builtins.help(o)


help = _Help()
