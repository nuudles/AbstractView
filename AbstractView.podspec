Pod::Spec.new do |s|
  s.name = 'AbstractView'
  s.version = '0.0.2'
  s.license = 'MIT'
  s.summary = 'The AbstractView is a simple view that can be used as a simple background view using abstract shapes and a visual effect'
  s.homepage = 'https://github.com/nuudles/AbstractView'
  s.authors = { 'Christopher Luu' => 'nuudles@gmail.com' }
  s.source = { :git => 'https://github.com/nuudles/AbstractView.git', :tag => s.version }

  s.ios.deployment_target = '8.0'
  s.tvos.deployment_target = '9.0'

  s.source_files = 'AbstractView/*.swift', 'AbstractView/Shapes/*.swift'

  s.requires_arc = true
end
