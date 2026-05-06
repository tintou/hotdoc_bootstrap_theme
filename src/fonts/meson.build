npm_font_files = files(
    npm_files_dir / 'bootstrap/dist/fonts/glyphicons-halflings-regular.eot',
    npm_files_dir / 'bootstrap/dist/fonts/glyphicons-halflings-regular.svg',
    npm_files_dir / 'bootstrap/dist/fonts/glyphicons-halflings-regular.ttf',
    npm_files_dir / 'bootstrap/dist/fonts/glyphicons-halflings-regular.woff',
    npm_files_dir / 'bootstrap/dist/fonts/glyphicons-halflings-regular.woff2',
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
