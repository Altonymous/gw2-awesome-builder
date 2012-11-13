module OutfitsHelper
  def stat_slider(name)
    capture_haml do
      haml_tag "div", {:data => {:name => name.parameterize}, :class => "slider-range", :style => "height: 250px;"}
      haml_tag :div, {:class => "slider-amount"} do
        haml_tag :div, {:class => "label"} do
          haml_tag :div, {:class => "table"} do
            haml_tag :div, name, {:class => "table-cell"}
          end
        end
        haml_tag :div, {:id => "slider-" + name.parameterize, :class => "amount"}
      end
    end
  end
end
