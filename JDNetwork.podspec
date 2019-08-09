

Pod::Spec.new do |spec|

spec.name         = "JDNetwork"
spec.version      = '2.4.2' 
spec.summary      = "JDNetwork"

spec.description  = <<-DESC
  JDNetwork
DESC

spec.homepage     = "https://github.com/JDongKhan/JDNetwork.git"

spec.license      = { :type => 'MIT', :file => 'LICENSE' }

spec.author             = { "JD" => "419591321@qq.com" }
spec.platform     = :ios, "8.0"

spec.source       = { :git => "https://github.com/JDongKhan/JDNetwork.git", :tag => spec.version.to_s }

spec.frameworks = 'Foundation'
spec.requires_arc = true

#spec.prefix_header_contents = '#import "JDNetwork.h"', '#import "JDNetwork+Cache.h"'

spec.source_files = 'Framework/**/*.{h,m}'
spec.public_header_files = 'Framework/**/*.h'

spec.dependency 'AFNetworking', '~> 3.0'

end
