React = require 'react'

module.exports = React.createClass
    onClick: ->
        @props.sendMessage()
    render: ->
        <button onClick={@onClick} className="mdl-button mdl-js-button mdl-button--raised mdl-button--accent mdl-js-ripple-effect">
            SEND
        </button>
