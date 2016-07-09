Pod::Spec.new do |s|
  s.name     = 'SIPopover'
  s.version  = '1.1'
  s.platform = :ios
  s.license  = 'MIT'
  s.summary  = 'SIPopover'
  s.homepage = 'https://github.com/Sumi-Interactive/SIPopover'
  s.author   = { 'Sumi Interactive' => 'developer@sumi-sumi.com' }
  s.source   = { :git => 'https://github.com/Sumi-Interactive/SIPopover.git',
                 :tag => '1.1' }

  s.description = 'SIPopover'

  s.requires_arc = true
  s.framework    = 'QuartzCore'
  s.source_files = 'SIPopover/*.{h,m}'
end
