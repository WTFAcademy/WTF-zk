# 作用域

Circom 具有类似于 C 和 Rust 的静态作用域。然而，我们有信号和组件必须具有全局作用域，因此它们应该在定义它们的模板的顶级块中定义，或者自 Circom 2.1.5 以来，可以在（嵌套的）`if` 块中定义，但仅限于条件在编译时已知的情况。

```text
pragma circom 2.1.5;

template Cubes (N) {
   // 信号声明
   signal input in[N];
   signal output out[N];
   
   // 语句
   for (var i = 0; i < N; i++) {
      signal aux;
      aux <== in[i]*in[i];
      out[i] <== aux*in[i];      
   }
}

component main = Cubes(5);
```

信号 `aux` 不能在 `for` 指令的块中声明。会产生以下编译错误：_“`aux` 在初始作用域之外”_。

相反，以下程序可以正确编译。

```text
pragma circom 2.1.5;
template A(n){
   signal input in;
   signal output outA;
   var i = 0;
   if(i < n){
    signal out <== 2;
    i = out;
   } 
   outA <== i;
}
component main = A(5);
```

由于条件 `i < n` 在编译时已知，因此信号 `out` 的声明是允许的。然而，如果条件是 `in < n`，因为它在编译时是未知的，就会输出错误消息，因为在这种情况下不允许声明。

无论如何，我们应用类似于 C++ 或 Rust 的静态作用域，并且在 `if` 块内声明的信号只能在声明它的块内可见。

关于子组件信号的可见性，组件 `c` 的信号 `x` 在声明了 `c` 的模板 `t` 中也是可见的，使用 `c.x` 的表示法，如果 `x` 是 `c` 的输入或输出。不能访问子组件的中间信号或嵌套子组件的信号。例如，如果 `c` 是使用另一个组件 `d` 构建的，则不能从 `t` 访问 `d` 的信号。这可以在以下代码中看到：

```text
pragma circom 2.0.0;

template d(){
  signal output x;
  x <== 1;
}

template c(){
  signal output out2;
  out2 <== 2;
  component comp2 = d();
}

template t(){
  signal out;
  component c3 = c();
  out <== c3.comp2.x;
}

component main = t();
```
这会在 `c3.comp2.x` 上引发错误：_“组件中未找到信号：只允许访问输入/输出信号”_。

一个变量可以在任何块中定义，并且其可见性仅限于该块内，类似于 C 或 Rust。