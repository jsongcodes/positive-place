class ApplicationController < ActionController::API
    include ActionController::Cookies

    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

    before_action :authorize

    def authorize
        @current_user = Student.find_by(id: session[:user_id])
        render json: { errors: ["Not authorized"] }, status: :unauthorized unless @current_user
    end

    def render_unprocessable_entity_response(e)
        render json: {errors: e.record.errors.full_messages}, status: :unprocessable_entity
    end

    def render_not_found_response(invalid)
        render json: { errors: invalid }, status: :not_found
    end

end