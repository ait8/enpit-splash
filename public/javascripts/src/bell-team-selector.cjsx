React = require 'react'
Mui   = require 'material-ui'

SelectField = Mui.SelectField

module.exports = React.createClass
    getInitialState: ->
        selectValue: undefined
    onChange: (name, e) ->
        change = {}
        change[name] = e.target.value
        @setState change
        # @props.onChangeTeam(e.target.value)
    render: ->
        <SelectField
            value={@state.selectValue}
            onChange={@onChange.bind(null, 'selectValue')}
            hintText="Hint Text"
            menuItems={@props.teams} />
