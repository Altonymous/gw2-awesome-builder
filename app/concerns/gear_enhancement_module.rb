module GearEnhancementModule
  def gear_enhancements!(gear, params_gear_enhancements)
    if params_gear_enhancements.present?
      params_gear_enhancements.each do |params_gear_enhancement|
        gear.gear_enhancements.find_or_initialize_by_id(params_gear_enhancement)
      end
    end
  end
end