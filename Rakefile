desc "Run the test suite"

task :test do
  build = "xcodebuild \
    -workspace Tests/Tests.xcworkspace \
    -scheme Tests \
    -sdk iphonesimulator -destination 'name=iPhone 6'"
  system "#{build} test | xcpretty --test --color"  
end

task :default => :test

