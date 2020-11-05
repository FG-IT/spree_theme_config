Deface::Override.new(
  virtual_path: 'spree/shared/_header',
  name: 'include_top_announcement',
  insert_top: '#spree-header',
  partial: 'spree/shared/announcement.html.erb',
)
