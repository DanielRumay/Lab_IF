const { handler } = require('./index.js'); // Importa el handler de la función Lambda

describe('Lambda Handler', () => {
  it('should return greeting with provided name', async () => {
    const event = { name: 'Testito' };
    const expected = JSON.stringify({ message: 'Hello Testito' });

    const result = await handler(event);

    expect(result.statusCode).toBe(200);
    expect(result.body).toBe(expected);
  });

  it('should return greeting with "nonombre" when no name is provided', async () => {
    const event = {};
    const expected = JSON.stringify({ message: 'Hello nonombre' });

    const result = await handler(event);

    expect(result.statusCode).toBe(200);
    expect(result.body).toBe(expected);
  });

  it('should return greeting with "nonombre" when name is an empty string', async () => {
    const event = { name: '' };
    const expected = JSON.stringify({ message: 'Hello nonombre' });

    const result = await handler(event);

    expect(result.statusCode).toBe(200);
    expect(result.body).toBe(expected);
  });

  it('should return greeting with "nonombre" when name is a single space', async () => {
    const event = { name: ' ' };
    const expected = JSON.stringify({ message: 'Hello nonombre' });

    const result = await handler(event);

    expect(result.statusCode).toBe(200);
    expect(result.body).toBe(expected);
  });

  it('should return greeting with "nonombre" when no name key is present', async () => {
    const event = {};
    const expected = JSON.stringify({ message: 'Hello nonombre' });

    const result = await handler(event);

    expect(result.statusCode).toBe(200);
    expect(result.body).toBe(expected);
  });
});
