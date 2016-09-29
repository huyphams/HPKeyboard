Pod::Spec.new do |s|
  s.name         = "HPKeyboard"
  s.version      = "1.1.0"
  s.summary      = "Emoji keyboard =D."
  s.description  = "HPKeyboard is an emoji keyboard =D"
  s.homepage     = "https://github.com/huyphams/HPKeyboard"
  s.license      = "MIT"
  s.author       = { "Huy" => "duchuykun@gmail.com" }
  s.platform     = :ios
  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/huyphams/HPKeyboard.git", :tag => "#{s.version}" }
  s.source_files  =  "Classes/*.{h,m}"
  s.resources = "Classes/Resources/*.png"
  s.requires_arc = true
end
