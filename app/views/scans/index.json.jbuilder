json.array!(@scans) do |scan|
  json.extract! scan, :request_id, :file, :request_number, :data, :barcode, :note, :deleted
  json.url scan_url(scan, format: :json)
end
