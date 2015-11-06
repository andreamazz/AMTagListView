desc "Run the test suite"

task :test do
  build = "xcodebuild \
    -workspace TagListViewDemo/TagListViewDemo.xcworkspace \
    -scheme TagListViewDemo \
    -sdk iphonesimulator -destination 'platform=iOS Simulator,name=iPhone 6,OS=9.1'"
  system "#{build} test | xcpretty --test --color"  
end

task :default => :test

