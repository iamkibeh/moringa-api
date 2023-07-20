module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = find_user_by_jwt_token
      logger.add_tags 'ActionCable', current_user.id
      reject_unauthorized_connection unless current_user
    end


    private
    def find_user_by_jwt_token
        token = extract_jwt_token_from_headers
        return unless token.present?

        decoded_token =  JWT.decode(token, "my_s3cr3t", true, algorithm: "HS256")
        user_id = decoded_token[0]["user_id"]
        User.find_by(id: user_id)
    rescue JWT::DecodeError, ActiveRecord::RecordNotFound => e
        nil
    end

    # end

    def extract_jwt_token_from_headers
        authorized_headers = request.query_parameters["Authorization"]
        return unless authorized_headers.present?

        token = authorized_headers.split(' ').last
        token
    end
  end
end