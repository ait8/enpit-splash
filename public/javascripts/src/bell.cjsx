React = require 'react'
Mui   = require 'material-ui'

BellButtonSend       = require './bell-button-send.cjsx'
BellKeywordSelector  = require './bell-keyword-selector.cjsx'
BellTeamSelector     = require './bell-team-selector.cjsx'
BellButtonAddKeyword = require './bell-button-add-keyword.cjsx'
Logo                = require './logo.cjsx'

Paper = Mui.Paper

ThemeManager = new Mui.Styles.ThemeManager()

module.exports = React.createClass
  getInitialState: ->
    keyword: ""
    team: ""
    keywords: []
    teams: []
    selectedTeam: undefined
  getChildContext: ->
    muiTheme : ThemeManager.getCurrentTheme()
  childContextTypes:
    muiTheme : React.PropTypes.object
  getStyles: ->
    root:
      margin: "0 auto"
      textAlign: "center"
      padding: "16px"
  onChangeTeam: (t)->
    @setState
      team: t
  onChangeKeyword: (k)->
    @setState
      keyword: k
  sendMessage: ->
    if @state.team is ''
      swal 'エラー！', 'チーム名を選択して下さい。', 'error'
    else if @state.keyword is ''
      swal 'エラー！', 'メッセージを選択して下さい。', 'error'
    else
      $.ajax
        type : 'GET'
        url  : './bells'
        data :
          keywords : @state.keyword,
          team : @state.team
        success : (data, dataType)->
          swal '送信完了！', 'メンターにメッセージを送信しました。', 'success'
        error : (XMLHttpRequest, textStatus, errorThrown)->
          swal 'エラー！', '送信エラーです。', 'error'
  addKeyword: ->
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
        selectValue: undefined
      swal '送信完了！', 'キーワードを追加しました。', 'success'
  componentWillMount: ->
    that = @
    $.get './keywords', (data)->
      newKeywords = []
      for d in data
        newKeywords.push
          'text': d.text
      that.setState
        keywords : newKeywords
    $.get './teams', (data)->
      newTeams = []
      for d in data
        newTeams.push
          'text': d.text
      that.setState
        teams : newTeams
  render: ->
    styles = @getStyles()
    <div className="mdl-grid">
      <div className="mdl-cell mdl-cell--2-col mdl-cell--hide-phone mdl-cell--hide-tablet"></div>
      <div className="mdl-cell mdl-cell--2-col mdl-cell--hide-phone"></div>
      <div className="mdl-cell mdl-cell--4-col">
        <Paper style={styles.root} zDepth={2}>
          <Logo />
          <BellTeamSelector teams={@state.teams} onChangeTeam={@onChangeTeam} /><br />
          <BellKeywordSelector keywords={@state.keywords} onChangeKeyword={@onChangeKeyword} /><br /><br />
          <BellButtonSend sendMessage={@sendMessage} />&nbsp;
          <BellButtonAddKeyword addKeyword={@addKeyword}/>
        </Paper>
      </div>
      <div className="mdl-cell mdl-cell--2-col mdl-cell--hide-phone"></div>
      <div className="mdl-cell mdl-cell--2-col mdl-cell--hide-phone mdl-cell--hide-tablet"></div>
    </div>
