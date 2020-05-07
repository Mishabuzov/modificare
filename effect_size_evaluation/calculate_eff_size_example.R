# Title     : TODO
# Objective : TODO
# Created by: misha
# Created on: 5/7/20


library(effsize)

treatment = c(0.5610158195657512, 0.6395699603633941, 0.6158230734154128, 0.7086709460170473, 0.6193131993405591)
control = c(0.6013350574913501, 0.6059483451577954, 0.6245238178450355, 0.5591689092370602, 0.6534267640582953)
# d = (c(treatment,control))
# f = rep(c("Treatment","Control"),each=100)
## compute Vargha and Delaney A
## treatment and control
VD.A(treatment,control)
## data and factor
# VD.A(d,f)
## formula interface
# VD.A(d ~ f)

