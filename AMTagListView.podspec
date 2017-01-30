Pod::Spec.new do |s|
  s.name         = "AMTagListView"
  s.version      = "1.5.0"
  s.summary      = "UIScrollView subclass that allows to add a list of highly customizable tags."
  s.homepage     = "https://github.com/andreamazz/AMTagListView"
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = { "Andrea Mazzini" => "andrea.mazzini@gmail.com" }
  s.source       = { :git => "https://github.com/andreamazz/AMTagListView.git", :tag => s.version }
  s.platform     = :ios, '5.0'
  s.source_files = 'Source', '*.{h,m}'
  s.requires_arc = true
end
