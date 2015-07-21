React = require 'react'
Mui   = require 'material-ui'

SelectField = Mui.SelectField

module.exports = React.createClass
  getInitialState: ->
    selectValue: undefined
  onChange: (e) ->
    @setState
      selectValue: e.target.value
    @props.onChangeKeyword(e.target.value)
  render: ->
    <SelectField
      value={@state.selectValue}
      onChange={@onChange}
      hintText="キーワードを選択"
      valueMember="text"
      displayMember="text"
      menuItems={@props.keywords} />
