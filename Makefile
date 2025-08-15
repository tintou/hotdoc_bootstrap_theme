all: theme.stamp

install:

upload: theme.stamp
	tar -zcvf dist.tgz dist/ && \
	ssh meh@dhansak.collabora.co.uk "mkdir -p /home/meh/public_html/hotdoc_bootstrap_theme-0.8.2/" && \
	scp dist.tgz meh@dhansak.collabora.co.uk:/home/meh/public_html/hotdoc_bootstrap_theme-0.8.2/dist.tgz

clean:
	rm -rf dist
	rm -f theme.stamp

SRC_THEME =

LESS = node_modules/less/bin/lessc $(if $(LESS_INCLUDE_PATH),--include-path=$(LESS_INCLUDE_PATH),)

# Copy individual files

define COPY_template
$(1): $(2)
	@echo "Copying $(2) to $(1)";
	@set -e;
	@mkdir -p $(dir $(1));
	@cp $(2) $(1);
SRC_THEME += $(1)
endef

## Javascript files

SRC_JS = \
	bower_components/jquery/dist/jquery.js \
	bower_components/bootstrap/dist/js/bootstrap.js \
	bower_components/typeahead.js/dist/typeahead.jquery.min.js \
	bower_components/malihu-custom-scrollbar-plugin/jquery.mCustomScrollbar.concat.min.js \
	bower_components/mustache.js/mustache.min.js \
	bower_components/bootstrap-toc/dist/bootstrap-toc.min.js \
	bower_components/jquery-touchswipe/jquery.touchSwipe.min.js \
	bower_components/anchor-js/anchor.min.js \
	src/js/language_switching.js \
	src/js/lines_around_headings.js \
	src/js/navbar_offset_scroller.js \
	src/js/navigation.js \
	src/js/full-width.js \
	src/js/search.js \
	src/js/tag_filtering.js \
	src/js/utils.js \
	src/js/scrollspy.js \
	src/js/styleswitcher.js \
	$(NULL)

$(foreach js_file,$(SRC_JS),$(eval $(call COPY_template,dist/js/$(notdir $(js_file)),$(js_file))))

SRC_JS_SEARCH = \
	src/js/search/enable_search.css \
	$(NULL)

$(foreach js_file,$(SRC_JS_SEARCH),$(eval $(call COPY_template,dist/js/search/$(notdir $(js_file)),$(js_file))))

$(eval $(call COPY_template,dist/js/compare-versions.js,bower_components/compare-versions/index.js))

## CSS files

SRC_CSS = \
	bower_components/malihu-custom-scrollbar-plugin/jquery.mCustomScrollbar.min.css \
	bower_components/bootstrap-toc/dist/bootstrap-toc.min.css \
	$(NULL)

$(foreach css_file,$(SRC_CSS),$(eval $(call COPY_template,dist/css/$(notdir $(css_file)),$(css_file))))

SRC_THEME_META = \
	src/theme.json \
	$(NULL)

$(foreach meta_file,$(SRC_THEME_META),$(eval $(call COPY_template,dist/$(notdir $(meta_file)),$(meta_file))))

# Compile less files

define LESS_template
$(1): $(2) src/css/frontend.less src/css/sitenav.less src/css/bootstrapxl.less $(if $(LESS_INCLUDE_PATH),$(LESS_INCLUDE_PATH)/*,)
	@echo "Compiling $(2) to $(1)";
	@set -e;
	@mkdir -p dist/css;
	@$(LESS) $(2) $(1);
SRC_THEME += $(1)
endef

SRC_LESS = \
	src/css/dark-frontend.less \
	src/css/light-frontend.less \
	src/css/dark-sitenav.less \
	src/css/light-sitenav.less \
	$(NULL)


$(foreach less_file,$(SRC_LESS),$(eval $(call LESS_template,dist/css/$(notdir $(basename $(less_file))).css,$(less_file))))

# Copy whole directories

define COPY_DIR_template
$(1): $(2)/*
	@echo "Copying directory $(2) to $(1)";
	@set -e;
	@rm -rf $(1);
	@mkdir -p $(dir $(1));
	@cp -r $(2) $(1);
SRC_THEME += $(1)
endef

SRC_DIRS = \
	bower_components/bootstrap/dist/fonts \
	src/images \
	src/templates \
	$(NULL)

$(foreach src_dir,$(SRC_DIRS),$(eval $(call COPY_DIR_template,dist/$(notdir $(src_dir)),$(src_dir))))

theme.stamp: $(SRC_THEME)
	touch theme.stamp

check:
	npm test
