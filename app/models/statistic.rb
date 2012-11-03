class Statistic < ActiveRecord::Base
  attr_accessible :name, :kind, :minimum, :maximum, :interval

  validates :name,
    presence: true,
    uniqueness: true,
    length: { maximum: 36 }
  validates :kind,
    presence: true,
    length: { maximum: 12 }
  validates :minimum,
    presence: true,
    numericality: { only_integer: true, less_than: lambda { |asset| asset.maximum.blank? ? 1 : asset.maximum } }
  validates :maximum,
    presence: true,
    numericality: { only_integer: true, greater_than: lambda { |asset| asset.minimum.blank? ? 0 : asset.minimum } }
  validates :interval,
    presence: true,
    numericality: { greater_than: 0 }, if: :validate_interval

  private
  def validate_interval
    if self.interval.present? && self.maximum.present? && self.interval.nonzero?
      unless (self.maximum % self.interval).eql?(0)
        self.errors.add(:interval, "maximum must be divisible by this number")
      end
    end

    self.errors.count == 0
  end
end
