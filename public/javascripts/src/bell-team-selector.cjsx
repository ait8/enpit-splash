React = require 'react'
Mui   = require 'material-ui'

SelectField = Mui.SelectField

module.exports = React.createClass
  getInitialState: ->
    selectValue: @props.teamId
  onChange: (e) ->
    @setState
      selectValue: e.target.value
    @props.onChangeTeam(e.target.value)
  render: ->
    <SelectField
      value={@state.selectValue}
      onChange={@onChange}
      hintText="チーム名を選択"
      valueMember="id"
      displayMember="name"
      menuItems={@props.teams} />
