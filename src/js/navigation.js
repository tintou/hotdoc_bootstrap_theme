function unfold_current_page(base_name, hd_context) {
	var this_panel = $('#site-navigation .panel-collapse[data-nav-ref="' + base_name + '"]');
	var this_panel_body = $('#site-navigation .sidenav-ref[data-nav-ref="' + base_name + '"]');
	var panels_to_unfold = $(this_panel).parents("#site-navigation .panel-collapse");
	panels_to_unfold.addClass("panel-body-current").parent().addClass('sidenav-panel-current');
	this_panel.addClass("panel-body-current").parent().addClass('sidenav-panel-current');

	$(this_panel_body).attr("href", hd_context.hd_basename + "#");

	panels_to_unfold.each(function() {
		this.classList.add('show');
	});
	if (this_panel[0]) {
		this_panel[0].classList.add('show');
	}

	return this_panel;
}

/* TODO reenable scrolling to current page */
function scroll_to_current_page(hd_context) {
	var this_panel = unfold_current_page(hd_context.extension + "-" + hd_context.project_name + "-" + hd_context.hd_basename, hd_context);

	if ($(this_panel).length) {
        $('html').get(0).scrollTo({top: this_panel.offset().top - hd_context.navbar_height});
	}
}

window.addEventListener('message', event => {
    if (event.data["hotdoc/sitenav-action"] == "unfold") {
      scroll_to_current_page(event.data);
    } else if (event.data["hotdoc/sitenav-action"] == "update-style") {
      setPreferredStyleSheet();
    }
});

$(document).ready(function() {
    let msg = {"hotdoc/sitenav-status": "ready"};
    window.parent.postMessage(msg, "*");
});
