React = require 'react'
Mui   = require 'material-ui'

TextField    = Mui.TextField

module.exports = React.createClass
    handleChange: (e)->
        @props.onChangeKeywords(e.target.value)
    render: ->
        <TextField onChange={@handleChange} hintText="keywords..." />
