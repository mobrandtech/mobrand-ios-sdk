
Pod::Spec.new do |s|
  s.name         = "MobrandCore"
  s.version      = "0.0.1"
  s.summary      = "The mobrand SDK is available as an Android Archive."
  s.description  = <<-DESC
The mobrand SDK is available as an Android Archive via our maven repository. To add the mobrand-sdk dependency, open your project's build.gradle and update the repositories and dependencies blocks as followsThe mobrand SDK is available as an Android Archive via our maven repository. To add the mobrand-sdk dependency, open your project's build.gradle and update the repositories and dependencies blocks as follows
                   DESC
  s.homepage     = "https://github.com/mobrandtech"
  s.license          = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "oJdira" => "ovidiujdira@gmail.com" }
  s.platform     = :ios, "8.0"
  s.ios.deployment_target = "8.0"
  s.source       = { :git => "https://github.com/mobrandtech/mobrand-ios-private.git", :tag => "0.0.1" }
  s.source_files  = "MobrandCore"
#s.ios.vendored_frameworks = 'Frameworks/MobrandCore.framework'
  s.requires_arc = true
end
