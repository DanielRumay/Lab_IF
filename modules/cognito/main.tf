resource "aws_cognito_user_pool" "user_pool" {
  name = "recetas-user-pool"
}

resource "aws_cognito_user_pool_client" "user_pool_client" {
  name                         = "recetas-client"
  user_pool_id                 = aws_cognito_user_pool.user_pool.id
  generate_secret              = false
  allowed_oauth_flows_user_pool_client = true
  allowed_oauth_flows         = ["code"]
  allowed_oauth_scopes        = ["email", "openid", "profile"]
  callback_urls               = ["https://example.com/callback"]
  logout_urls                 = ["https://example.com/logout"]
  supported_identity_providers = ["COGNITO"]
}

