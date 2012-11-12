class Statistic < ActiveRecord::Base
  resourcify
  attr_accessible :name, :kind, :minimum, :maximum, :interval

  has_many :enhancements

  validates :name,
    presence: true,
    uniqueness: true,
    length: { maximum: 36 }
  validates :kind,
    presence: true,
    length: { maximum: 12 }
  validates :minimum,
    presence: true,
    numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :minimum,
    numericality: { less_than: lambda { |asset| asset.maximum } }, if: "self.maximum.present? && self.maximum.nonzero?"
  validates :maximum,
    presence: true,
    numericality: { only_integer: true, greater_than_or_equal_to: 1 }
  validates :maximum,
    numericality: { greater_than: lambda { |asset| asset.minimum } }, if: "self.minimum.present? && self.minimum.nonzero?"
  validates :interval,
    presence: true,
    numericality: { only_integer: true, greater_than: 0 }, if: :validate_interval

  private
  def validate_interval
    if self.interval.present? && self.interval.nonzero? && self.maximum.present?
      unless (self.maximum % self.interval).eql?(0)
        self.errors.add(:interval, "maximum must be divisible by this number")
      end
    end

    self.errors.count == 0
  end
end
