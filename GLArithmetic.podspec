#
# Be sure to run `pod lib lint GLArithmetic.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'GLArithmetic'
  s.version          = '0.2.2'
  s.summary          = 'GLArithmetic.'

  s.description      = <<-DESC
GLArithmetic Caculate
                       DESC

  s.homepage         = 'https://gitee.com/guoleiCoder'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'guolei' =>'guolei_coder@126.com' } 
  s.source           = { :git => 'https://gitee.com/guoleiCoder/Arithmetic.git', :tag => s.version.to_s }

  s.ios.deployment_target = '7.0'

  s.source_files = 'GLArithmetic/Classes/**/*'
  

end
