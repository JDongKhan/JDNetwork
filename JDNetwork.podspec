

Pod::Spec.new do |s|

s.name         = "JDNetwork"
s.version      = '2.4.0' 
s.summary      = "JDNetwork"

s.description  = <<-DESC
JDRouter
DESC

s.homepage     = "https://github.com/JDongKhan/JDNetwork.git"

s.license      = { :type => 'MIT', :file => 'LICENSE' }

s.author             = { "wangjindong" => "419591321@qq.com" }
s.platform     = :ios, "8.0"

s.source       = { :git => "https://github.com/JDongKhan/JDNetwork.git", :tag => s.version.to_s }


s.frameworks = 'Foundation'
s.requires_arc = true


s.source_files = 'Framework/*.{h,m}'
s.public_header_files = 'Framework/*.h'
s.dependency 'AFNetworking'


end
