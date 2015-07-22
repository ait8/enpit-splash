React = require 'react'
Mui   = require 'material-ui'

Logo                 = require './logo.cjsx'
BellTeamSelector     = require './bell-team-selector.cjsx'
BellKeywordSelector  = require './bell-keyword-selector.cjsx'
BellButtonAddKeyword = require './bell-button-add-keyword.cjsx'
BellButtonSend       = require './bell-button-send.cjsx'

Paper = Mui.Paper

ThemeManager = new Mui.Styles.ThemeManager()

module.exports = React.createClass
  childContextTypes:
    muiTheme: React.PropTypes.object
  getInitialState: ->
    keyword  : ""
    teamId   : undefined
    keywords : []
    teams    : []
  getChildContext: ->
    muiTheme: ThemeManager.getCurrentTheme()
  getStyles: ->
    root:
      margin    : "0 auto"
      textAlign : "center"
      padding   : "16px"
  onChangeTeam: (t)->
    localStorage.setItem 'teamId', t
    @setState
      teamId: t
  onChangeKeyword: (k)->
    @setState
      keyword: k
  sendMessage: ->
    if !@state.teamId?
      swal 'エラー！', 'チーム名を選択して下さい。', 'error'
    else if @state.keyword is ''
      swal 'エラー！', 'メッセージを選択して下さい。', 'error'
    else
      team = _.findWhere @state.teams, {"id": @state.teamId}
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
      html  : true
      title : '新しくキーワードを追加'
      text  : '
        新しく追加したいキーワードを入力してください。<br />
        <strong>※ キーワードは全チームで共有されます。</strong><br />
        <strong>※ 追加した時点ではメンターには送信されません。</strong>'
      type  : 'input'
      showCancelButton : true
      closeOnConfirm   : false
      animation        : 'slide-from-top'
      inputPlaceholder : '新しいキーワードを入力'
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
          that.state.keywords.push
            'text': inputValue
          swal '追加完了！', 'キーワードを追加しました。', 'success'
        error : (XMLHttpRequest, textStatus, errorThrown)->
          swal 'エラー！', '送信エラーです。', 'error'
  componentWillMount: ->
    that = @
    $.get './keywords', (data)->
      that.setState
        keywords: data
    $.get './teams', (data)->
      that.setState
        teams: data
    currentTeamId = localStorage.getItem 'teamId'
    if currentTeamId?
      that.setState
        teamId: parseInt currentTeamId
  render: ->
    styles = @getStyles()
    <div className="mdl-grid">
      <div className="mdl-cell mdl-cell--2-col mdl-cell--hide-phone mdl-cell--hide-tablet"></div>
      <div className="mdl-cell mdl-cell--2-col mdl-cell--hide-phone"></div>
      <div className="mdl-cell mdl-cell--4-col">
        <Paper style={styles.root} zDepth={2}>
          <Logo />
          <BellTeamSelector teamId={@state.teamId} teams={@state.teams} onChangeTeam={@onChangeTeam} /><br />
          <BellKeywordSelector keywords={@state.keywords} onChangeKeyword={@onChangeKeyword} /><br /><br />
          <BellButtonSend sendMessage={@sendMessage} />&nbsp;
          <BellButtonAddKeyword addKeyword={@addKeyword}/>
        </Paper>
      </div>
      <div className="mdl-cell mdl-cell--2-col mdl-cell--hide-phone"></div>
      <div className="mdl-cell mdl-cell--2-col mdl-cell--hide-phone mdl-cell--hide-tablet"></div>
    </div>
