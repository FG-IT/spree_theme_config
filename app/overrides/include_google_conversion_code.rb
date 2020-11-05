Deface::Override.new(
  virtual_path: 'spree/shared/_head',
  name: 'include_google_conversion_code',
  insert_after: 'meta',
  partial: 'spree/shared/add_google_conversion_code.html.erb',
)
