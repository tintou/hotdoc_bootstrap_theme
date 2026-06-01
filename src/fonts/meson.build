npm_font_files = files(
    npm_files_dir / 'bootstrap-icons/font/fonts/bootstrap-icons.woff',
    npm_files_dir / 'bootstrap-icons/font/fonts/bootstrap-icons.woff2',
)

foreach font: npm_font_files
    configure_file(
        input: font,
        output: '@PLAINNAME@',
        copy: true,
        install: get_option('install'),
        install_dir: install_dir / 'fonts',
    )
endforeach
