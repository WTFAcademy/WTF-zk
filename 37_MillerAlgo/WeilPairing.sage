p = 631
a = 30
b = 34
E = EllipticCurve(GF(p), [a, b])
print(E)
print("椭圆曲线中的元素个数: ", E.cardinality())

# 获取5-挠群的点
INF = E[0]
L_E_5 = INF.division_points(5)  # [11]P == INF
E_5 = Set(L_E_5)  # $5$-torsion
print("5-torsion points: ", E_5)
print("5-挠群中的元素个数: ", E_5.cardinality())

P = E([36,60])
Q = E([121,387])

weil_P_Q = P.weil_pairing(Q, 5)
print("5-挠群中点", P, "和", Q, "的Weil配对为", weil_P_Q)

R = 3 * P
S = 4 * Q

weil_R_S = R.weil_pairing(S, 5)
print("5-挠群中点", R, "和", S, "的Weil配对为", weil_R_S)

print("因为 R= 3P, S = 4Q，因此 weil_P_Q ^ 12  = ",  weil_P_Q^12 , "和 weil_R_S 相等")