# Uncomment this line to define a global platform for your project
# platform :ios, '9.0'

target 'zaragoza bus info' do
  # Comment this line if you're not using Swift and don't want to use dynamic frameworks
  source 'https://github.com/CocoaPods/Specs.git'
  use_frameworks!

  # Pods for Zaragoza's bus info
  pod 'Alamofire', '~> 4.0'
  pod 'AlamofireObjectMapper', '~> 4.0'
  pod 'ObjectMapper', '~> 2.2'
  pod 'Kingfisher', '~> 3.0'


  post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '3.0'
        end
    end
  end
end
