class W
  attr_reader :id,
              :api_id,
              :name,
              :area,
              :vintage,
              :eye,
              :nose,
              :mouth,
              :finish,
              :overall

  def initialize(wine)
    @id = nil
    @api_id = wine[:aggregate][:wine][:id]
    @name = wine[:aggregate][:wine][:Name]
    @area = wine[:aggregate][:wine][:Area]
    @vintage = wine[:aggregate][:wine][:vintage]
    @eye = wine[:agg_summary][:textReviews][:eye]
    @nose = wine[:agg_summary][:textReviews][:nose]
    @mouth = wine[:agg_summary][:textReviews][:mouth]
    @finish = wine[:agg_summary][:textReviews][:finish]
    @overall = wine[:agg_summary][:textReviews][:overall]
  end
end
