React        = require 'react'
Mui          = require 'material-ui'

BellKeywords = require './bell-keywords.cjsx'
BellButton   = require './bell-button.cjsx'

ThemeManager = new Mui.Styles.ThemeManager()

module.exports = React.createClass
    getInitialState: ->
        keywords: ""
    getChildContext: ->
        muiTheme : ThemeManager.getCurrentTheme()
    childContextTypes:
        muiTheme : React.PropTypes.object
    onChangeKeywords: (ks)->
        @setState
            keywords: ks
    sendMessage: ->
        unless @state.keywords is ''
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
                <BellKeywords onChangeKeywords={@onChangeKeywords} /><br />
                <BellButton sendMessage={@sendMessage} />
            </div>
        </div>
