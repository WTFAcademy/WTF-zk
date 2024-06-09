# 控制流

我们有标准的构造来定义程序的控制流。

## 条件语句: if-then-else

**if ( boolean_condition ) block_of_code else block_of_code**

else 部分是可选的。如果省略，则意味着“else 不做任何事情”。

```plaintext
var x = 0;
var y = 1;
if (x >= 0) {
   x = y + 1;
   y += 1;
} else {
   y = x;
}
```

## 循环语句: for

**for ( initialization_code ; boolean_condition ; step_code ) block_of_code**

如果 initialization_code 包含 var 声明，则其作用域仅限于 for 语句，因此稍后使用它（不重新定义）会产生编译错误。

```plaintext
var y = 0;
for(var i = 0; i < 100; i++){
    y++;
}
```

## 循环语句: while

**while ( boolean_condition ) block_of_code**

当条件成立时执行代码块。每次执行代码块之前都会检查条件。

```plaintext
var y = 0;
var i = 0;
while(i < 100){
    i++;
    y += y;
}
```

**重要**：当在 if-then-else 或循环语句中的任何块中生成约束时，条件不能是未知的（请参见 [Unknowns](../circom-insight/unknowns)）。这是因为约束生成必须是唯一的，不能依赖于未知的输入信号。

如果条件中的表达式未知并且生成了一些约束，编译器将生成以下错误消息：“_There are constraints depending on the value of the condition and it can be unknown during the constraint generation phase_”。

```plaintext
pragma circom 2.0.0;

template A(){}
template wrong(N1){
    signal input in;
    component c;
    if(in > N1){
      c = A();
    }
}
component main {public [in]} = wrong(1);
```

在此示例中，条件取决于编译时未知值的输入信号 `in`。

还需要注意的是，如果语句体不涉及任何信号或组件，或者约束不依赖于涉及未知值的值，则编译将成功，如下例所示。

```plaintext
template right(N){
    signal input in;
    var x = 2;
    var t = 5;
    if(in > N){
      t = 2;
    }
}
```

此模板是正确的，因为没有约束依赖于 `in` 的未知值。

```plaintext
template right(N1,N2){
    signal input in;
    var x = 2;
    var t = 5;
    if(N1 > N2){
      t = 2;
    }
    x === t;
}
```

此模板是正确的，因为约束中涉及的变量值仅依赖于参数 `N1` 和 `N2` 的已知值。

**重要**：当 var 的内容取决于某些未知条件时会产生另一个编译错误：即当 var 在具有未知条件的 if-then-else 或循环语句中取值时。然后，变量的内容是非二次表达式，因此不能用于生成约束。

```plaintext
template wrong(){
    signal input in;
    var x; 
    var t = 5;
    if(in > 3){
      t = 2;
    }
    x === t;
}
```

此模板产生编译错误，因为最后一个约束中涉及的变量 `t` 的值取决于变量 `in` 的未知值。

计算的控制流类似于其他命令式语言，但[组件的实例化](../templates-and-components)可能不遵循代码的顺序结构，因为组件实例化不会被触发，直到所有输入信号都分配了具体值。

```plaintext
template mult(){
  signal input in[2];
  signal output out;
  out <== in[0] * in[1];
}

template mult4(){
  signal input in[4];
  component comp1 = mult();
  component comp2 = mult();
  comp1.in[0] = in[0];
  comp2.in[0] = in[1];
  comp2.in[1] = in[2];
  comp1.in[1] = in[3];
}
```

在这个例子中，`comp2` 在 `comp1` 之前实例化，因为 `comp2` 的输入信号在 `comp1` 的输入信号之前有具体值。因此，`comp2.out` 在执行第 13 行后获得值，而 `comp1.out` 在执行第 14 行后获得值。