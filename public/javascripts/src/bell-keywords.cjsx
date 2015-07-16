React = require 'react'

module.exports = React.createClass
    handleChange: (e)->
        @props.onChangeKeywords(e.target.value)
    render: ->
        <div className="mdl-textfield mdl-js-textfield textfield-demo">
            <input onChange={@handleChange} className="mdl-textfield__input" text="text" id="keywords" />
            <label className="mdl-textfield__label" htmlFor="keywords">keywords...</label>
        </div>
