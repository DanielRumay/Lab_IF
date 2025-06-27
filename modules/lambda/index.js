function lambdaHandler(event) {
    const name = event.name ?? "nonombre";
    return {
        statusCode: 200,
        body: JSON.stringify({
            message: `Hola, ${name}`
        })
    };
}

module.exports = { lambdaHandler };