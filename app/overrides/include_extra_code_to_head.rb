Deface::Override.new(
    virtual_path: 'spree/layouts/spree_application',
    name: 'include_extra_code_to_head',
    insert_bottom: 'head',
    text: '<%= raw Spree::Config.head_extra_codes %>',
)

Deface::Override.new(
    virtual_path: 'spree/layouts/checkout',
    name: 'include_extra_code_to_head',
    insert_bottom: 'head',
    text: '<%= raw Spree::Config.head_extra_codes %>',
)
