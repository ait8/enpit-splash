React = require 'react'

# Needed for onTouchTap
# Can go away when react 1.0 release
# Check this repo:
# https://github.com/zilverline/react-tap-event-plugin
injectTapEventPlugin = require 'react-tap-event-plugin'
injectTapEventPlugin()

Bell  = require './bell.cjsx'

React.render <Bell />, document.getElementById('main')
