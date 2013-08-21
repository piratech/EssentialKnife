class Request < ActiveRecord::Base
  has_many :scan
  def read_data d
    self.name     = d["l"]
    self.vorname  = d["f"]
    self.strasse  = d["s"]
    self.plz      = d["p"]
    self.ort      = d["c"]
    self.email    = d["e"]
    self.newsletter= d["bb"]
    self.b1       = d["b1"]
    self.b2       = d["b2"]
    self.b3       = d["b3"]
    self.b4       = d["b4"]
    self.b5       = d["b5"]
    self.b6       = d["b6"]
    self.b7       = d["b7"]
    self.b8       = d["b8"]
    self.b9       = d["b9"]
    self.b10      = d["b10"]
    self.vberuf   = d["v"]
    self.vname    = d["b"]
    self.date     = d["date"]
    self.version  = d["fv"]
    self.complete = d["complete"]

    self.has_data = true
  end

end
