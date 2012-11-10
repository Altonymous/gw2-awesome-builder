module SortModule
  extend ActiveSupport::Concern

  included do
    append_before_filter :parse_sort_param

    def parse_sort_param
      @sort = params[:sort].gsub('.', ' ') unless params[:sort].blank?
    end
  end
end
