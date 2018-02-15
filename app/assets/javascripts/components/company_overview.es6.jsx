class CompanyOverview extends React.Component {
  render () {
    const { company } = this.props;
    return (
        <div className="card">
            <div className="card-header">
                <h4 className="card-title">
                    Overview
                </h4>
            </div>
            <div className="card-content">
                <div className="card-body">
                    <div className="row">
                        <div className="card-text col-sm-2">
                            <img src={company.logo} alt={company.name} className="company-logo"/>
                        </div>
                        <div className="card-text col-sm-10">
                            <h4>{company.name}</h4>
                            <a href={company.url_domain} target="_blank">{company.url_domain}</a>
                        </div>
                    </div>
                    <div className="row">
                        <div className="card-text col-sm-2">
                            <h6>Description</h6>
                        </div>
                        <div className="card-text col-sm-10">
                            <p>{company.overview}</p>
                        </div>
                    </div>
                    <div className="row">
                        <div className="card-text col-sm-2">
                            <h6>Founded Year</h6>
                        </div>
                        <div className="card-text col-sm-10">
                            <p>{company.founded}</p>
                        </div>
                    </div>
                    <div className="row">
                        <div className="card-text col-sm-2">
                            <h6>Count of Employees</h6>
                        </div>
                        <div className="card-text col-sm-10">
                            <p>{company.approx_employees}</p>
                        </div>
                    </div>
                    <div className="row">
                        <div className="card-text col-sm-2">
                            <h6>Industries</h6>
                        </div>
                        <div className="card-text col-sm-10">
                            <ul>
                                {company.industries.map(function(industry){
                                    return(
                                        <li key={industry.id}>{industry.name}</li>
                                    )
                                })}
                            </ul>
                        </div>
                    </div>
                    <div className="row">
                        <div className="col-12">
                            <a href={company.pages_path} className="btn btn-secondary btn-lg btn-block">
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


