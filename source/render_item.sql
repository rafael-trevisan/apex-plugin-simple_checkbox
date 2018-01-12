procedure render_simple_checkbox (
    p_item   in            apex_plugin.t_item,
    p_plugin in            apex_plugin.t_plugin,
    p_param  in            apex_plugin.t_item_render_param,
    p_result in out nocopy apex_plugin.t_item_render_result )
as
  -- Use named variables instead of the generic attribute variables
  l_checked_value    varchar2(255)  := nvl(p_item.attribute_01, 1);
  l_unchecked_value  varchar2(255)  := nvl(p_item.attribute_02, 0);
  l_checked_label    varchar2(4000) := p_item.attribute_03;

  l_name             varchar2(30);
  l_value            varchar2(255);
  l_checkbox_postfix varchar2(8);
begin
  -- if the current value doesn't match our checked and unchecked value
  -- we fallback to the unchecked value
  if p_param.value in (l_checked_value, l_unchecked_value) then
    l_value := p_param.value;
  else
    l_value := l_unchecked_value;
  end if;

  -- If a page item saves state, we have to call the get_input_name_for_page_item
  -- to render the internal hidden p_arg_names field. It will also return the
  -- HTML field name which we have to use when we render the HTML input field.
  l_name := wwv_flow_plugin.get_input_name_for_page_item(false);

  -- render the hidden field which actually stores the checkbox value
  sys.htp.prn (
    '<input type="hidden" id="' || p_item.name || '_HIDDEN" name="' || l_name || '" ' || 'value="' || l_value || '" />'
  );

  -- Add the JavaScript library and the call to initialize the widget
  apex_javascript.add_library (
    p_name      => 'simple-checkbox',
    p_directory => p_plugin.file_prefix,
    p_version   => null
  );

  apex_javascript.add_onload_code (
    p_code => 'ca_trevis_apex_simple_checkbox('||
              apex_javascript.add_value(p_item.name)||
              '{'||
              apex_javascript.add_attribute('unchecked', l_unchecked_value, false)||
              apex_javascript.add_attribute('checked',   l_checked_value, false, false)||
              '});'
  );

  -- Keep the same UT classes to be consistent with the theme
  sys.htp.prn(
    '<div class="checkbox_group apex-item-checkbox simple-checkbox">'
  );

  sys.htp.prn (
    '<input type="checkbox" id="'||p_item.name||l_checkbox_postfix||'" '||
    'value="'||l_value||'" '|| case when l_value = l_checked_value then 'checked="checked" ' end ||
    coalesce(p_item.element_attributes, '') || ' />'
  );

  sys.htp.prn(
    '<label for="' || p_item.name || l_checkbox_postfix || '">' || l_checked_label || '</label>'
  );

  sys.htp.prn(
    '</div>'
  );
end render_simple_checkbox;

procedure validate_simple_checkbox (
  p_item   in            apex_plugin.t_item,
  p_plugin in            apex_plugin.t_plugin,
  p_param  in            apex_plugin.t_item_validation_param,
  p_result in out nocopy apex_plugin.t_item_validation_result )
as
  l_checked_value   varchar2(255) := nvl(p_item.attribute_01, '1');
  l_unchecked_value varchar2(255) := nvl(p_item.attribute_02, '0');
begin
  if not (p_param.value in (l_checked_value, l_unchecked_value)
          or (p_param.value is null and l_unchecked_value is null)
         )
  then
      p_result.message := 'Checkbox contains invalid value!';
  end if;
end validate_simple_checkbox;
