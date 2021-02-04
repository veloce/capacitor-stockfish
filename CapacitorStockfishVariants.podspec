require 'json'

package = JSON.parse(File.read(File.join(__dir__, 'package.json')))

Pod::Spec.new do |s|
  s.name = 'CapacitorStockfishVariants'
  s.version = package['version']
  s.summary = package['description']
  s.license = package['license']
  s.homepage = package['repository']['url']
  s.author = package['author']
  s.platform = :ios
  s.source = { :git => package['repository']['url'], :tag => s.version.to_s }
  s.source_files = 'ios/Plugin/**/*.{swift,h,m,c,cc,mm,cpp}', 'stockfish/src/**/*.{h,cpp}', 'lib/*.h'
  s.public_header_files = 'ios/Plugin/**/*.h'
  s.exclude_files = 'stockfish/src/main.cpp', 'stockfish/src/nnue/*', 'stockfish/src/Makefile'
  s.ios.deployment_target  = '11.0'
  s.dependency 'Capacitor'
  s.swift_version = '5.1'
  s.xcconfig = {
    'CLANG_CXX_LANGUAGE_STANDARD' => 'gnu++17',
    'CLANG_CXX_LIBRARY' => 'libc++',
    'OTHER_CPLUSPLUSFLAGS' => '-fno-exceptions -std=c++17 -DUSE_PTHREADS -DKOTH -DTHREECHECK -DATOMIC -DHORDE -DRACE -DANTI -DCRAZYHOUSE -DNDEBUG -O3 -DIS_64BIT -DUSE_POPCNT -flto=thin',
    'OTHER_LDFLAGS' => '-fno-exceptions -std=c++17 -DUSE_PTHREADS -DKOTH -DTHREECHECK -DATOMIC -DHORDE -DRACE -DANTI -DCRAZYHOUSE -DNDEBUG -O3 -DIS_64BIT -DUSE_POPCNT -flto=thin'
  }
end
