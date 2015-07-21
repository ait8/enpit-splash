React = require 'react'
Mui   = require 'material-ui'

SelectField = Mui.SelectField

module.exports = React.createClass
  mixins: [React.addons.LinkedStateMixin]
  getInitialState: ->
    keywords : []
    selectValue: undefined
  onChange: (e) ->
    @setState
      selectValue: e.target.value
    @props.onChangeKeyword(e.target.value.text)
  componentWillMount: ->
    that = @
    $.get './keywords', (data)->
      newKeywords = []
      for d in data
        newKeywords.push
          'text': d.text
      that.setState
        keywords : newKeywords
  render: ->
    <SelectField
      value={@state.selectValue}
      onChange={@onChange}
      hintText="キーワードを選択"
      menuItems={@state.keywords} />
