#
#  Be sure to run `pod spec lint SSTwitterLogin.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|


  s.name         = "SSTwitterLogin"
  s.version      = "2.0.2"
  s.summary      = "The reusable Twitter login components for iOS is the easiest way to get data from Twitter."

  s.description  = <<-DESC
  					The reusable Twitter login components for iOS is the easiest way to get data from Twitter. It will reduce developers time to integrate Twitter login in their app. Just add two files to your project and it's done. 
                   DESC

  s.homepage     = "https://github.com/simformsolutions/SSTwitterLogin"

  s.license      = "MIT (LICENSE)"

   s.platform     = :ios, "9.0"
   s.swift_version = '5.0'


  s.author       = { "Darshit Vadodaria" => "reg@simform.in" }

  s.source       = { :git => "https://github.com/simformsolutions/SSTwitterLogin.git", :tag => "#{s.version}" }

  s.source_files  = "SSTwitterLogin"
  
  s.dependency 'TwitterKit', '3.4.2'
  s.framework = 'TwitterKit'

end
