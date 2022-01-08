#source 'https://github.com/CocoaPods/Specs.git'
platform :ios ,'12.4'
use_frameworks!
inhibit_all_warnings!

def codeFormat
  pod 'SwiftLint', '~> 0.43.1'
end

def network
  pod 'Alamofire', '~> 5.4.3'
  pod 'SDWebImage', '~> 5.0'
  pod 'SVGKit', :git => 'https://github.com/SVGKit/SVGKit.git', :branch => '2.x'

end


def shared_pods
  codeFormat
  network
end

target 'NewsApp' do
  shared_pods
end
