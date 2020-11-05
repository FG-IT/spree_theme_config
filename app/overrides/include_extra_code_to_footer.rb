Deface::Override.new(
  virtual_path: 'spree/shared/_footer',
  name: 'include_extra_code_to_footer',
  insert_after: 'footer',
  text: '<%= raw Spree::Config.footer_extra_codes %>',
)
