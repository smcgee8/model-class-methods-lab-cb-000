class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    self.joins(boats: {boat_classifications: :classification}).where("classifications.name = ?", "Catamaran")
  end

  def self.sailors
    self.joins(boats: {boat_classifications: :classification}).where("classifications.name = ?", "Sailboat").uniq
  end

  def self.talented_seamen
    motorboaters = self.joins(boats: {boat_classifications: :classification}).where("classifications.name = ?", "Motorboat").uniq
    self.find_by_sql "#{motorboaters.to_sql} INTERSECT #{self.sailors.to_sql}"
  end
end
