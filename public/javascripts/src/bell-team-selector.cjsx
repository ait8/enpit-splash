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
        # @props.onChangeTeam(e.target.value)
    componentWillMount: ->
        that = @
        $.get './teams', (data)->
            that.setState
                teams : data
    render: ->
        options = @state.teams.map (team) -> 
            <option value={team} key={team}>{team}</option>
        <div>
        <select multiple={true}>
            {options}
        </select>
        <SelectField
            value={@state.selectValue}
            onChange={@onChange.bind(null, 'selectValue')}
            hintText="Hint Text"
            menuItems={@state.teams} />
        </div>
