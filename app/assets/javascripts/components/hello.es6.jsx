class Hello extends React.Component {
  render() {
    const { greeting, for_whom } = this.props;
    return (
      <div className="text-uppercase">
        <h1>{greeting}, {for_whom}!</h1>
        <div>Welcome to Sales Assistant</div>
        <img src="/assets/logo1.png" alt='Sales Assistant' />
      </div>
    )
  }
}
