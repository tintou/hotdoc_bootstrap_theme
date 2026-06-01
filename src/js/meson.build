js_files = files(
    'full-width.js',
    'language_switching.js',
    'lines_around_headings.js',
    'navbar_offset_scroller.js',
    'navigation.js',
    'search.js',
    'styleswitcher.js',
    'tag_filtering.js',
    'utils.js',
)

npm_js_files = files(
    npm_files_dir / 'anchor-js/anchor.min.js',
    npm_files_dir / 'bootstrap/dist/js/bootstrap.bundle.js',
    npm_files_dir / 'bootstrap-toc/dist/bootstrap-toc.min.js',
    npm_files_dir / 'jquery/dist/jquery.js',
    npm_files_dir / 'mustache/mustache.min.js',
    npm_files_dir / 'typeahead.js/dist/typeahead.jquery.min.js',
)

foreach js: js_files
    configure_file(
        input: js,
        output: '@PLAINNAME@',
        copy: true,
        install: get_option('install'),
        install_dir: install_dir / 'js',
    )
endforeach

foreach js: npm_js_files
    configure_file(
        input: js,
        output: '@PLAINNAME@',
        copy: true,
        install: get_option('install'),
        install_dir: install_dir / 'js',
    )
endforeach

configure_file(
    input: npm_files_dir / 'compare-versions/index.js',
    output: 'compare-versions.js',
    copy: true,
    install: get_option('install'),
    install_dir: install_dir / 'js',
)

subdir('search')
