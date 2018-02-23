class UserOverview extends React.Component {
    render(){
        const { user } = this.props;
        return(
            <div id={"overview"} className={"card"}>
                <div className={"card-header"}>
                    <h4 className={"card-title"}>
                        Profile
                    </h4>
                </div>
                <div className={"card-content"}>
                    <div className={"card-body"}>
                        <div className={"row"}>
                            <div className={"card-image col-sm-2"}>
                              <img src={user.avatar_url} alt={user.full_name} />
                            </div>
                            <div className={"card-text col-sm-8"}>
                                <div className={"row"}>
                                    <div className={"card-text col-sm-2"}>
                                        <h6>
                                            Full name:
                                        </h6>
                                    </div>
                                    <div className={"card-text col-sm-4"}>
                                        <p>{user.full_name}</p>
                                    </div>
                                </div>
                                <div className={"row"}>
                                    <div className={"card-text col-sm-2"}>
                                        <h6>
                                            User-email:
                                        </h6>
                                    </div>
                                    <div className={"card-text col-sm-4"}>
                                        <p>{user.email}</p>
                                    </div>
                                </div>
                                <div className={"row"}>
                                    <div className={"card-text col-sm-2"}>
                                        <h6>
                                            Role:
                                        </h6>
                                    </div>
                                    <div className={"card-text col-sm-4"}>
                                        <p>{user.role}</p>
                                    </div>
                                </div>
                                <div className={"row"}>
                                    <div className={"card-text col-sm-2"}>
                                        <h6>
                                            Created at:
                                        </h6>
                                    </div>
                                    <div className={"card-text col-sm-10"}>
                                        <p>{user.created_at}</p>
                                    </div>
                                </div>
                                <div className={"row"}>
                                    <div className={"card-text col-sm-2"}>
                                        <h6>
                                            Tenant:
                                        </h6>
                                    </div>
                                    <div className={"card-text col-sm-10"}>
                                        <p>{user.tenant_name}</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

        )
    }
}
