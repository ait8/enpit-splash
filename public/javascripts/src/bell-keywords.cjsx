React = require 'react'
Mui   = require 'material-ui'

TextField    = Mui.TextField

module.exports = React.createClass
    onChange: (e)->
        @props.onChangeKeyword(e.target.value)
    render: ->
        <TextField onChange={@onChange} hintText="keywords..." />
