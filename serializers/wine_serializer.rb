# DOES NOT WORK - TO BE DELETED IF SINATRA::JSON CAN MEET JSON API AND API CONTRACT
# REQUIREMENTS

require "fast_jsonapi"

class WinesSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :api_id, :name, :area, :vintage
end
