# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

def commonPods
    inherit! :search_paths # Required for not double-linking libraries in the app and test targets.+
    pod 'RxSwift'
    pod 'RxCocoa'
    pod 'SwiftLint', '~> 0.33.0'
end

def hciPods
    inherit! :search_paths # Required for not double-linking libraries in the app and test targets.+
    pod 'HandyJSON', '~> 5.0'
    pod 'Moya/RxSwift', '~> 13.0'
    pod 'ReachabilitySwift', '~> 4.0'
    pod 'RxOptional', '~> 3.0'
    pod 'SnapKit', '~> 4.0'
    pod 'SDWebImage'
    pod 'Toast-Swift'
end

def hciTestPods
    inherit! :search_paths # Required for not double-linking libraries in the app and test targets.+
    pod 'Quick'
    pod 'Nimble'
end

target 'HCI' do
  use_frameworks!

  inhibit_all_warnings!

  # Pods for HCI
    commonPods
    hciPods
end

target 'HCIUnitTests' do
   use_frameworks!

   inhibit_all_warnings!

  # Pods for HCIUnitTests
    commonPods
    hciTestPods
end
