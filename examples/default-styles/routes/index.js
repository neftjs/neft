module.exports = (app) => {
    return {
        'get /': {
            redirect: '/Button'
        },
        'get /{element}': {
        }
    };
};
