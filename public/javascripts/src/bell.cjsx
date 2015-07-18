React        = require 'react'
Mui          = require 'material-ui'

BellKeywords = require './bell-keywords.cjsx'
BellButton   = require './bell-button.cjsx'
BellTeamSelector = require './bell-team-selector.cjsx'

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
                    keywords : @state.keyword
                success : (data, dataType)->
                    swal('送信完了！', 'メンターにメッセージを送信しました。', 'success')
                error : (XMLHttpRequest, textStatus, errorThrown)->
                    swal('エラー！', '送信エラーです。', 'error')
    render: ->
        <div className="mdl-grid">
            <div className="mdl-cell mdl-cell--4-col">
                <BellTeamSelector onChangeTeam={@onChangeTeam} /><br />
                <BellKeywords onChangeKeyword={@onChangeKeyword} /><br />
                <BellButton sendMessage={@sendMessage} />
            </div>
        </div>
