class Scan < ActiveRecord::Base
  serialize :data
  belongs_to :request
  def update_request_number code
    return false if !EAN8.valid? code
    self.request= Request.find_or_create_by(request_number: code)
    self.request_number= code
    if self.data then
      if !request.has_data then
        request.read_data data
      else
        request.state = 'Problem'
        request.note  = "Mehere QR-Codes gefunden"
      end
      request.save
    end
    self.save
    return true
  end

  def self.create_by_file file
    xml = IO.popen("zbarimg --xml #{file}").read

    data= nil
    request_number= nil
    note= ''

    begin
      h= Hash.from_xml(xml)["barcodes"]["source"]["index"]
      if !h.nil? then
        h= h["symbol"]
        h= [h] if !h.kind_of?(Array)
        h.each do | code |

          if code["type"] == "QR-Code" then
            puts "QR-Code gefunden"

            if data.nil? then
              data= JSON.parse(code["data"]).to_hash
            else
              data= false
              note+= "\nzuviele QR-Codes gefunden!"
            end

            puts JSON.pretty_generate(data)
          end

          if code["type"] == "EAN-8" then
            if request_number.nil? then
              request_number= code["data"]
              request_number = false if !EAN8.valid? request_number
            else
              request_number= false
              note+= "\zuviele Track-Codes gefunden!"
            end

            puts "Track-Code #{request_number} gefunden"
          end
        end
      end

      if request_number then
        request= Request.find_or_create_by(request_number: request_number)

        if !request.has_data then
        request.read_data data
        else
          request.state = 'Problem'
          request.note  = "Mehere QR-Codes gefunden"
        end
      request.save
      else
        request= nil
      end

    rescue
      note = "Parsing error!"
    end

    request_number = nil if request_number == false

    scan = self.create data: data, request_number: request_number, barcode: xml, note: note, request: request

    FileUtils.copy(file, "public/Files/"+(1000000+scan.id).to_s+'.'+file.split('.').last)
    scan.file= (1000000+scan.id).to_s+'.'+file.split('.').last
    IO.popen("convert -quality 10 -thumbnail 200 public/Files/#{scan.file} public/Files/"+(1000000+scan.id).to_s+'.png')
    scan.save
    return scan

  end
end
