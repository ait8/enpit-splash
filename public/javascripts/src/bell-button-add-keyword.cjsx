React = require 'react'
Mui   = require 'material-ui'

RaisedButton = Mui.RaisedButton

module.exports = React.createClass
  onClick: ->
    @props.addKeyword()
  render: ->
    <RaisedButton onClick={@onClick} label="キーワード追加" />
