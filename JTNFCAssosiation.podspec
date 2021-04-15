#
# Be sure to run `pod lib lint JTNFCAssosiation.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'JTNFCAssosiation'
  s.version          = '0.1.0'
  s.summary          = '为精特系统所匹配的nfc读卡功能'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
  仅支持DNEF数据格式的标签，读取功能最低要求iOS11，写入功能最低要求iOS13
                       DESC

  s.homepage         = 'git@github.com:OCdes/JTNFCAssociation.git'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'OCdes' => '76515226@qq.com' }
  s.source           = { :git => 'git@github.com:OCdes/JTNFCAssociation.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '10.0'

  s.source_files = 'JTNFCAssosiation/Classes/**/*'
  
  # s.resource_bundles = {
  #   'JTNFCAssosiation' => ['JTNFCAssosiation/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
