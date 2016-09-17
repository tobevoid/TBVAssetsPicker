# TBVAssetsPicker
    
##简介
兼容iOS7+-的相片选择器

##如何使用
- 创建相册资源reformer，展示相册选择器

```objc
TBVAssetsPickerController *viewController = [[TBVAssetsPickerController alloc] initWithPickManager:self.reformer.pickManager];
viewController.delegate = self;
[self presentViewController:viewController animated:YES completion:nil];

```

- 实现代理TBVAssetsPickerControllerDelegate

```objc
/* 超过限制 */
- (void)assetsPickerController:(TBVAssetsPickerController *)picker overMaxSelectedCount:(NSInteger)selectedCount {
    NSString *title = [NSString stringWithFormat:@"最多只能选择%@张", @(selectedCount)];
    UIAlertView *alertView = [[UIAlertView alloc]
                              initWithTitle:title
                              message:nil
                              delegate:nil
                              cancelButtonTitle:nil
                              otherButtonTitles:@"确定", nil];
    [alertView show];
}

/* 获取选中资源 */
- (void)assetsPickerController:(TBVAssetsPickerController *)picker didFinishPickingAssets:(NSArray<TBVAsset *> *)assets {
    
}
```

- 在选中资源时可依次获取图片，进行后续处理，如发送至服务器/qiniu


```objc
- (void)sendAssets:(NSArray <TBVAsset *> *)assets {
    RACSignal *concatedSignal = [[assets.rac_sequence
        map:^id(TBVAsset *asset) {
            return [[[[self.reformer imageWithAsset:asset mode:TBVAssetsReformerModeLarge]
                filter:^BOOL(RACTuple *value) {
                    return [value.second integerValue] == 0;
                }]
                reduceEach:^id (UIImage *image, NSNumber *degraded){
                    /* signal which sends image to server */
                    return [[RACSignal return:image] delay:1.0];
                }]
                switchToLatest];
        }]
        foldLeftWithStart:nil reduce:^id(RACSignal *accumulator, RACSignal *value) {
            return accumulator ? [accumulator concat:value] : value;
        }];
    
    [concatedSignal subscribeNext:^(id value) {
        TBVLogDebug(@"%@", value);
    }];
}
```


##依赖
- Masonry
- ReactiveCocoa