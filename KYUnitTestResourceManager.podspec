Pod::Spec.new do |spec|
  spec.name         = "KYUnitTestResourceManager"
  spec.version      = "1.1.0"
  spec.summary      = "Unit test resource manager."
  spec.description  = "Asynchronously download and cache tiny image, video, or audio files to your simulator during unit testing."
  spec.license      = "MIT"
  spec.source       = { :git => "https://github.com/Kjuly/KYUnitTestResourceManager.git", :tag => spec.version.to_s }
  spec.homepage     = "https://github.com/Kjuly/KYUnitTestResourceManager"

  spec.author             = { "Kjuly" => "dev@kjuly.com" }
  spec.social_media_url   = "https://x.com/kJulYu"

  spec.ios.deployment_target = "15.5"
  spec.osx.deployment_target = "12.0"
  spec.watchos.deployment_target = "6.0"

  spec.swift_version = '5.0'
  spec.source_files  = "KYUnitTestResourceManager"
  spec.requires_arc  = true
end
