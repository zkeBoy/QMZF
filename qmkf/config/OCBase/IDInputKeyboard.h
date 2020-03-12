//
//  IDInputKeyboard.h
//  Notarization
//
//  Created by mac on 2019/9/5.
//  Copyright © 2019 Hui Wang. All rights reserved.
//

#import "BaseView.h" 

@protocol IDInputKeyboardDelegate;

@interface IDInputKeyboard : BaseView

@property (nonatomic, weak) id<IDInputKeyboardDelegate> delegate;

@end
//代理
@protocol IDInputKeyboardDelegate <NSObject>
@optional
//点击0~9和X时调用
- (void)didKeyboardItemSelected:(NSString *)item;
//点击删除时调用
- (void)didKeyboardDeletedClicked;

@end
