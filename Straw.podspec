# Straw.podspec

Pod::Spec.new do |s|

  s.name = "Straw"

  s.version = "0.3.5"

  s.summary = "Straw, the simpler native-webview bridge"

  s.description = "Straw, the simpler native-webview bridge, for iOS. This is the core component of Straw Framework."

  s.homepage = "https://github.com/strawjs/straw-ios"

  s.license = {
      :type => "MIT",
      :file => "LICENSE"
  }

  s.authors = {
      "Yoshiya Hinosawa" => "stibium121@gmail.com"
  }

  s.social_media_url = "http://twitter.com/kt3k"

  s.platform = :ios, "5.0"

  s.source = {
      :git => "https://github.com/strawjs/straw-ios.git",
      :tag => "v0.3.5"
  }

  s.source_files = "Straw/*.{h,m}"

  s.public_header_files = "Straw/*.h"

  s.requires_arc = true

end
