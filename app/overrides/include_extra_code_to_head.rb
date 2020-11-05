Deface::Override.new(
  virtual_path: 'spree/shared/_head',
  name: 'include_extra_code_to_head',
  insert_after: 'link',
  text: '<%= raw Spree::Config.head_extra_codes %>',
)
