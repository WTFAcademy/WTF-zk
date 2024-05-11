# 信号 & 变量

算术电路使用circom构建,运行于信号之上,其中信号包含域$Z/pZ$中的field元素。信号可以用标识符命名,也可以存储在数组中,并使用关键字signal声明。信号可以被定义为输入或输出,否则被视为中间信号。

```text
signal input in;
signal output out[N];
signal inter;
```

这个例子声明了一个标识符为`in`的输入信号、一个N维的标识符为`out`的输出信号数组,以及一个标识符为`inter`的中间信号。

## 信号赋值类型
信号只能使用`<--`或`<==`操作(信号在赋值操作的左侧)以及`-->`或`==>` 操作(信号在赋值操作的右侧)进行赋值。所有这些操作在编译器生成的witness generation代码中都被转化为赋值语句。然而,双箭头赋值`<==`和`==>` 与单箭头赋值`<--`和`-->`的关键区别是,只有前者会在R1CS系统中添加约束,表示信号等于被赋的表达式。因此,对于非专家circom程序员而言,使用`<--`和`-->`被视为危险,并极力不鼓励,因为这是使用circom编程时最常见的导致ZK协议存在缺陷的原因。

安全的赋值选择是`<==`和`==>`,因为被赋的值是约束系统的唯一解。应当避免使用`<--`和`-->`,只有在被赋的表达式不能包含在R1CS的算术约束中时才使用,如下例所示:

```text
out[k] <-- (in >> k) & 1;
```
在这种情况下,由于`<--`和`-->`没有在R1CS系统中添加任何关于信号与被赋表达式之间关系的约束,因此关键是添加其他约束来表达这种关系。为此,circom允许使用`===`操作向系统添加约束,其使用方法在[这里](5_Constraint_Generation.md)有更详细的解释。

## 公共和私有信号
信号通常被视为私有的。程序员只有在定义主组件时,通过提供公共输入信号列表,才能区分公共和私有信号。

```text 
pragma circom 2.0.0;

template Multiplier2(){
   //声明信号
   signal input in1;
   signal input in2;
   signal output out;
   out <== in1 * in2;
}

component main {public [in1,in2]} = Multiplier2();
```
从circom 2.0.4开始,还允许在声明中间和输出信号后立即对其进行初始化。那么上面的例子可以重写如下:

```text
pragma circom 2.0.0;

template Multiplier2(){
   //声明信号
   signal input in1;
   signal input in2;
   signal output out <== in1 * in2;
}

component main {public [in1,in2]} = Multiplier2();
```

这个例子声明了主组件的输入信号`in1`和`in2`为公共信号。

在circom中,主组件的所有输出信号都是公共的(且不能被设为私有),主组件的输入信号如果没有使用public关键字说明就是私有的。其余的信号都是私有的,且无法设为公共。

因此,从程序员的角度来看,只有公共的输入和输出信号是从电路外部可见的,所以任何中间信号都无法被访问。

```text
pragma circom 2.0.0;

template A(){
   signal input in;
   signal outA; //我们没有将它声明为输出
   outA <== in;
}

template B(){
   //声明信号
   signal output out;
   component comp = A();
   out <== comp.outA;
}

component main = B();
```

这段代码会产生编译错误,因为信号`outA`没有被声明为输出信号,所以就无法被访问和赋值给`out`。

信号是不可变的,这意味着一旦它被赋予一个值,这个值就不能再被改变。因此,如果一个信号被赋值两次,就会产生编译错误。下面的例子中,信号`out`被赋值两次,导致编译错误。

```text
pragma circom 2.0.0;

template A(){
   signal input in;
   signal output outA; 
   outA <== in;
}

template B(){
   //声明信号
   signal output out;
   out <== 0;
   component comp = A();
   comp.in <== 0;
   out <== comp.outA;
}

component main = B();
```

在编译时,信号的内容总是被认为是未知的,即使一个常量已经被赋予它们。之所以这样做,是为了精确地定义哪些结构是允许的,哪些不允许的,而不依赖于编译器检测一个信号是否总有一个常量值的能力。

```text
pragma circom 2.0.0;

template A(){
   signal input in;
   signal output outA;
   var i = 0; var out = 0; 
   while (i < in){
    out++; i++;
   }
   outA <== out;
}

template B(){
 component a = A();
 a.in <== 3;
}

component main = B();
```

这个例子会产生编译错误,因为信号`outA`的值取决于信号`in`的值,尽管`in`的值是常量3。

信号只能使用`<--`或`<==`(见[基本操作符](4_Basic_Operators))操作赋值,信号在赋值操作的左侧,或使用`-->`或`==>`(见[基本操作符](4_Basic_Operators))操作赋值,信号在赋值操作的右侧。安全的选择是`<==`和`==>`,因为它们既赋值又同时生成约束。通常应该避免使用`<--`和`-->`,只有在被赋的表达式不能包含在约束中时才使用,比如下面这个例子:

```text
out[k] <-- (in >> k) & 1;
```