module AuthHelper
  def sign_in_as(user)
    payload = { user_id: user.id }
    session = JWTsessions::Session.new(payload: payload)
    tokens = session.login
    request.cookies[JWTsessions.access_cookie] = tokens[:access]
    request.headers[JWTsessions.csrf_header] = tokens[:csrf]
  end
end