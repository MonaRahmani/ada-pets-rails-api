class PetsController < ApplicationController
  def index
    pets = Pet.all.order(:name)
    render json: pets.as_json(only: [:id, :name, :specious, :age, :owner]), status: :ok
  end

  def show
    pet = Pet.find_by(id: params[:id])

    if pet.nil?
      render json: {
          ok: false,
          message: 'not found',
      }, status: :not_found
      return
    end
    render json: pet.as_json(only: [:id, :name, :specious, :age, :owner]), status: :ok
  end

  def create
    pet = Pet.new(pet_params)

    if pet.save
      render json: pet.as_json(only: [:id]), status: :created
    else
      render json: { errors: pet.errors.messages }, status: :bad_request
    end


  end

  private
  def pet_params
    params.require(:pet).permit(:name, :specious, :age, :owner)
  end
end
