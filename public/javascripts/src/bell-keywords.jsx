var React = require('react');

module.exports = React.createClass({
    handleChange : function(event) {
        this.props.onChangeKeywords(event.target.value);
    },
    render : function() { return (
        <div className="mdl-textfield mdl-js-textfield textfield-demo">
            <input onChange={this.handleChange} className="mdl-textfield__input" text="text" id="keywords" />
            <label className="mdl-textfield__label" htmlFor="keywords">keywords...</label>
        </div>
    );}
});
