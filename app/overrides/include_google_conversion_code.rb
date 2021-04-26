Deface::Override.new(
    virtual_path: 'spree/layouts/spree_application',
    name: 'include_google_conversion_code',
    insert_bottom: 'head',
    partial: 'spree/shared/add_google_conversion_code.html.erb',
)
Deface::Override.new(
    virtual_path: 'spree/layouts/checkout',
    name: 'include_google_conversion_code',
    insert_bottom: 'head',
    partial: 'spree/shared/add_google_conversion_code.html.erb',
)


