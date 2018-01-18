function ca_trevis_apex_simple_checkbox(e, c) {
  var b = apex.jQuery("#" + e);
  var a = apex.jQuery("#" + e + "_HIDDEN");

  function d() {
    a.val((b.is(":checked") === true) ? c.checked : c.unchecked)
  }

  apex.jQuery("#" + e).change(d);
  apex.jQuery(document).bind("apexbeforepagesubmit", d);

  apex.widget.initPageItem(e, {
    setValue: function(f) {
      b.attr("checked", (f === c.checked));
      d();
    },
    getValue: function() {
      return a.val()
    }
  });
};
