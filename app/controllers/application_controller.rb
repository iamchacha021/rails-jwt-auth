class ApplicationController < ActionController::API
    before_action :authorized
    def encode_token(payload) #used to encode token
      # should store secret in env variable
      JWT.encode(payload, "my_s3cr3t")
    end
    def auth_header #used to decode token
      # { Authorization: 'Bearer <token>' }
      request.headers["Authorization"]
    end
    def decoded_token
      if auth_header
        token = auth_header.split(" ")[1]
        # header: { 'Authorization': 'Bearer <token>' }
        begin
          JWT.decode(token, "my_s3cr3t", true, algorithm: "HS256")
        rescue JWT::DecodeError
          nil
        end
      end
    end
    def current_user
      if decoded_token
        user_id = decoded_token[0]["user_id"]
        @user = Usr.find_by(id: user_id)
      end
    end
    def logged_in?
      !!current_user
    end
    def logged
      render json: { logged_in: logged_in?, user: @user }
    end
    def authorized
      render json: { message: "Please log in" }, status: :unauthorized unless logged_in?
    end
end
