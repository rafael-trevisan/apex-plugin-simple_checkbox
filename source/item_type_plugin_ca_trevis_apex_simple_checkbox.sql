prompt --application/set_environment
set define off verify off feedback off
whenever sqlerror exit sql.sqlcode rollback
--------------------------------------------------------------------------------
--
-- ORACLE Application Express (APEX) export file
--
-- You should run the script connected to SQL*Plus as the Oracle user
-- APEX_050100 or as the owner (parsing schema) of the application.
--
-- NOTE: Calls to apex_application_install override the defaults below.
--
--------------------------------------------------------------------------------
begin
wwv_flow_api.import_begin (
 p_version_yyyy_mm_dd=>'2016.08.24'
,p_release=>'5.1.4.00.08'
,p_default_workspace_id=>3209043064509883755
,p_default_application_id=>9285
,p_default_owner=>'TREVIS'
);
end;
/
prompt --application/shared_components/plugins/item_type/ca_trevis_apex_simple_checkbox
begin
wwv_flow_api.create_plugin(
 p_id=>wwv_flow_api.id(42691353102801330506)
,p_plugin_type=>'ITEM TYPE'
,p_name=>'CA.TREVIS.APEX.SIMPLE_CHECKBOX'
,p_display_name=>'Simple Checkbox'
,p_supported_ui_types=>'DESKTOP'
,p_supported_component_types=>'APEX_APPLICATION_PAGE_ITEMS:APEX_APPL_PAGE_IG_COLUMNS'
,p_plsql_code=>wwv_flow_string.join(wwv_flow_t_varchar2(
'procedure render_simple_checkbox (',
'    p_item   in            apex_plugin.t_item,',
'    p_plugin in            apex_plugin.t_plugin,',
'    p_param  in            apex_plugin.t_item_render_param,',
'    p_result in out nocopy apex_plugin.t_item_render_result )',
'as',
'  -- Use named variables instead of the generic attribute variables',
'  l_checked_value    varchar2(255)  := nvl(p_item.attribute_01, 1);',
'  l_unchecked_value  varchar2(255)  := nvl(p_item.attribute_02, 0);',
'  l_checked_label    varchar2(4000) := p_item.attribute_03;',
'',
'  l_name             varchar2(30);',
'  l_value            varchar2(255);',
'  l_checkbox_postfix varchar2(8);',
'begin',
'  -- if the current value doesn''t match our checked and unchecked value',
'  -- we fallback to the unchecked value',
'  if p_param.value in (l_checked_value, l_unchecked_value) then',
'    l_value := p_param.value;',
'  else',
'    l_value := l_unchecked_value;',
'  end if;',
'',
'  -- If a page item saves state, we have to call the get_input_name_for_page_item',
'  -- to render the internal hidden p_arg_names field. It will also return the',
'  -- HTML field name which we have to use when we render the HTML input field.',
'  l_name := wwv_flow_plugin.get_input_name_for_page_item(false);',
'',
'  -- render the hidden field which actually stores the checkbox value',
'  sys.htp.prn (',
'    ''<input type="hidden" id="'' || p_item.name || ''_HIDDEN" name="'' || l_name || ''" '' || ''value="'' || l_value || ''" />''',
'  );',
'',
'  -- Add the JavaScript library and the call to initialize the widget',
'  apex_javascript.add_library (',
'    p_name      => ''simple-checkbox'',',
'    p_directory => p_plugin.file_prefix,',
'    p_version   => null',
'  );',
'',
'  apex_javascript.add_onload_code (',
'    p_code => ''ca_trevis_apex_simple_checkbox(''||',
'              apex_javascript.add_value(p_item.name)||',
'              ''{''||',
'              apex_javascript.add_attribute(''unchecked'', l_unchecked_value, false)||',
'              apex_javascript.add_attribute(''checked'',   l_checked_value, false, false)||',
'              ''});''',
'  );',
'',
'  -- Keep the same UT classes to be consistent with the theme',
'  sys.htp.prn(',
'    ''<div class="checkbox_group apex-item-checkbox">''',
'  );',
'',
'  sys.htp.prn (',
'    ''<input type="checkbox" id="''||p_item.name||l_checkbox_postfix||''" ''|| ''value="''||l_value||''" ''|| case when l_value = l_checked_value then ''checked="checked" '' end ||'' />''',
'  );',
'',
'  sys.htp.prn(',
'    ''<label for="'' || p_item.name || l_checkbox_postfix || ''">'' || l_checked_label || ''</label>''',
'  );',
'',
'  sys.htp.prn(',
'    ''</div>''',
'  );',
'end render_simple_checkbox;',
'',
'procedure validate_simple_checkbox (',
'  p_item   in            apex_plugin.t_item,',
'  p_plugin in            apex_plugin.t_plugin,',
'  p_param  in            apex_plugin.t_item_validation_param,',
'  p_result in out nocopy apex_plugin.t_item_validation_result )',
'as',
'  l_checked_value   varchar2(255) := nvl(p_item.attribute_01, ''1'');',
'  l_unchecked_value varchar2(255) := nvl(p_item.attribute_02, ''0'');',
'begin',
'  if not (p_param.value in (l_checked_value, l_unchecked_value)',
'          or (p_param.value is null and l_unchecked_value is null)',
'         )',
'  then',
'      p_result.message := ''Checkbox contains invalid value!'';',
'  end if;',
'end validate_simple_checkbox;',
''))
,p_api_version=>2
,p_render_function=>'render_simple_checkbox'
,p_validation_function=>'validate_simple_checkbox'
,p_standard_attributes=>'VISIBLE'
,p_substitute_attributes=>true
,p_subscribe_plugin_settings=>true
,p_version_identifier=>'18.1.0'
,p_about_url=>'https://github.com/rafael-trevisan/apex-plugin-simple_checkbox'
,p_files_version=>2
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(42691550245216339879)
,p_plugin_id=>wwv_flow_api.id(42691353102801330506)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>1
,p_display_sequence=>10
,p_prompt=>'Checked Value'
,p_attribute_type=>'TEXT'
,p_is_required=>true
,p_default_value=>'1'
,p_supported_ui_types=>'DESKTOP'
,p_supported_component_types=>'APEX_APPLICATION_PAGE_ITEMS:APEX_APPL_PAGE_IG_COLUMNS'
,p_is_translatable=>false
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(42691613444991341212)
,p_plugin_id=>wwv_flow_api.id(42691353102801330506)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>2
,p_display_sequence=>20
,p_prompt=>'Unchecked Value'
,p_attribute_type=>'TEXT'
,p_is_required=>true
,p_default_value=>'0'
,p_supported_ui_types=>'DESKTOP'
,p_supported_component_types=>'APEX_APPLICATION_PAGE_ITEMS:APEX_APPL_PAGE_IG_COLUMNS'
,p_is_translatable=>false
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(42691606370362120956)
,p_plugin_id=>wwv_flow_api.id(42691353102801330506)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>3
,p_display_sequence=>30
,p_prompt=>'Checkbox Label'
,p_attribute_type=>'TEXT'
,p_is_required=>false
,p_supported_ui_types=>'DESKTOP'
,p_supported_component_types=>'APEX_APPLICATION_PAGE_ITEMS:APEX_APPL_PAGE_IG_COLUMNS'
,p_is_translatable=>false
);
end;
/
begin
wwv_flow_api.g_varchar2_table := wwv_flow_api.empty_varchar2_table;
wwv_flow_api.g_varchar2_table(1) := '66756E6374696F6E2063615F7472657669735F617065785F73696D706C655F636865636B626F7828652C206329207B0A20207661722062203D20617065782E6A517565727928222322202B2065292C0A2020202061203D20617065782E6A517565727928';
wwv_flow_api.g_varchar2_table(2) := '222322202B2065202B20225F48494444454E22293B0A0A202066756E6374696F6E20642829207B0A20202020612E76616C2828622E697328223A636865636B65642229203D3D3D207472756529203F20632E636865636B6564203A20632E756E63686563';
wwv_flow_api.g_varchar2_table(3) := '6B6564290A20207D0A2020617065782E6A517565727928222322202B2065292E6368616E67652864293B0A2020617065782E6A517565727928646F63756D656E74292E62696E642822617065786265666F7265706167657375626D6974222C2064293B0A';
wwv_flow_api.g_varchar2_table(4) := '2020617065782E7769646765742E696E6974506167654974656D28652C207B0A2020202073657456616C75653A2066756E6374696F6E286629207B0A202020202020622E617474722822636865636B6564222C202866203D3D3D20632E636865636B6564';
wwv_flow_api.g_varchar2_table(5) := '29293B0A2020202020206428290A202020207D2C0A2020202067657456616C75653A2066756E6374696F6E2829207B0A20202020202072657475726E20612E76616C28290A202020207D0A20207D290A7D3B0A';
null;
end;
/
begin
wwv_flow_api.create_plugin_file(
 p_id=>wwv_flow_api.id(42691456027997110007)
,p_plugin_id=>wwv_flow_api.id(42691353102801330506)
,p_file_name=>'simple-checkbox.js'
,p_mime_type=>'text/javascript'
,p_file_charset=>'utf-8'
,p_file_content=>wwv_flow_api.varchar2_to_blob(wwv_flow_api.g_varchar2_table)
);
end;
/
begin
wwv_flow_api.import_end(p_auto_install_sup_obj => nvl(wwv_flow_application_install.get_auto_install_sup_obj, false), p_is_component_import => true);
commit;
end;
/
set verify on feedback on define on
prompt  ...done
