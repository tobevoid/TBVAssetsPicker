# TBVAssetsPicker
    
##简介
兼容iOS7+-的相片选择器

##如何使用

```
TBVAssetsPickerController *vc = [[TBVAssetsPickerController alloc] init];
vc.delegate = self;
[self presentViewController:vc animated:YES completion:nil];

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

##依赖
- Masonry
- ReactiveCocoa