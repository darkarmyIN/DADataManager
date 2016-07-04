#
#  Be sure to run `pod spec lint DADataManager.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  s.name         = "DADataManager"
  s.version      = "0.2.2"
  s.summary      = "Lightweight storage library for iOS."

  s.description  = <<-DESC
    Singular responses and binary data persistancy alternative to NSUserDefaults.
                   DESC

  s.homepage     = "https://github.com/darkarmy64/DADataManager"
  # s.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"

  s.license      = { :type => "MIT", :file => "LICENSE" }

  s.author             = { "avikantz" => "samaritan@darkarmy.xyz" }
  s.social_media_url   = "http://twitter.com/darkarmyIN"

  s.platform     = :ios, "7.0"

  s.source       = { :git => "https://github.com/darkarmy64/DADataManager.git", :tag => "0.2.2", :branch => "master" }

  s.source_files  = "DADataManager", "DADataManager/**/*.{h,m}"
  s.exclude_files = "DADataManagerDemo/"

  s.public_header_files = "DADataManager/**/*.h"

  # s.resource  = "icon.png"
  # s.resources = "Resources/*.png"

  s.requires_arc = true

  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  # s.dependency "JSONKit", "~> 1.4"

end
