#
# Be sure to run `pod spec lint NAME.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# To learn more about the attributes see http://guides.cocoapods.org/syntax/podspec.html
#
Pod::Spec.new do |s|
  s.name             = "SlimMigration"
  s.version          = "0.1.0"
  s.summary          = "Generate migration steps for simple SQLite backed databases."
  s.description      = <<-DESC
                       SlimMigration generates SQL statements neccessary for migrating your database to an acceptable level.

                       Designed to work with simple ORMs SlimMigration takes versioning information and spits out all the statements you require to migrate your database upwards.
                       By writing SlimMigration backed classes each class can specify migration tasks such as adding table, removing tables, columns etc.
                       DESC
  s.homepage         = "https://github.com/callumj/SlimMigration"
  s.license          = 'MIT'
  s.author           = { "Callum Jones" => "contact@callumj.com" }
  s.source           = { :git => "https://github.com/callumj/SlimMigration.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/callumj'

  s.requires_arc = true

  s.source_files = 'Classes/*.{h,m}'
  s.resources = 'Assets'
end
