/*
 * Tencent is pleased to support the open source community by making
 * WCDB available.
 *
 * Copyright (C) 2017 THL A29 Limited, a Tencent company.
 * All rights reserved.
 *
 * Licensed under the BSD 3-Clause License (the "License"); you may not use
 * this file except in compliance with the License. You may obtain a copy of
 * the License at
 *
 *       https://opensource.org/licenses/BSD-3-Clause
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#import "CRUDTestCase.h"

@implementation CRUDTestCase

- (void)setUp
{
    [super setUp];

    _database = [[WCTDatabase alloc] initWithPath:self.recommendedPath];

    _tableName = self.class.className;

    _cls = TestCaseObject.class;

    int count = 5;

    int max = count - 1;

    //0, 1, 2, 3, 4
    _preInserted = [TestCaseObject objectsWithCount:count];

    XCTAssertTrue([_database createTableAndIndexes:_tableName withClass:_cls]);

    XCTAssertTrue([_database insertObjects:_preInserted intoTable:_tableName]);

    _greaterThan0Condition = TestCaseObject.variable1 > 0;

    _removeBothEndCondition = TestCaseObject.variable1 > 0 && TestCaseObject.variable1 < max;

    _ascendingOrder = TestCaseObject.variable1.asOrder(WCTOrderedAscending);

    _descendingOrder = TestCaseObject.variable1.asOrder(WCTOrderedDescending);

    _limit1 = 1;

    _offset1 = 1;
}

- (void)tearDown
{
    XCTAssertTrue([_database dropTable:_tableName]);

    [_database close:^{
      XCTAssertTrue([_database removeFiles]);
    }];

    _database = nil;

    _cls = nil;

    _tableName = nil;

    [super tearDown];
}

@end