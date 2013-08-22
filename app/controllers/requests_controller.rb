class RequestsController < ApplicationController
  before_action :set_request, only: [:show, :edit, :update, :destroy, :qr]
  # GET /requests
  # GET /requests.json
  def index
    if params[:state] then
      if params[:state] != '' then
        @requests = Request.where(state: params[:state]).order :id
      else
        @requests = Request.all.order :id
      end
    else
      @requests = Request.all.order :id
    end
  end

  # GET /requests/1
  # GET /requests/1.json
  def show
  end

  def qr
    begin
      data= JSON.parse(params[:qr]).to_hash
      if @request.read_data data then
        @request.save
        render text: "OK"
      else
        render text: "Der Code wurde abgelent defekt!"
      end
    #rescue Exception => e
    #  render text: "Der Code hat ein Fehler '#{e.message}' verursacht"
    end
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
    @request_mapper = {
      vorname: "Vorname",
      name: "Nachname",
      strasse: "Strasse",
      plz: "PLZ",
      ort: "Ort",
      email: "Email",
      newsletter: "Newsletter",
      b1: "Festnetz1",
      b2: "Festnetz2",
      b3: "Handy1",
      b4: "Handy2",
      b5: "Email1",
      b6: "Email2",
      b7: "Internet1",
      b8: "Internet2",
      b9: "Voip1",
      b10: "Voip2",
      vberuf: "Vertrauensberuf",
      vname: "Vertrauensberuf Freitext",
      date: "Datum",
      version: "Version",
      complete: "Complete"
    }

  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def request_params
    params.require(:request).permit(:request_number, :note, :has_data, :state)
  end
end
