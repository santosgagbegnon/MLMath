//
//  Stack.swift
//  MLMath
//
//  Created by Santos on 2018-09-15.
//  Copyright © 2018 Santos. All rights reserved.
//

import Foundation
class Stack<E> {
    private class Node<F> {
        public var next : Node<F>?
        public var value : F
        init(next : Node<F>?, value: F) {
            self.next = next
            self.value = value
        }
    }
    
    private var head : Node<E>?
    private (set) var count = 0
    init() {
        self.head = nil
    }
    public func push(item : E){
        
        let newNode = Node<E>(next: head, value: item)
        head = newNode
        count += 1
    }
    public func pop() -> E?{
        if head == nil {return nil}
        let nodeToRemove = head
        head = head?.next
        count -= 1
        return nodeToRemove?.value
        
    }
    public func peak() -> E? {
        return head?.value
    }
    public func isEmpty() -> Bool{
        return head == nil;
    }
    public func getStackInReverse() -> Stack<E> {
        let tempReverseStack = Stack<E>()
        let reverseStack = Stack<E>()

        while (!self.isEmpty()){
            let poppedValue = self.pop()!
            tempReverseStack.push(item: poppedValue)
            reverseStack.push(item: poppedValue)
        }
        while(!tempReverseStack.isEmpty()){
            self.push(item: tempReverseStack.pop()!)
        }
        return reverseStack
    }
    
}
