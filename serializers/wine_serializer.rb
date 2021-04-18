require "fast_jsonapi"

class WinesSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :api_id, :name, :area, :vintage
end
