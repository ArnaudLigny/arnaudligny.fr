const Post = createClass({
  render() {
    const entry = this.props.entry;
    const date = entry.getIn(['data', 'date']);
    const image = entry.getIn(['data', 'image']);
    const bg = this.props.getAsset(image);
    const tags = entry.getIn(['data', 'tags']);
    try {
      date = date.toLocaleDateString('fr-FR', {year:'numeric', month:'short', day:'numeric'});
    } catch (e) {
      date ? date = date.toString() : null;
    }
    return h('div', {},
      h('h1', {}, entry.getIn(['data', 'title'])),
      h('div', {"className": "post-meta"},
        h('span', {"className": "post-date"}, date)
      ),
      bg ? h('img', {src: bg.toString()}) : null,
      this.props.widgetFor('body'),
      tags ? tags.map(function(value) {
        return h('span', {},
          h('a', {}, '#'+value),
          ' '
        );
      }) : null
    );
  }
});

export default Post
