package main
Software Development, Principles, Patterns, and Practices.
Robert Martin define Liskov Substitution Principle as :
Subtypes must be substitutable for their base types.
According to that definition golang is safe from LSP, because in golang we don’t have inherintance, we have a more powerful tool that is the composition.
Anyway composition does not allow to substitute parent struct by child struct.
So this code will panic :
type A struct {
 
}
func (a A) Test() {
     fmt.Println("Printing A")
}
type B struct {
   A
}
func ImpossibleLiskovSubstitution(a A) {
    a.Test()
}
func main() {
   a := B{}
ImpossibleLiskovSubstitution(a) // PANIC : cannot use a (type B) as
                                   type A in argument to 
                                   ImpossibleLiskovSubstitution
}
The solution in others language would be to define the behavior in an interface.
In Golang we are obliged to do so. ;)
type A struct {
 
}
type tester interface {
    Test()
}
func (a A) Test() {
     fmt.Println("Printing A")
}
type B struct {
   A
}
func PossibleLiskovSubstitution(a tester) {
    a.Test()
}
func main() {
   a := B{}
   PossibleLiskovSubstitution(a)
}
In a general way interface are synonym of behavior.
Conclusion :
As Dave Cheney says :
The Liskov Substitution Principle encourages you to express the dependencies between your packages in terms of interfaces, not concrete types. By defining small interfaces, we can be more confident that implementations will faithfully satisfy their contract.
