module StatisticModule
  def statistic_snake_name(statistic)
    statistic.name.delete(' ').underscore.to_sym
  end

  # Statistic.all.each do |statistic|
  #   define_method(statistic.name.delete(' ').underscore) do
  #     # Find the enhancement(s) that matches the statistics
  #     # This gives us our multiplier
  #     enhancements = Enhancement.find_all_by_statistic_id(statistic.id)

  #     # Find the gear enhancement that matches the enhancement id
  #     # this gives us our rating
  #     value = 0
  #     enhancements.each do |enhancement|
  #       if pieces.blank?
  #         gear_enhancement = self.gear_enhancements.find_by_enhancement_id(enhancement.id)

  #         unless gear_enhancement.blank?
  #           value = value + (gear_enhancement.rating * enhancement.multiplier)
  #         end
  #       else
  #         pieces.each do |piece|
  #           gear_enhancement = self.send(piece).gear_enhancements.find_by_enhancement_id(enhancement.id)

  #           unless gear_enhancement.blank?
  #             value = value + (gear_enhancement.rating * enhancement.multiplier)
  #           end
  #         end
  #       end
  #     end

  #     value
  #   end
  # end

  # def pieces
  #   raise NotImplemented
  # end
end