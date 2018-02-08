module PagesHelper
  def get_class(status)
    attr_class = { Page::IN_PROGRESS_STATUS.to_s => 'badge-warning',
                   Page::PENDING_STATUS.to_s => 'badge-info',
                   Page::PROCESSED_STATUS.to_s => 'badge-success',
                   Page::ERROR_STATUS.to_s => 'badge-danger' }
    attr_class[status]
  end
end
