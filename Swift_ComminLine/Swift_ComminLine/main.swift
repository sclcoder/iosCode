//
//  main.swift
//  Swift_ComminLine
//
//  Created by 孙春磊 on 2022/4/4.
//

import Foundation

// 汇编调试 分析inout本质为地址传递
var number = 10
func add(_ num: inout Int){
    num = 20
}
add(&number)

/*
 add(&number)
 lea:地址传递指令
 0x100003f3c <+44>: leaq   0x40d5(%rip), %rdi        ; Swift_ComminLine.number : Swift.Int
 将rip+0x40d5地址传递给寄存器rdi
 
 0x100003f43 <+51>: callq  0x100003f60               ; Swift_ComminLine.add(inout Swift.Int) -> () at main.swift:12
 
 

 */

func add2(_ num: Int){
}
add2(number)
/*
 add2(number)
 
 mov:移动某个内存中值
 0x100003f2e <+110>: movq   -0x38(%rbp), %rdi ;  找rbp-0x38的地址，将该地址的值赋值给寄存器rdi
 
 0x100003f32 <+114>: callq  0x100003f60       ; Swift_ComminLine.add2(Swift.Int) -> () at main.swift:27
 
 
 */
