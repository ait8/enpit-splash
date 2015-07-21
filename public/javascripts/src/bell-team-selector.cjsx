React = require 'react'
Mui   = require 'material-ui'

SelectField = Mui.SelectField

module.exports = React.createClass
  mixins: [React.addons.LinkedStateMixin]
  getInitialState: ->
    teams : []
    selectValue: undefined
  onChange: (e) ->
    @setState
      selectValue: e.target.value
    @props.onChangeTeam(e.target.value.text)
  componentWillMount: ->
    that = @
    $.get './teams', (data)->
      that.setState
        teams : data
  render: ->
    <SelectField
      value={@state.selectValue}
      onChange={@onChange}
      hintText="チーム名を選択"
      menuItems={@state.teams} />
