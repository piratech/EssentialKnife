class RequestsController < ApplicationController
  before_action :set_request, only: [:show, :edit, :update, :destroy]
  # GET /requests
  # GET /requests.json
  def index
    if params[:state] then
      if params[:state] != '' then
        @requests = Request.where(state: params[:state]).order :request_number
      else
        @requests = Request.all.order :request_number
      end
    else
      @requests = Request.all.order :request_number
    end
  end

  # GET /requests/1
  # GET /requests/1.json
  def show
  end

  # GET /requests/1/edit
  def edit
  end

  # PATCH/PUT /requests/1
  # PATCH/PUT /requests/1.json
  def update
    respond_to do |format|
      if @request.update(request_params)
        format.html { redirect_to @request, notice: 'Request was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @request.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /requests/1
  # DELETE /requests/1.json
  def destroy
    @request.destroy
    respond_to do |format|
      format.html { redirect_to requests_url }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_request
    @request = Request.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def request_params
    params.require(:request).permit(:request_number, :note, :has_data, :state)
  end
end
