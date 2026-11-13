#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint flutter_esim_compatibility.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'flutter_esim_compatibility'
  s.version          = '1.0.0'
  s.summary          = 'A Flutter plugin to check eSIM compatibility on iOS.'
  s.description      = <<-DESC
A lightweight Flutter plugin to check if an iOS device possesses eSIM hardware capabilities using native model detection.
                       DESC
  s.homepage         = 'https://github.com/javed00700/flutter_esim_compatibility'
  s.license          = { :type => 'MIT', :file => '../LICENSE' }
  s.author           = { 'Javed' => 'javed.khan@simcorner.com' }
  s.source           = { :path => '.' }
  s.source_files     = 'flutter_esim_compatibility/Sources/flutter_esim_compatibility/**/*.swift'
  s.dependency 'Flutter'
  s.platform         = :ios, '13.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version    = '5.0'

  # Privacy manifest
  s.resource_bundles = { 'flutter_esim_compatibility_privacy' => ['flutter_esim_compatibility/Sources/flutter_esim_compatibility/PrivacyInfo.xcprivacy'] }
end
