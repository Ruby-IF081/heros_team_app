class CompanyOverview extends React.Component {
  render () {
    return (
        <div className="card" id="overview">
            <div className="card-header">
                <h4 className="card-title">
                    Overview
                </h4>
            </div>
            <div className="card-content">
                <div className="card-body">
                    <div className="row">
                        <div className="card-text col-sm-2">
                            <img src={`${this.props.logo}`} alt={`${this.props.company.name}`} className="company-logo"/>
                        </div>
                        <div className="card-text col-sm-10">
                            <h4>{this.props.company.name}</h4>
                            <a href={`${this.props.url_domain}`} target="_blank">{this.props.url_domain}</a>
                        </div>
                    </div>
                    <div className="row">
                        <div className="card-text col-sm-2">
                            <h6>Description</h6>
                        </div>
                        <div className="card-text col-sm-10">
                            <p>{this.props.company.overview}</p>
                        </div>
                    </div>
                    <div className="row">
                        <div className="card-text col-sm-2">
                            <h6>Founded Year</h6>
                        </div>
                        <div className="card-text col-sm-10">
                            <p>{this.props.company.founded}</p>
                        </div>
                    </div>
                    <div className="row">
                        <div className="card-text col-sm-2">
                            <h6>Count of Employees</h6>
                        </div>
                        <div className="card-text col-sm-10">
                            <p>{this.props.company.approx_employees}</p>
                        </div>
                    </div>
                    <div className="row">
                        <div className="card-text col-sm-2">
                            <h6>Industries</h6>
                        </div>
                        <div className="card-text col-sm-10">
                            <ul>
                                {this.props.industries.sort(function(a, b){return (a.name > b.name) ? 1 : ((b.name > a.name) ? -1 : 0);}).map(function(x){
                                    return(
                                        <li>{x.name}</li>
                                    )
                                })}
                            </ul>
                        </div>
                    </div>
                    <div className="row">
                        <div className="col-12">
                            <a href={`${this.props.pages_path}`} className="btn btn-secondary btn-lg btn-block">
                                See company pages
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    )
  }
}


