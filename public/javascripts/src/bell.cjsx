React = require 'react'
Mui   = require 'material-ui'

BellButtonSend       = require './bell-button-send.cjsx'
BellKeywordSelector  = require './bell-keyword-selector.cjsx'
BellTeamSelector     = require './bell-team-selector.cjsx'
BellButtonAddKeyword = require './bell-button-add-keyword.cjsx'
Logo                 = require './logo.cjsx'

Paper = Mui.Paper

ThemeManager = new Mui.Styles.ThemeManager()

module.exports = React.createClass
  getInitialState: ->
    keyword  : ""
    team_id  : undefined
    keywords : []
    teams    : []
  getChildContext: ->
    muiTheme: ThemeManager.getCurrentTheme()
  childContextTypes:
    muiTheme: React.PropTypes.object
  getStyles: ->
    root:
      margin    : "0 auto"
      textAlign : "center"
      padding   : "16px"
  onChangeTeam: (t)->
    localStorage.setItem 'team_id', t
    @setState
      team_id: t
  onChangeKeyword: (k)->
    @setState
      keyword: k
  sendMessage: ->
    if @state.team_id is undefined
      swal 'エラー！', 'チーム名を選択して下さい。', 'error'
    else if @state.keyword is ''
      swal 'エラー！', 'メッセージを選択して下さい。', 'error'
    else
      that = @
      team = _.find that.state.teams, (obj)->
        return obj.id is that.state.team_id
      $.ajax
        type : 'GET'
        url  : './bells'
        data :
          keywords : @state.keyword
          team     : team.name
        success : (data, dataType)->
          swal '送信完了！', 'メンターにメッセージを送信しました。', 'success'
        error : (XMLHttpRequest, textStatus, errorThrown)->
          swal 'エラー！', '送信エラーです。', 'error'
  addKeyword: ->
    that = @
    swal {
      title : '新しくキーワードを追加'
      text  : '追加したいキーワードを入力してください。'
      type  : 'input'
      showCancelButton : true
      closeOnConfirm   : false
      animation        : 'slide-from-top'
      inputPlaceholder : 'キーワードを入力'
    }, (inputValue)->
      if inputValue is false
        return false
      if inputValue is ''
        swal.showInputError 'キーワードを入力してください。'
        return false
      $.ajax
        type : 'POST'
        url  : './keywords'
        data :
          keyword: inputValue
        success : (data, dataType)->
          newKeywords = that.state.keywords
          newKeywords.push
            'text': inputValue
          that.setState
            keywords: newKeywords
          swal '送信完了！', 'キーワードを追加しました。', 'success'
        error : (XMLHttpRequest, textStatus, errorThrown)->
          swal 'エラー！', '送信エラーです。', 'error'
  componentWillMount: ->
    that = @
    $.get './keywords', (data)->
      newKeywords = []
      for d in data
        newKeywords.push
          'text': d.text
      that.setState
        keywords: newKeywords
    $.get './teams', (data)->
      that.setState
        teams: data
    current_team_id = localStorage.getItem 'team_id'
    unless current_team_id is null
      that.setState
        team_id: parseInt current_team_id
  render: ->
    styles = @getStyles()
    <div className="mdl-grid">
      <div className="mdl-cell mdl-cell--2-col mdl-cell--hide-phone mdl-cell--hide-tablet"></div>
      <div className="mdl-cell mdl-cell--2-col mdl-cell--hide-phone"></div>
      <div className="mdl-cell mdl-cell--4-col">
        <Paper style={styles.root} zDepth={2}>
          <Logo />
          <BellTeamSelector teamid={@state.team_id} teams={@state.teams} onChangeTeam={@onChangeTeam} /><br />
          <BellKeywordSelector keywords={@state.keywords} onChangeKeyword={@onChangeKeyword} /><br /><br />
          <BellButtonSend sendMessage={@sendMessage} />&nbsp;
          <BellButtonAddKeyword addKeyword={@addKeyword}/>
        </Paper>
      </div>
      <div className="mdl-cell mdl-cell--2-col mdl-cell--hide-phone"></div>
      <div className="mdl-cell mdl-cell--2-col mdl-cell--hide-phone mdl-cell--hide-tablet"></div>
    </div>
