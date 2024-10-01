module PaginationHelpers
  include Pagy::Backend

  def paginate(collection)
    page = params[:page].to_i <= 0 ? 1 : params[:page].to_i
    per_page = params[:per_page].to_i <= 0 ? 8 : params[:per_page].to_i
    pagy, records = pagy(collection, items: per_page, page:)
    header 'Current-Page', pagy.page.to_s
    header 'Total-Pages', pagy.pages.to_s
    header 'Per-Page', pagy.items.to_s
    header 'Total-Count', pagy.count.to_s

    records
  end
end
