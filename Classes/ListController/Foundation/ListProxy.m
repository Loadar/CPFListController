//
//  ListProxy.m
//  ListController
//
//  Created by Aaron on 2021/5/12.
//

#import "ListProxy.h"
#import "AnyTarget.h"

@interface ListProxy()
@property (nonatomic, copy) NSArray<id> *targets;
@end

@implementation ListProxy

- (instancetype)initWithTargets:(NSArray<id> *)targets {
    self.targets = targets;
    return self;
}

- (id)targetForSelector:(SEL)aSelector {
    if (aSelector == @selector(respondsToSelector:) || aSelector == @selector(conformsToProtocol:)) {
        return self;
    }
    
    id targets = self.targets;
    
    for (id<AnyTarget> aTarget in targets) {
        if ([aTarget respondsToSelector:@selector(supportedSelectors)]) {
            NSArray<NSString *> *selectors = [aTarget supportedSelectors];
            if ([selectors containsObject:NSStringFromSelector(aSelector)]) {
                return aTarget;
            }
        }
    }
    
    return nil;
}

- (BOOL)respondsToSelector:(SEL)aSelector {
    for (id<AnyTarget> aTarget in self.targets) {
        if ([aTarget respondsToSelector:@selector(supportedSelectors)]) {
            NSArray<NSString *> *selectors = [aTarget supportedSelectors];
            if ([selectors containsObject:NSStringFromSelector(aSelector)]) {
                return true;
            }
        }
    }
    return false;
}

- (BOOL)conformsToProtocol:(Protocol *)aProtocol {
    if (aProtocol == @protocol(UICollectionViewDataSource)
        || aProtocol == @protocol(UICollectionViewDelegateFlowLayout)
        || aProtocol == @protocol(UICollectionViewDelegate)
        || aProtocol == @protocol(UIScrollViewDelegate)
        || aProtocol == @protocol(UITableViewDataSource)
        || aProtocol == @protocol(UITableViewDelegate)) {
        return true;
    }
    return  false;
}


- (void)forwardInvocation:(NSInvocation *)invocation {
    id target = [self targetForSelector: invocation.selector];
    if (target != nil) {
        [invocation setTarget:target];
        [invocation invoke];
    }
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel {
    id target = [self targetForSelector:sel];
    if (target != nil) {
        return [target methodSignatureForSelector: sel];
    }
    return nil;
}

@end


