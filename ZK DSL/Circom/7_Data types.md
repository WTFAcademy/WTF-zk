# 数据类型

Circom 中的基本变量类型有：

* **域元素值**：模素数 _p_ 的整数值（见 [信号](../signals)）。这是所有信号和基本变量的默认类型。
* **数组**：它们可以包含相同类型（信号、var 或相同类型的组件或数组）的有限数量元素（在编译时已知）。元素从零开始编号，可以使用其位置的相应索引进行访问。数组访问使用方括号。声明给定类型的数组通过在变量标识符旁边添加 \[\] 并在括号之间包含大小（应使用常量值和/或模板的数字参数定义）来实现。

访问和声明应与其类型一致，因此我们用 m\[i\]\[j\] 进行访问和声明，因为 m\[i\] 是一个数组。以下是带有和不带有初始化的声明示例：

```plaintext
var x[3] = [2,8,4];
var z[n+1];  // 其中 n 是模板的参数
var dbl[16][2] = base;
var y[5] = someFunction(n);
```

不允许使用 m\[i,j\] 表示数组的数组（矩阵）。

另一方面，以下情况将产生编译错误，因为数组的大小应显式给出：

```plaintext
var z = [2,8,4];
```

最后，信号的类型需要声明，因为它们不能全局分配为数组。它们按位置分配。

```plaintext
  signal input in[3];
  signal output out[2];
  signal intermediate[4];
```

组件数组必须使用相同的模板实例化（可以选择不同的参数）。

```plaintext
pragma circom 2.0.0;

template fun(N){
  signal output out;
  out <== N;
}

template all(N){
  component c[N];
  for(var i = 0; i < N; i++){
     c[i] = fun(i);
  }
}

component main = all(5);
```

因此，以下代码将产生编译错误："c\[i\] = fun(i) -> Assignee and assigned types do not match"。

```plaintext
pragma circom 2.0.0;

template fun(N){
  signal output out;
  out <== N;
}

template fun2(N){
  signal output out;
  out <== N;
}

template all(N){
  component c[N];
  for(var i = 0; i < N; i++){
        if(i < N)
             c[i] = fun(i);
        else
           c[i] = fun2(i);
  }
}

component main = all(5);
```