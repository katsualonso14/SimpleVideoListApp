# Uncomment the next line to define a global platform for your project
# Deployment Target 18 
platform :ios, '18.0'

target 'SimpleVideoListApp' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for SimpleVideoListApp
  pod 'Realm'
  pod 'RealmSwift', '~> 10.42.0'

  target 'SimpleVideoListAppTests' do
    inherit! :search_paths
    # Pods for testing
  end

  post_install do |installer|
      installer.generated_projects.each do |project|
          project.targets.each do |target|
              target.build_configurations.each do |config|
                  config.build_settings['EXCLUDED_ARCHS[sdk=iphonesimulator*]'] = 'arm64'
                  config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '18.0'
              end
          end
      end
  end
end
