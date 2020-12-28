require 'json'

package = JSON.parse(File.read(File.join(__dir__, 'package.json')))

Pod::Spec.new do |s|
  s.name = 'CapacitorStockfish'
  s.version = package['version']
  s.summary = package['description']
  s.license = package['license']
  s.homepage = package['repository']['url']
  s.author = package['author']
  s.platform = :ios
  s.source = { :git => package['repository']['url'], :tag => s.version.to_s }
  s.ios.deployment_target  = '11.0'
  s.dependency 'Capacitor'
  s.swift_version = '5.1'
  s.xcconfig = {
    'CLANG_CXX_LANGUAGE_STANDARD' => 'gnu++17',
    'CLANG_CXX_LIBRARY' => 'libc++',
    'OTHER_CPLUSPLUSFLAGS' => '-DNNUE_EMBEDDING_OFF -DUSE_PTHREADS -mpopcnt -DUSE_POPCNT'
  }

  s.source_files = 'ios/Plugin/**/*.{swift,h,m,c,cc,mm,cpp}', 'lib/*.h'
  s.private_header_files = 'lib/*.h'
  s.header_mappings_dir = '.'

  s.subspec 'Stockfish' do |sf|
    sf.source_files = 'stockfish/src/**/*.{cpp,h}'
    sf.private_header_files = 'stockfish/src/**/*.h'
    sf.exclude_files = 'stockfish/src/main.cpp', 'stockfish/src/Makefile'
    sf.header_mappings_dir = '.'
  end

  s.subspec 'StockfishVariants' do |sfv|
    sfv.source_files = 'stockfish-variants/src/**/v-*.{cpp,h}'
    sfv.private_header_files = 'stockfish-variants/src/**/v-*.h'
    sfv.exclude_files = 'stockfish-variants/src/v-main.cpp'
    sfv.header_mappings_dir = '.'
    sfv.compiler_flags = '-DKOTH -DTHREECHECK -DATOMIC -DHORDE -DRACE -DANTI -DCRAZYHOUSE'
  end

end
