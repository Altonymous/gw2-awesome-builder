module ChildExtractionModule
  def hydrate_children!(parent, children, child_attribute, model)
    if children.present?
      children.each do |child|
        parent.send(child_attribute) << model.find_or_initialize_by_id(child)
      end
    end
  end

  def hydrate_child_relationship!(parent, children, child_attribute)
    if children.present?
      children.each do |child|
        parent.send(child_attribute).find_or_initialize_by_id(child)
      end
    end
  end
end