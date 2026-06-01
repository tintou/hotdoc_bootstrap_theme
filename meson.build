project('hotdoc_bootstrap_theme', 'c')

fs = import('fs')

npm_files_dir = meson.current_source_dir() / 'node_modules'
if not get_option('offline')
	npm = find_program('npm', native: true)
	message('Running npm install…')
	res = run_command(
	    npm, 'install', meson.current_source_dir(),
	    check: true,
	)
endif

sass = find_program('sass', dirs: [meson.current_source_dir() / 'node_modules/.bin/'], native: true)
_sass_silence = [
  '--silence-deprecation=import',
  '--silence-deprecation=global-builtin',
  '--silence-deprecation=color-functions',
  '--silence-deprecation=if-function',
]
if get_option('sass_include_path') != ''
  sass_options = ['--load-path=' + get_option('sass_include_path'), '--no-source-map'] + _sass_silence
else
  sass_options = ['--no-source-map'] + _sass_silence
endif

targets = []

if get_option('install')
py = import('python').find_installation(pure: false)
install_dir = py.get_install_dir() / 'hotdoc/hotdoc_bootstrap_theme/dist'
else
install_dir = get_option('prefix')
endif

subdir('src')

theme_dir = meson.current_build_dir() / 'src'
theme_dep = declare_dependency(sources: targets)
