import React, { Component } from 'react';
import Client from './Client.js';

class UserTable extends Component {

    constructor(props) {
        super(props);

        this.state = {
            users: []
        }
    };

    componentDidMount() {
        Client.getUsers((users) => {
            this.setState({ users })
        })
    };

    render() {
        return (
            <div className="UserTable">
                <table className="ui celled table">
                    <thead>
                    <tr>
                        <th>Name</th>
                        <th>CPF</th>
                        <th>Birthday</th>
                        <th>Gender</th>
                    </tr>
                    </thead>
                    <tbody>
                    { this.state.users.map((user, idx) => (
                        <tr key={idx}>
                            <td>{user.full_name}</td>
                            <td>{user.cpf}</td>
                            <td>{user.birthday_date}</td>
                            <td>{user.gender}</td>
                        </tr>)) }
                    </tbody>
                </table>
            </div>
        );
    }
}

export default UserTable;