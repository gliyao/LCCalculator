模擬iOS內建計算機，實作簡單的加減乘除。使用 Test-driven development 方法開發。

## 思路
把計算機介面抽離，其邏輯層就為簡單的 input/output，所以非常適合用來練習TDD。
1. input: 使用者每次點擊畫面的項目，每個項目可以抽象為一個字串。
2. output: 用來顯示結果的資訊，會隨著使用者輸入改變。

## Test case
在做此練習前有幾個已知 Test case

###無限大

```
0 / 1 = "錯誤"
```

###小數點的邏輯

```
0 .....0.....1 = 0.01
```

###顯示得的邏輯

```
1 + 2 // 當還沒按下 = 時要顯示右邊的數字
```

###計算小結

```
2 // 2
+ // 2
3 // 3
+ // 5
```

###運算元切換

```
2 // 2
+ // 2
3 // 3
+ // 5
- // 5
```

## 結論
軟體開發本來就不可能一開始就把所有 Test case 考慮進去，因為需求跟功能都是永遠在變動的。 
但也不用灰心，我們可以先解決已知的問題，也就是已知的 Test case，當你的程式可以通過這些 Test case 表示你的軟體**暫時**寫完了。
而在開發的過程中會挖掘到其他 Case ，這些 Case 都可簡化為一個原因，就是**軟體運行不符合 User 預期**（new feature, bug, issue ... etc)，當這情況發生時，你只需要為每一個 Case 建立其專屬的 Test case (有些 Case 必須要在拆分成更小的 Case)，就可以一步一步趨近**寫完這個軟體**，也就是演算法裡頭教的 divide and conquer 方法。
