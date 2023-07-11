resource "aws_apigatewayv2_integration" "lambda_hello" {
    api_id = aws_apigatewayv2_api.main.id
    integration_type = "AWS_PROXY"
    integration_method = "POST"
    integration_uri = aws_lambda_function.hello.invoke_arn
    payload_format_version = "2.0"
}


resource "aws_apigatewayv2_route" "get_hello" {
    api_id = aws_apigatewayv2_api.main.id
    route_key = "GET /hello"
    target = "integrations/${aws_apigatewayv2_integration.lambda_hello.id}"

}

resource "aws_apigatewayv2_route" "post_hello" {
    api_id = aws_apigatewayv2_api.main.id
    route_key = "POST /hello"
    target = "integrations/${aws_apigatewayv2_integration.lambda_hello.id}"

}


resource "aws_lambda_permission" "api_gw" {
    statement_id = "AllowExecutionFromAPIGateway"
    action = "lambda:InvokeFunction"
    function_name = aws_lambda_function.hello.function_name
    principal = "apigateway.amazonaws.com"
    source_arn = "${aws_apigatewayv2_api.main.execution_arn}/*/*"
}

output "api_gw_invoke_url" {
    value = aws_apigatewayv2_stage.dev.invoke_url
}