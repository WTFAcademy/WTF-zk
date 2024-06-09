## 模板与组件

### 模板

在 Circom 中创建通用电路的机制称为模板。它们通常是基于一些在使用模板时必须实例化的参数。模板的实例化是一个新的电路对象，可以用来组合其他电路，作为更大电路的一部分。由于模板通过实例化定义电路，它们有自己的信号。

```
template tempid (param_1, ..., param_n) {
    signal input a;
    signal output b;
    
    .....
}
```

模板不能包含局部函数或模板定义。

在定义模板的同一模板中给输入信号赋值会产生 "Exception caused by invalid assignment" 错误，如下例所示。

```
pragma circom 2.0.0;

template wrong (N) {
    signal input a;
    signal output b;
    a <== N;
}

component main = wrong(1);
```

模板的实例化使用关键字 `component` 并提供必要的参数。

```
component c = tempid(v1, ..., vn);
```

参数的值应在编译时已知。以下代码会产生编译错误消息："Every component instantiation must be resolved during the constraint generation phase"。

```
pragma circom 2.0.0;

template A(N1, N2) {
    signal input in;
    signal output out;
    out <== N1 * in * N2;
}

template wrong (N) {
    signal input a;
    signal output b;
    component c = A(a, N); 
}

component main {public [a]} = wrong(1);
```

### 组件

组件定义了一个算术电路，它接收 N 个输入信号并产生 M 个输出信号和 K 个中间信号。此外，它可以产生一组约束。

为了访问组件的输入或输出信号，我们将使用点符号。没有其他信号在组件外部可见。

```
c.a <== y*z-1;
var x;
x = c.b;
```

组件实例化在其所有输入信号分配为具体值之前不会触发。因此，实例化可能会延迟，因此组件创建指令并不意味着组件对象的执行，而是创建实例化过程，该过程将在所有输入设置后完成。只有在设置了所有输入后，组件的输出信号才能使用，否则会产生编译错误。例如，以下代码会导致错误：

```
pragma circom 2.0.0;

template Internal() {
    signal input in[2];
    signal output out;
    out <== in[0] * in[1];
}

template Main() {
    signal input in[2];
    signal output out;
    component c = Internal();
    c.in[0] <== in[0];
    c.out ==> out;  // c.in[1] 尚未分配
    c.in[1] <== in[1];  // 这行代码应在调用 c.out 之前
}

component main = Main();
```

组件是不可变的（如信号）。组件可以先声明，再在第二步初始化。如果有多个初始化指令（在不同的执行路径中），它们都需要是同一模板的实例化（也许参数值不同）。

```
template A(N) {
    signal input in;
    signal output out;
    out <== in;
}

template C(N) {
    signal output out;
    out <== N;
}

template B(N) {
    signal output out;
    component a;
    if (N > 0) {
        a = A(N);
    } else {
        a = A(0);
    }
}

component main = B(1);
```

如果指令 `a = A(0);` 被替换为 `a = C(0);`，编译将失败并显示错误消息："Assignee and assigned types do not match"。

我们可以按照前述对大小的限制来定义组件数组。此外，不允许在数组组件的定义中进行初始化，实例化只能逐个组件进行，访问数组的位置。数组中的所有组件必须是同一模板的实例，如下例所示。

```
template MultiAND(n) {
    signal input in[n];
    signal output out;
    component and;
    component ands[2];
    var i;
    if (n == 1) {
        out <== in[0];
    } else if (n == 2) {
        and = AND();
        and.a <== in[0];
        and.b <== in[1];
        out <== and.out;
    } else {
        and = AND();
        var n1 = n \ 2;
        var n2 = n - n \ 2;
        ands[0] = MultiAND(n1);
        ands[1] = MultiAND(n2);
        for (i = 0; i < n1; i++) ands[0].in[i] <== in[i];
        for (i = 0; i < n2; i++) ands[1].in[i] <== in[n1 + i];
        and.a <== ands[0].out;
        and.b <== ands[1].out;
        out <== and.out;
    }
}
```

当组件是独立的（输入不依赖其他输出）时，可以使用 `parallel` 标签并行计算这些部分，如下所示。

```
template parallel NameTemplate(...){...}
```

如果使用此标签，生成的 C++ 文件将包含用于计算见证的并行化代码。在处理大型电路时，并行化变得尤为重要。

注意，前述并行性是在模板级别声明的。有时，可以为每个组件声明并行性。从版本 2.0.8 开始，`parallel` 标签也可以在组件级别使用，标签在调用模板之前标明。

```
component comp = parallel NameTemplate(...){...}
```

一个实际使用示例如下代码中的片段：

```
component rollupTx[nTx];
for (i = 0; i < nTx; i++) {
    rollupTx[i] = parallel RollupTx(nLevels, maxFeeTx);
}
```

需要再次强调的是，此并行性只能在 C++ 见证生成器中利用。

### 自定义模板

从版本 2.0.6 开始，该语言允许定义一种新类型的模板，即自定义模板。这种新结构类似于标准模板：它们以相同的方式声明，只需在声明后添加关键字 `custom`；并以完全相同的方式实例化。即，一个自定义模板 `Example` 如下定义和实例化：

```
pragma circom 2.0.6; // 注意，自定义模板仅在版本 2.0.6 及之后允许
pragma custom_templates;

template custom Example() {
    // 自定义模板代码
}

template UsingExample() {
    component example = Example(); // 自定义模板的实例化
}
```

然而，它们的计算编码方式不同于标准模板。每个自定义模板的使用将由 `snarkjs` 在生成和验证 zk 证明的后续阶段处理，在此情况下使用 PLONK 方案（并将自定义模板的定义用作 PLONK 的自定义门）。有关定义和使用自定义模板的信息将导出到 `.r1cs` 文件中。这意味着自定义模板不能在其主体内引入任何约束，也不能声明任何子组件。

## Pragma

### 版本 Pragma

所有以 .circom 为扩展名的文件都应该以第一个 `pragma` 指令开始，指定编译器版本，如下所示：

```plaintext
pragma circom xx.yy.zz;
```

这是为了确保电路与 `pragma` 指令之后所指示的编译器版本兼容。否则，编译器会抛出一个警告。

如果文件不包含此指令，则假定代码与最新版本的编译器兼容，并会抛出一个警告。

### 自定义模板 Pragma

自 circom 2.0.6 版本起，语言允许定义自定义模板（更多信息请参见[这里](../circom-language/templates-and-components.md#custom-templates)）。此 `pragma` 允许 circom 程序员轻松判断是否使用了自定义模板：如果任何声明自定义模板的文件或包含声明任何自定义模板文件的文件没有使用此 `pragma`，编译器将产生错误。此外，它将告知程序员哪些文件应包含此 pragma。

要使用它，只需在需要它的 .circom 文件开头（在版本 `pragma` 之后）添加以下指令：

```plaintext
pragma custom_templates;
```

## 函数

在 circom 中，函数定义了一些可以执行计算以获得返回值或表达式的通用抽象代码片段。

```plaintext
function funid (param1, ..., paramn) {

 .....

 return x;
}
```

函数计算数值（或数值数组）或表达式。函数可以是递归的。请参考 circom 库中的[下一个函数](https://github.com/iden3/circomlib/blob/master/circuits/binsum.circom)。

```plaintext
/*
    此函数计算输出中的额外位数
    以进行完整求和。
 */

function nbits(a) {
    var n = 1;
    var r = 0;
    while (n-1 < a) {
        r++;
        n *= 2;
    }
    return r;
}
```

函数不能声明信号或生成约束（如有需要，请使用模板）。以下函数会产生错误消息："Template operator found"。

```plaintext
function nbits(a) {
    signal input in; // 这是不允许的。
    var n = 1;
    var r = 0;
    while (n-1 < a) {
        r++;
        n *= 2;
    }
    r === a; // 这也是不允许的。
    return r;
}
```

与往常一样，可以有多个 return 语句，但每个执行路径必须以 return 语句结束（否则会产生编译错误）。return 语句的执行将控制权返回给函数的调用者。

```plaintext
function example(N) {
    if (N >= 0) { return 1; }
//   else { return 0; }
}
```

函数 `example` 的编译会产生以下错误消息："In example there are paths without return"。

## Include

模板和其他代码一样，可以在其他文件（如库）中找到。为了在我们的程序中使用其他文件中的代码，我们必须使用关键字 `include` 来包含它们，并带有相应的文件名（默认扩展名为 .circom）。

```plaintext
include "montgomery.circom";
include "mux3.circom";
include "babyjub.circom";
```

这段代码包括了 circom 库中的 `montgomery.circom`、`mux3.circom` 和 `babyjub.circom` 文件。

自 circom 2.0.8 版本起，可以使用 `-l` 选项来指定搜索要包含文件的路径。

## 主组件

为了开始执行，必须提供一个初始组件。默认情况下，该组件的名称是 "main"，因此需要使用某个模板实例化组件 main。

这是一个创建电路所需的特殊初始组件，它定义了电路的全局输入和输出信号。因此，与其他组件相比，它有一个特殊属性：公共输入信号列表。创建主组件的语法如下：

```plaintext
component main {public [signal_list]} = tempid(v1,...,vn);
```

其中 `{public [signal_list]}` 是可选的。模板中未包含在列表中的任何输入信号都被视为私有信号。

```plaintext
pragma circom 2.0.0;

template A(){
    signal input in1;
    signal input in2;
    signal output out;
    out <== in1 * in2;
}

component main {public [in1]} = A();
```

在这个示例中，我们有两个输入信号 `in1` 和 `in2`。注意 `in1` 被声明为电路的公共信号，而 `in2` 被视为私有信号，因为它没有出现在列表中。最后，输出信号始终被视为公共信号。

只能定义一个主组件，不仅在编译的文件中，而且在程序中包含的任何其他 circom 文件中也是如此。否则，编译会失败，并显示以下消息：_"Multiple main components in the project structure"_。