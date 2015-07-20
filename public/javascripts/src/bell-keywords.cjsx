React = require 'react'
Mui   = require 'material-ui'

SelectField = Mui.SelectField

module.exports = React.createClass
    mixins: [React.addons.LinkedStateMixin]
    getInitialState: ->
        keywords : []
        selectValue: undefined
    onChange: (name, e) ->
        change = {}
        change[name] = e.target.value
        @setState change
        @props.onChangeKeyword(e.target.value.text)
    componentWillMount: ->
        that = @
        $.get './keywords', (data)->
            newKeywords = []
            for d in data
                newKeywords.push
                    "text": d.text
            that.setState
                keywords : newKeywords
    render: ->
        <SelectField
            value={@state.selectValue}
            onChange={@onChange.bind(null, 'selectValue')}
            hintText="Select Keyword..."
            menuItems={@state.keywords} />
