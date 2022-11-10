class SignupsController < ApplicationController
rescue_from ActiveRecord::RecordInvalid, with: :render_invalid
    def create
        signup =  Signup.create!(signup_params)
        render json: signup.activity, status: 201
    end

    private

    def signup_params
        params.permit(:camper_id, :activity_id, :time)
    end

    def render_invalid(error)
        render json: {errors: error.record.errors.full_messages}, status: 422
    end

end
