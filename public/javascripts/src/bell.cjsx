React        = require 'react'
BellKeywords = require './bell-keywords.cjsx'
BellButton   = require './bell-button.cjsx'

module.exports = React.createClass
    getInitialState: ->
        keywords: ""
    onChangeKeywords: (keywords)->
        this.setState
            keywords: keywords
    sendMessage: ->
        unless this.state.keywords is ''
            $.get './bells',
                keywords: this.state.keywords
    render: ->
        <div className="mdl-grid">
            <div className="mdl-cell mdl-cell--4-col">
                <BellKeywords onChangeKeywords={this.onChangeKeywords} /><br />
                <BellButton sendMessage={this.sendMessage} />
            </div>
        </div>
