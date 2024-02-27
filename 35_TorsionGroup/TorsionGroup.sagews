p = 19
a = -1
b = 1
E = EllipticCurve(GF(p), [a, b])

print("椭圆曲线中的元素个数: ", E.cardinality())

# 获取11-挠群的点
INF = E[0]
L_E_11 = INF.division_points(11)  # [11]P == INF
E_11 = Set(L_E_11)  # $11$-torsion
print("11-torsion points: ", E_11)
print("11-挠群中的元素个数: ", E_11.cardinality())

# 初始化绘图对象
plot = Graphics()

# 添加椭圆曲线图
plot += E.plot(size=100)

# 添加11-挠群的点到图中
for P in E_11:
    if P != E[0]:  # 确保P不是无穷远点
        plot += point(P, size=100, color='red')

# 显示图形，设置标题和坐标轴范围
plot.show(title="11-torsion points on the Elliptic Curve $y^2 = x^3 - x + 1$ over $\mathbb{F}_{19}$", xmin=-1, xmax=p, ymin=-1, ymax=p)
