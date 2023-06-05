Pod::Spec.new do |s|
  s.name = 'CPFListController'
  s.version = '1.2.0'
  s.summary = '通用的列表控制器'
  s.license = { :type => 'MIT', :file => 'LICENSE' }
  s.author = { 'chenpengfei' => 'afeiafeia@163.com' }
  s.source = { :git => 'https://github.com/Loadar/CPFListController.git', :tag => s.version.to_s }
  s.homepage = 'https://github.com/Loadar/CPFListController'

  #s.source_files = 'Classes/ListController/AnyListController.swift'

  s.ios.deployment_target = "9.0"
  s.swift_version = '5.0'
  s.requires_arc = true
  
  s.subspec 'Base' do |subspec|
      subspec.source_files = 'Sources/CPFListController/**/*.{h,m,swift}'
      subspec.exclude_files = 'Sources/CPFListController/Interface/AnyListController+Cpf.swift'
  end
  
  s.subspec 'Cpf' do |subspec|
      subspec.source_files = 'Sources/CPFListController/Interface/AnyListController+Cpf.swift'
      subspec.dependency 'CPFChain'
      subspec.dependency 'CPFListController/Base'
  end
  
  s.subspec 'WaterfallLayout' do |subspec|
      subspec.source_files = 'Sources/CPFListController/WaterfallLayout/WaterfallLayout+Cpf.swift'
      subspec.dependency 'CPFChain'
      subspec.dependency 'CPFListController/Base'
      subspec.dependency 'CPFWaterfallFlowLayout'
  end

end
