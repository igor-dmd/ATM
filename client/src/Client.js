/**
 * Created by programacao on 22/05/17.
 */
function getUsers(cb) {
    return fetch('users', {
        accept: 'application/json',
    }).then(parseJSON)
        .then(cb);
}

function parseJSON(response) {
    return response.json();
}

const Client = { getUsers };
export default Client;