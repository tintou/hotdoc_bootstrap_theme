scss_files = files(
    'dark-frontend.scss',
    'dark-sitenav.scss',
    'light-frontend.scss',
    'light-sitenav.scss',
    'bootstrap-icons.scss',
)

scss_dep_files = files(
    'frontend.scss',
    'sitenav.scss',
    'hotdoc-variables.scss',
)

css_files = files(
  npm_files_dir / 'bootstrap-toc/dist/bootstrap-toc.min.css',
)

foreach scss: scss_files
    targets += [
      custom_target(
        command: [sass] + sass_options + ['@INPUT@', '@OUTPUT0@'],
        input: scss,
        output: '@BASENAME@.css',
        build_by_default: true,
        install: get_option('install'),
        install_dir: install_dir / 'css',
        depend_files: [
          scss_dep_files
        ],
      )
    ]
endforeach

foreach css: css_files
    configure_file(
        input: css,
        output: '@PLAINNAME@',
        copy: true,
        install: get_option('install'),
        install_dir: install_dir / 'css',
    )
endforeach
