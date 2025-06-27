exports.handler = async (event) => {
  const name = event.name && event.name.trim() ? event.name.trim() : "nonombre";
  const response = {
    statusCode: 200,
    body: JSON.stringify({ message: `Hello ${name}` }),
  };
  return response;
};