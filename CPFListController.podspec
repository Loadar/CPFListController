Pod::Spec.new do |s|
  s.name = 'CPFListController'
  s.version = '1.0.1'
  s.summary = '通用的列表控制器'
  s.license = { :type => 'MIT', :file => 'LICENSE' }
  s.author = { 'chenpengfei' => 'afeiafeia@163.com' }
  s.source = { :git => 'https://github.com/Loadar/CPFListController.git', :tag => s.version.to_s }
  s.homepage = 'https://github.com/Loadar/CPFListController'

  s.ios.deployment_target = "9.0"
  s.source_files = 'Classes/**/*.{h,m,swift}'
  s.requires_arc = true
  s.dependency 'CPFChain'
  
  s.swift_version = '5.0'
end
