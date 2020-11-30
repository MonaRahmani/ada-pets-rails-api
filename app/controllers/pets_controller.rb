class PetsController < ApplicationController
  def index
    @pets = Pet.all.order(:name)
    render json: { ok: 'YESS'}, status: :ok
  end
end
