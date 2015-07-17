React        = require 'react'
Mui          = require 'material-ui'

BellKeywords = require './bell-keywords.cjsx'
BellButton   = require './bell-button.cjsx'
BellTeamSelector = require './bell-team-selector.cjsx'

ThemeManager = new Mui.Styles.ThemeManager()

module.exports = React.createClass
    getInitialState: ->
        keywords: ""
        teams: []
        selectedTeam: undefined
    getChildContext: ->
        muiTheme : ThemeManager.getCurrentTheme()
    childContextTypes:
        muiTheme : React.PropTypes.object
    componentDidMount: ->
        # dummy
        @setState
            teams: [
              {
                name : "aaa"
              }
            ]
        # $.get './teams', (data)->
        #     @setState
        #         teams: data
    onChangeTeam: (selectedIndex)->
        alert(selectedIndex)
    onChangeKeywords: (ks)->
        @setState
            keywords: ks
    sendMessage: ->
        if @state.selectedTeam is undefined
            swal('エラー！', 'チーム名を選択して下さい。', 'error')
        else if @state.keywords is ''
            swal('エラー！', 'メッセージを入力して下さい。', 'error')
        else
            $.ajax
                type : 'GET'
                url  : './bells'
                data :
                    keywords : @state.keywords
                success : (data, dataType)->
                    swal('送信完了！', 'メンターにメッセージを送信しました。', 'success')
                error : (XMLHttpRequest, textStatus, errorThrown)->
                    swal('エラー！', '送信エラーです。', 'error')
    render: ->
        <div className="mdl-grid">
            <div className="mdl-cell mdl-cell--4-col">
                <BellTeamSelector teams={@state.teams} onChangeTeam={@onChangeTeam} /><br />
                <BellKeywords onChangeKeywords={@onChangeKeywords} /><br />
                <BellButton sendMessage={@sendMessage} />
            </div>
        </div>
