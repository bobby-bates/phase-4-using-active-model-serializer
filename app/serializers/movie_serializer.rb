class MovieSerializer < ActiveModel::Serializer
  attributes :id, :title, :year, :length, :director, :description, :poster_url, :category, :discount, :summary

  def summary
    "#{self.object.title} - #{self.object.description[0..49]}..."
  end
end
