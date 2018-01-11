class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    self.joins(boats: {boat_classifications: :classification}).where("classifications.name = ?", "Catamaran")
  end

  def self.sailors
    self.joins(boats: {boat_classifications: :classification}).where("classifications.name = ?", "Sailboat").uniq
  end

  def self.talented_seamen
    self.sailors.scoping do
      self.joins(boats: {boat_classifications: :classification}).where("classifications.name = ?", "Motorboat").uniq
    end
  end
end
