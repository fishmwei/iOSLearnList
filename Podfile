# Uncomment this line to define a global platform for your project
platform :ios, '8.0'
# Uncomment this line if you're using Swift
# use_frameworks!

project 'iOSLearnList'

pod 'Masonry'
pod 'MJRefresh', '3.1.0'
pod 'SDWebImage'
pod 'MBProgressHUD'
pod 'MWObjTools'
pod 'MWUITools'
pod 'MWMarqueeView'
pod 'BlocksKit'
pod 'libextobjc'
pod 'YTKKeyValueStore'
pod 'Mantle'
pod 'M13OrderedDictionary'
pod 'MLeaksFinder'

def reactDependency
    pod 'React', :path=>'./RNJS/node_modules/react-native/React.podspec', :subspecs => [
        'Core',
        'jschelpers',
        'cxxreact',
        'ART',
        'RCTActionSheet',
        'RCTAnimation',
        'RCTCameraRoll',
        'RCTGeolocation',
        'RCTImage',
        'RCTNetwork',
        'RCTPushNotification',
        'RCTSettings',
        'RCTText',
        'RCTVibration',
        'RCTWebSocket',
        'RCTLinkingIOS'
    ]
    pod 'Yoga', :path=>'./RNJS/node_modules/react-native/ReactCommon/yoga'
    
end

target 'iOSLearnList' do
    reactDependency
end

target 'iOSLearnListTests' do

    pod 'OCMock'
end





