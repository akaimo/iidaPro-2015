//
//  RandomNumber.m
//  iidaPro-2015
//
//  Created by akaimo on 12/13/15.
//  Copyright © 2015 akaimo. All rights reserved.
//

#import "RandomNumber.h"

@interface RandomNumber ()

@property NSMutableArray *array;

@end

@implementation RandomNumber

-(void)createRandomNumberArray {
    _array = [NSMutableArray array];
    //配列に発生させたい範囲の乱数を格納する。今回は51から100。
    for (int i = 51; i < 101; i++){
        [_array addObject:[NSString stringWithFormat:@"%d",i]];
    }
}

-(int)getRandomNumber {
    int num = 0;
    if (_array.count != 0){
        //乱数を生成
        int n = arc4random() % _array.count;
        //乱数の数値にしたがって配列から文字列を取り出す
        num = (int)_array[n];
        //取り出した文字列を削除
        [_array removeObjectAtIndex:n];
    }else{
        NSLog(@"重複のない乱数はありません。");
    }
    
    return num;
}

@end
