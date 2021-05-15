//
//  AnyTarget.h
//  ListModelTest
//
//  Created by Aaron on 2021/5/14.
//

#import <UIKit/UIKit.h>

#ifndef AnyTarget_h
#define AnyTarget_h

@protocol AnyTarget<NSObject>
- (nonnull NSArray<NSString *> *)supportedSelectors;
@end


#endif /* AnyTarget_h */
