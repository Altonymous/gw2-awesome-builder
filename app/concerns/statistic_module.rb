module StatisticModule
  def statistic_snake_name(statistic)
    statistic.name.delete(' ').underscore.to_sym
  end
end