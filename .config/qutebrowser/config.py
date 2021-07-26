# Read the colors from pywal
import json
with open('/home/beto/.cache/wal/colors.json') as f:
    colors = json.load(f)

# Backend to use to display websites.
c.backend = 'webengine'

# Dark mode
#c.colors.webpage.darkmode.enabled = True
c.colors.webpage.preferred_color_scheme = 'dark'

# Completion
c.completion.height = '25%'
c.completion.open_categories = ['quickmarks', 'history']
c.completion.shrink = True
c.completion.scrollbar.width = 12
c.completion.scrollbar.padding = 1
c.completion.timestamp_format = '%d-%m-%Y'
c.completion.use_best_match = True

# Require a confirmation before quitting the application.
c.confirm_quit = ['downloads', 'multiple-tabs']

# ad/host blocker
c.content.blocking.enabled = True

# Encoding
c.content.default_encoding = 'utf-8'

# Clipboard
c.content.javascript.can_access_clipboard = True

# PDFs
c.content.pdfjs = True

# Monitor load requests for cross-site scripting attempts.
c.content.xss_auditing = True

# Downloads
c.downloads.location.directory = '~/Downloads'
c.downloads.location.remember = False
c.downloads.location.suggestion = 'both'
c.downloads.position = 'bottom'
c.downloads.remove_finished = 3000

# Fonts
c.fonts.default_family = 'monospace'
c.fonts.completion.entry = 'bold 10pt monospace'
c.fonts.completion.category = 'bold 10pt monospace'
c.fonts.debug_console = 'bold 10pt monospace'
c.fonts.downloads = 'bold 10pt monospace'
c.fonts.hints = 'bold 10pt monospace'
c.fonts.keyhint = 'bold 10pt monospace'
c.fonts.messages.error = '10pt monospace'
c.fonts.messages.info = '10pt monospace'
c.fonts.messages.warning = '10pt monospace'
c.fonts.prompts = '10pt monospace'
c.fonts.statusbar = 'bold 10pt monospace'

# Keyhint
c.keyhint.radius = 10
c.keyhint.delay = 1000

# Don't load autoconfig
config.load_autoconfig(False)

# Scrollbar
c.scrolling.bar = 'always'
c.scrolling.smooth = False

# Spell check
c.spellcheck.languages = ['en-US', 'es-ES']

# Statusbar
c.statusbar.widgets = ['keypress', 'url', 'scroll', 'history', 'tabs', 'progress']

# Tabs
c.tabs.favicons.scale = 1.15
c.tabs.indicator.width = 0
c.tabs.last_close = 'startpage'
c.tabs.mousewheel_switching = False
c.tabs.padding = { "left": 5, "right": 5, "top": 1, "bottom": 1 }
c.tabs.show = 'always'
c.tabs.title.format = '{audio}{current_title}'
c.tabs.title.format_pinned = '{audio}{current_title}'
c.tabs.width = '20%'

# URL
c.url.default_page = 'file:///home/beto/.local/share/startpage/index.html'
c.url.searchengines = {'DEFAULT': 'https://www.google.com/search?q={}'}
c.url.start_pages = 'file:///home/beto/.local/share/startpage/index.html'

# Qutewal
config.source("qutewal.py")

# Key Bindings
config.unbind('d')
config.bind('<Alt-j>', 'tab-next')
config.bind('<Alt-k>', 'tab-prev')
config.bind('<Alt-h>', 'back')
config.bind('<Alt-l>', 'forward')
config.bind('<Ctrl-m>', 'tab-mute')
config.bind('<Ctrl-h>', 'open qute://history')
config.bind('dd', 'tab-close')
config.bind('di', 'hint images download')
