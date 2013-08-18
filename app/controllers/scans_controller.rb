class ScansController < ApplicationController
  before_action :set_scan, only: [:show, :edit, :update, :destroy]
  skip_before_filter :verify_authenticity_token, only: :xerox
  # GET /scans
  # GET /scans.json
  def index
    ddep = {}
    rdep = {}
    ddep[:deleted] = false if !params[:deleted]
    rdep[:request_number] = nil if !params[:request_number]
    @scans = Scan.all.where(ddep).where(rdep)
  end

  # GET /scans/1
  # GET /scans/1.json
  def show
  end

  # GET /scans/new
  def new
    @scan = Scan.new
  end

  # GET /scans/1/edit
  def edit
  end

  # POST /scans
  # POST /scans.json
  def create
    params[:upload].each do | upload |
      file = File.join("tmp/", (0...10).map{(65+rand(26)).chr}.join+"-"+upload.original_filename)
      FileUtils.mv upload.tempfile.path, file
      Scan.create_by_file file
    end
    redirect_to scans_url
  end

  def xerox
    isLock = false
    if !params[:destName].nil? then
      isLock = true if params[:destName].include? '.LCK'
    end
    if !params[:destDir].nil? then
      isLock = true if params[:destDir].include? '.LCK'
    end

    if "PutFile" == params[:theOperation] then
      if isLock or params[:destName].include? '.XST' then
        render text: ""
      else
        file = File.join("tmp/", (0...10).map{(65+rand(26)).chr}.join+"-"+params[:destName])
        FileUtils.mv params[:sendfile].tempfile.path, file
        Scan.create_by_file file
      end
    end

    if ["DeleteFile","MakeDir","RemoveDir"].include? params[:theOperation] then
      if isLock then
        render text: ""
      else
        render text: "XRXERROR"
      end
    end
    if "GetFile" == params[:theOperation] then
      if isLock then
        render text: "XRXNOTFOUND"
      else
        render text: ""
      end
    end
    if "DeleteDirContents" == params[:theOperation] then
      render text: "XRXERROR"
    end
    if "ListDir" == params[:theOperation] then
      render text: ""
    end
  end

  # PATCH/PUT /scans/1
  # PATCH/PUT /scans/1.json
  def update
    respond_to do |format|
      if @scan.update(scan_params)
        format.html { redirect_to @scan, notice: 'Scan was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @scan.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /scans/1
  # DELETE /scans/1.json
  def destroy
    @scan.update deleted: true
    respond_to do |format|
      format.html { redirect_to scans_url }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_scan
    @scan = Scan.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def scan_params
    params.require(:scan).permit(:request_id, :file, :request_number, :data, :barcode, :note, :deleted)
  end
end
