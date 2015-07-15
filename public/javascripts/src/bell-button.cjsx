React = require 'react'

module.exports = React.createClass
    onClick: ->
        this.props.sendMessage()
    render: ->
        <button onClick={this.onClick} className="mdl-button mdl-js-button mdl-button--raised mdl-button--accent mdl-js-ripple-effect">
            SEND
        </button>
