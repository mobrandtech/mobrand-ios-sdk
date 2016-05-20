Pod::Spec.new do |s|
s.name         = "MobrandAppWall"
s.version      = "0.0.1"
s.summary      = "Summary description"
s.description  = <<-DESC
The mobrand SDK is available as an Android Archive via our maven repository. To add the mobrand-sdk dependency, open your project's build.gradle and update the repositories and dependencies blocks as followsThe mobrand SDK is available as an Android Archive via our maven repository. To add the mobrand-sdk dependency, open your project's build.gradle and update the repositories and dependencies blocks as follows
DESC
s.homepage         = "https://github.com/mobrandtech"
s.license          = { :type => "MIT", :file => "LICENSE" }
s.authors          = { "Mobrand Team" => "support@mobrand.com" }
s.social_media_url = 'https://www.facebook.com/olamobi/'
s.platform     = :ios, "8.1"
s.ios.deployment_target = "8.1"
s.source       = { :git => "https://github.com/mobrandtech/mobrand-ios-sdk.git", :tag => "0.0.1" }
s.source_files  = "MobrandAppWall"
s.dependency 'jdjCore' 
s.requires_arc = true
end
