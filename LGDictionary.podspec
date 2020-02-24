
Pod::Spec.new do |s|

  s.name         = "LGDictionary"
  s.version      = "1.0.9"
  s.summary      = "知识点课件"

  s.homepage     = "https://github.com/LYajun/LGDictionary"
 

  s.license      = "MIT"

  s.author             = { "刘亚军" => "liuyajun1999@icloud.com" }


  s.platform     = :ios, "8.0"
  s.ios.deployment_target = '8.0'


  s.source  = { 
                :git => "https://github.com/LYajun/LGDictionary.git",
                :tag => s.version
  }

  s.source_files  = "LGDictionary/Category/*.{h,m}", "LGDictionary/Common/*.{h,m}", "LGDictionary/Utils/**/*.{h,m}", "LGDictionary/Module/**/*.{h,m}"
 

 
  s.resources = "LGDictionary/LGDictionary.bundle"

  s.requires_arc = true

  s.dependency 'Masonry'
  s.dependency 'MJExtension'
  s.dependency 'BlocksKit'
  s.dependency 'XMLDictionary'
  s.dependency 'YJActivityIndicatorView'
end
