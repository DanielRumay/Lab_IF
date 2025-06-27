import sys
import os

sys.path.append(os.path.abspath(os.path.join(os.path.dirname(__file__), '../terraform')))
import lambda_function

def test_lambda_response_is_dict():
    event = {"test": "value"}
    result = lambda_function.lambda_handler(event, None)
    assert isinstance(result, dict)

def test_lambda_has_keys():
    event = {"queryStringParameters": {"param1": "value1"}}
    result = lambda_function.lambda_handler(event, None)
    assert "statusCode" in result
    assert "body" in result