React = require 'react'
Mui   = require 'material-ui'

SelectField = Mui.SelectField

module.exports = React.createClass
  mixins: [React.addons.LinkedStateMixin]
  getInitialState: ->
    selectValue: undefined
  onChange: (e) ->
    @setState
      selectValue: e.target.value
    @props.onChangeTeam(e.target.value.text)
  render: ->
    <SelectField
      value={@state.selectValue}
      onChange={@onChange}
      hintText="チーム名を選択"
      menuItems={@props.teams} />
