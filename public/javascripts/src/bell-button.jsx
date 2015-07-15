var React = require('react');

module.exports = React.createClass({
    onClick : function() {
        this.props.sendMessage();
    },
    render : function() { return (
        <button onClick={this.onClick} className="mdl-button mdl-js-button mdl-button--raised mdl-button--accent mdl-js-ripple-effect">
            SEND
        </button>
    );}
});
