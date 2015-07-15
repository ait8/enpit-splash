var React = require('react');
var BellKeywords = require('./bell-keywords.jsx');
var BellButton = require('./bell-button.jsx');

module.exports = React.createClass({
    getInitialState : function() {
        return {
            keywords : ""
        }
    },
    onChangeKeywords : function(keywords) {
        this.setState({
            keywords : keywords
        });
    },
    sendMessage : function() {
        if (this.state.keywords !== '') {
            var data = {
                keywords : this.state.keywords
            };
            $.get('./bells', data);
        }
    },
    render : function() { return (
        <div className="mdl-grid">
            <div className="mdl-cell mdl-cell--4-col">
                <BellKeywords onChangeKeywords={this.onChangeKeywords} />
                <BellButton sendMessage={this.sendMessage} />
            </div>
        </div>
    );}
});
