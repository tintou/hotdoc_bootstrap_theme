$(document).ready(function() {
	setupFilters();

	(function() {
		var el = document.getElementById('main');
		if (!el) return;
		var startX, startY;
		var THRESHOLD = 75;
		var EXCLUDED = 'button, input, select, textarea, a, .noSwipe, pre';
		function reset() { startX = startY = undefined; }
		el.addEventListener('pointerdown', function(e) {
			if (e.pointerType !== 'touch') return;
			if (e.target.closest(EXCLUDED)) return;
			startX = e.clientX;
			startY = e.clientY;
		}, { passive: true });
		el.addEventListener('pointercancel', reset, { passive: true });
		el.addEventListener('pointerup', function(e) {
			if (e.pointerType !== 'touch' || startX === undefined) return;
			var dx = e.clientX - startX;
			var dy = e.clientY - startY;
			reset();
			if (Math.abs(dy) > Math.abs(dx) || Math.abs(dx) < THRESHOLD) return;
			if (dx > 0) {
				if ($('body').hasClass('toc-expanded'))
					$('body').removeClass('toc-expanded');
				else
					$('body').addClass('sitenav-expanded');
			} else {
				if ($('body').hasClass('sitenav-expanded'))
					$('body').removeClass('sitenav-expanded');
				else
					$('body').addClass('toc-expanded');
			}
		}, { passive: true });
	})();

	$("#body").click(function(e) {
		$("body").removeClass("toc-expanded");
		$("body").removeClass("sitenav-expanded");
	});

	$("#sidenav-toggle").click(function(e) {
		$("body").removeClass("toc-expanded");
		$("body").toggleClass("sitenav-expanded");
	});

	$("#toc-toggle").click(function(e) {
		$("body").removeClass("sitenav-expanded");
		$("body").toggleClass("toc-expanded");
	});

    /* Communicate context to our navigation iframe.
     *
     * As it may get loaded before or after us, we communicate
     * it too upon reception of a sitenav-status ready message.
     */
    const frame = document.getElementById('sitenav-frame');
    let msg = {"hotdoc/sitenav-action": "unfold"}
    Object.assign(msg, utils.hd_context);
    frame.contentWindow.postMessage(msg, '*');

    $(window).on("message", function(e) {
        console.log("main window got message", e.originalEvent.data);

        let msg = e.originalEvent.data;

        if (msg["hotdoc/sitenav-status"] == "ready") {
            let msg = {"hotdoc/sitenav-action": "unfold"}
            Object.assign(msg, utils.hd_context);
            frame.contentWindow.postMessage(msg, '*');
        }
    });
});
