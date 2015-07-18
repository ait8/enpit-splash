React = require 'react'
Mui   = require 'material-ui'

SelectField = Mui.SelectField

module.exports = React.createClass
    mixins: [React.addons.LinkedStateMixin]
    getInitialState: ->
        teams : []
        selectValue: undefined
    onChange: (name, e) ->
        change = {}
        change[name] = e.target.value
        @setState change
        @props.onChangeTeam(e.target.value.text)
    componentWillMount: ->
        that = @
        $.get './teams', (data)->
            that.setState
                teams : data
    render: ->
        <SelectField
            value={@state.selectValue}
            onChange={@onChange.bind(null, 'selectValue')}
            hintText="Hint Text"
            menuItems={@state.teams} />
