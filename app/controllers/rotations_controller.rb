# frozen_string_literal: true

class RotationsController < ApplicationController
  before_action :set_rotation, only: %i[show edit update destroy]

  # GET /rotations
  def index
    @rotations = Rotation.all
  end

  # GET /rotations/1
  def show; end

  # GET /rotations/new
  def new
    @rotation = Rotation.new
  end

  # GET /rotations/1/edit
  def edit; end

  # POST /rotations
  def create
    @rotation = Rotation.new(rotation_params)

    if @rotation.save
      redirect_to @rotation, notice: "Rotation was successfully created."
    else
      render :new
    end
  end

  # PATCH/PUT /rotations/1
  def update
    if @rotation.update(rotation_params)
      redirect_to @rotation, notice: "Rotation was successfully updated."
    else
      render :edit
    end
  end

  # DELETE /rotations/1
  def destroy
    @rotation.destroy
    redirect_to rotations_url, notice: "Rotation was successfully destroyed."
  end

  def upload; end

  def batch_create
    @result =
      BatchCreateSpotsFlow.call(csv_file: batch_create_params[:csv_file],
                                klass: "Rotation")
    respond_to do |format|
      if @result.success?
        format.html do
          redirect_to rotations_path,
                      notice: "Batch upload started successfully."
        end
        format.json { render json: ["OK"], status: :ok, location: rotations_path }
      else
        format.html { render :upload }
        format.json { render json: @result.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_rotation
    @rotation = Rotation.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def rotation_params
    params.require(:rotation).permit(:start, :end, :name)
  end

  def batch_create_params
    params.require(:batch).permit(:csv_file)
  end
end
