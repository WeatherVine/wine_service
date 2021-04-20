require "fast_jsonapi"

class WSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :api_id, :name, :area, :vintage, :eye, :nose, :mouth, :finish, :overall
end
