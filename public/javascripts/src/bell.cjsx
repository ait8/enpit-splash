React        = require 'react'
BellKeywords = require './bell-keywords.cjsx'
BellButton   = require './bell-button.cjsx'

module.exports = React.createClass
    getInitialState: ->
        keywords: ""
    onChangeKeywords: (ks)->
        @setState
            keywords: ks
    sendMessage: ->
        unless @state.keywords is ''
            $.get './bells',
                keywords: @state.keywords
    render: ->
        <div className="mdl-grid">
            <div className="mdl-cell mdl-cell--4-col">
                <BellKeywords onChangeKeywords={@onChangeKeywords} /><br />
                <BellButton sendMessage={@sendMessage} />
            </div>
        </div>
