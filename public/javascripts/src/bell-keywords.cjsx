React = require 'react'
Mui   = require 'material-ui'

TextField    = Mui.TextField

module.exports = React.createClass
    handleChange: (e)->
        @props.onChangeKeywords(e.target.value)
    render: ->
        <div className="mdl-textfield mdl-js-textfield textfield-demo">
            <TextField onChange={@handleChange} hintText="keywords..." />
        </div>
