Pod::Spec.new do |s|
  s.name = 'TBVAssetsPicker'
  s.version = '0.1.0'
  s.summary = 'Assets picker for ios7 and ios7+.'
  s.homepage = 'https://github.com/tobevoid/TBVAssetsPicker'
  s.documentation_url = 'https://github.com/tobevoid/TBVAssetsPicker'
  s.description = 'A data-driven UICollectionView framework for building fast and flexible lists.'

  s.license =  { :type => 'MIT' }
  s.authors = 'tripleCC'
  s.source = {
    :git => 'https://github.com/tobevoid/TBVAssetsPicker.git',
    :tag => s.version.to_s,
  }

  s.requires_arc = true

  
end
