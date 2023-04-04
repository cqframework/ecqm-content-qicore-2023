library TestCartesian

define TestA: { { x: 1, y: 1 }, { x: 2, y: 2 } }

define TestB: { { x: 1, y: 1 }, { x: 2, y: 2 } }

define TestC: TestA A where false

define TestEmptyCartesian: from TestA A, TestB B, TestC C return A

define TestCartesian: from TestA A, TestB B return { A: A, B: B }
