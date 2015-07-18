React = require 'react'
Mui   = require 'material-ui'

RaisedButton = Mui.RaisedButton

module.exports = React.createClass
    onClick: ->
        @props.sendMessage()
    render: ->
        <RaisedButton onClick={@onClick} label="SEND" secondary={true} />
