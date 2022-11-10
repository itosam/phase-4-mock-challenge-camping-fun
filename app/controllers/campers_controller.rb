class CampersController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
rescue_from ActiveRecord::RecordInvalid, with: :render_invalid

    def index
        render json: Camper.all, status: :ok
    end

    def show
        camper = Camper.find(params[:id])
        render json: camper, serializer: CamperActivitySerializer, status: :ok
    end

    def create
        camper = Camper.create!(camper_params)
        render json: camper, status: 201
    end

    private

    def render_not_found
        render json: {error: "Camper not found"}, status: 404
    end

    def render_invalid(error)
        render json: {errors: error.record.errors.full_messages}, status: 422
    end

    def camper_params
        params.permit(:name, :age)
    end

end
