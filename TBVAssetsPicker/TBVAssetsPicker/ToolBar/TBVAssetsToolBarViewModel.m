//
//  TBVAssetsToolBarViewModel.m
//  TBVAssetsPicker
//
//  Created by tripleCC on 8/26/16.
//  Copyright © 2016 tripleCC. All rights reserved.
//
#import "TBVAssetsPickerManager.h"
#import "TBVAssetsToolBarViewModel.h"
#import "TBVAsset.h"

@interface TBVAssetsToolBarViewModel()
@property (strong, nonatomic) RACSignal *selectedStringSignal;
@property (strong, nonatomic) RACSignal *fileSizeStringSignal;
@property (strong, nonatomic) RACSignal *sendEnableSignal;
@end

@implementation TBVAssetsToolBarViewModel
- (instancetype)initWithPicker:(TBVAssetsPickerManager *)picker {
    if (self = [super init]) {
        self.selectedStringSignal =
            [RACSignal
                combineLatest:@[RACObserve(self, maxSeletedCount), RACObserve(self, seletedAssets)]
                reduce:^id(NSNumber *maxSeletedCount, NSArray *seletedAssets) {
                    return [NSString stringWithFormat:@"发送 (%@/%@)", @(seletedAssets.count), maxSeletedCount];
                }];
        
        self.fileSizeStringSignal =
            [[[[RACObserve(self, seletedAssets)
            map:^id(NSArray *value) {
                return [picker requestSizeForAssets:value];;
            }]
            switchToLatest]
            map:^id(NSNumber *value) {
                NSInteger dataLength = value.integerValue;
                if (dataLength >= 0.1 * (1024 * 1024)) {
                    return [NSString stringWithFormat:@"%0.1fM", dataLength / 1024 / 1024.0];
                } else if (dataLength >= 1024) {
                    return [NSString stringWithFormat:@"%0.0fK", dataLength / 1024.0];
                } else {
                    return [NSString stringWithFormat:@"%zdB", dataLength];
                }
            }]
            map:^id(id value) {
                return [@"文件大小:" stringByAppendingString:value];
            }];
        
        self.sendEnableSignal = [RACObserve(self, seletedAssets) map:^id(NSArray *value) {
            return @(value.count);
        }];
        
        self.didSendCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            return [RACSignal return:input];
        }];
        
    }
    return self;
}
@end
