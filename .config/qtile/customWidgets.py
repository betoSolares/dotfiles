# 
# Custom widget for qtile
# 

# Imports
import os
import subprocess
from libqtile.widget import base

# Widget to execute shell scripts
class Script(base.ThreadedPollText):
    orientations = base.ORIENTATION_HORIZONTAL
    defaults = [
        ('name', None, 'Script name'),
        ('directory', os.path.expanduser('~/.scripts/wm/'), 'PATH to the script'),
    ]

    def __init__(self, **config):
        base.ThreadedPollText.__init__(self, **config)
        self.add_defaults(Script.defaults)
        self.name = self.directory + config['name']

    def poll(self):
        return self._run()

    def _run(self, button = None, x = None, y = None):
        if button is not None:
            _button_ = os.environ.copy()
            _button_['WIDGET_BUTTON'] = str(button)
            _button_['WIDGET_X_LOC'] = str(x)
            _button_['WIDGET_Y_LOC'] = str(y)
            result = subprocess.run(['sh', self.name], stdout = subprocess.PIPE, env=_button_)
        else:
            result = subprocess.run(['sh', self.name], stdout=subprocess.PIPE)

        return result.stdout.decode()

    def button_press(self, x, y, button):
        return self._run(button = button, x = x, y = y)

