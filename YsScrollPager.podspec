
Pod::Spec.new do |s|
  s.name         = "YsScrollPager"
  s.version      = "0.0.1"
  s.summary      = "A news slider framework."
  s.homepage     = "https://github.com/YunsChou/YsScrollSlideView"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "YunsChou" => "2647754496@qq.com" }
  s.source       = { :git => "https://github.com/YunsChou/YsScrollSlideView/YsScrollPager.git", :tag => "#{s.version}" }
  s.source_files = "YsScrollPager/*"
  s.requires_arc = true
end
