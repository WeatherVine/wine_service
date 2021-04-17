class Wine
  attr_reader   :api_id,
                :name,
                :area,
                :vintage,
                :id

  def initialize(wine)
    @id = nil
    @api_id = wine[:id]
    @name = wine[:Name]
    @area = wine[:Area]
    @vintage = wine[:vintage]
  end
end
