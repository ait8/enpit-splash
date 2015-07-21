React = require 'react'
Mui   = require 'material-ui'

SelectField = Mui.SelectField

module.exports = React.createClass
  mixins: [React.addons.LinkedStateMixin]
  getInitialState: ->
    keywords : []
    selectValue: undefined
  onChange: (name, e) ->
    that = @
    keyword = e.target.value.text
    if keyword is '新しくキーワードを追加'
      swal {
        title: '新しくキーワードを追加'
        text:  '追加したいキーワードを入力してください'
        type:  'input'
        showCancelButton: true
        closeOnConfirm: false
        animation: 'slide-from-top'
        inputPlaceholder: 'キーワードを入力'
      }, (inputValue)->
        if inputValue is false
          return false
        if inputValue is ''
          swal.showInputError 'キーワードを入力してください。'
          return false
        keyword = inputValue
        newKeywords = that.state.keywords
        newKeywords.push
          'text': keyword
        that.setState
          keywords : newKeywords
        swal '送信完了！', 'キーワードを追加しました。', 'success'
    change = {}
    change[name] = e.target.value
    @setState change
    @props.onChangeKeyword(keyword)
  componentWillMount: ->
    that = @
    $.get './keywords', (data)->
      newKeywords = []
      for d in data
        newKeywords.push
          'text': d.text
      newKeywords.push
          'text': '新しくキーワードを追加'
      that.setState
        keywords : newKeywords
  render: ->
    <SelectField
      value={@state.selectValue}
      onChange={@onChange.bind(null, 'selectValue')}
      hintText="キーワードを選択"
      menuItems={@state.keywords} />
