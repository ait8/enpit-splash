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
    @props.onChangeKeyword(e.target.value.text)
  render: ->
    <SelectField
      value={@state.selectValue}
      onChange={@onChange}
      hintText="キーワードを選択"
      menuItems={@props.keywords} />
