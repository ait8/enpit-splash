React = require 'react'
Mui   = require 'material-ui'

BellButton          = require './bell-button.cjsx'
BellKeywordSelector = require './bell-keyword-selector.cjsx'
BellTeamSelector    = require './bell-team-selector.cjsx'
Logo                = require './logo.cjsx'

Paper = Mui.Paper

ThemeManager = new Mui.Styles.ThemeManager()

module.exports = React.createClass
  getInitialState: ->
    keyword: ""
    team: ""
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
      swal('エラー！', 'チーム名を選択して下さい。', 'error')
    else if @state.keyword is ''
      swal('エラー！', 'メッセージを選択して下さい。', 'error')
    else
      $.ajax
        type : 'GET'
        url  : './bells'
        data :
          keywords : @state.keyword,
          team : @state.team
        success : (data, dataType)->
          swal('送信完了！', 'メンターにメッセージを送信しました。', 'success')
        error : (XMLHttpRequest, textStatus, errorThrown)->
          swal('エラー！', '送信エラーです。', 'error')
  render: ->
    styles = @getStyles()
    <div className="mdl-grid">
      <div className="mdl-cell mdl-cell--2-col mdl-cell--hide-phone mdl-cell--hide-tablet"></div>
      <div className="mdl-cell mdl-cell--2-col mdl-cell--hide-phone"></div>
      <div className="mdl-cell mdl-cell--4-col">
        <Paper style={styles.root} zDepth={2}>
          <Logo />
          <BellTeamSelector onChangeTeam={@onChangeTeam} /><br />
          <BellKeywordSelector onChangeKeyword={@onChangeKeyword} /><br /><br />
          <BellButton sendMessage={@sendMessage} />
        </Paper>
      </div>
      <div className="mdl-cell mdl-cell--2-col mdl-cell--hide-phone"></div>
      <div className="mdl-cell mdl-cell--2-col mdl-cell--hide-phone mdl-cell--hide-tablet"></div>
    </div>
