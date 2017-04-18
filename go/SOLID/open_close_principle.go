package main

//Robert Martin define Open/Closed Principle as :
//Software entities (classes, modules, functions, etc.) should be open for extension, but closed for modification.
//It imply 2 things :
//be able to override a struct
//Use the Strategy Design Pattern
//Be able to override a struct
//That ‘s easy, and I will take the example of Dave Cheney :
//type A struct {
//year int
//}

//func (a A) Greet() { fmt.Println("Hello GolangUK", a.year) }

//type B struct {
//A
//}

//func (b B) Greet() { fmt.Println("Welcome to GolangUK", b.year) }
//Thanks Dave !
//Use the Strategy Design Pattern
//It’s just sample, in reality we can do it differently.
//type Calcul struct {
//}
//func (c Calcul) Calculate (a int, b int) int {
//return a + b
//}
//If we want to add a new Behavior (the minus for example) it would not be possible.
//So we will use the strategy Pattern.

//type Calculer interface {
//Execute(int, int) int
//}
//type Add struct {
//}
//func (add Add) Execute(a int, b int) int {
//return a + b
//}
//type Minus struct {
//}
//func (m Minus) Execute(a int, b int) int {
//return a -b
//}
//type Calcul struct {
//c Calculer
//}
//func (c Calcul) Calculate (a int, b int) int {
//return c.c.Execute(a, b)
//}
//func main() {
//a := Calcul{ c: Add{} }
//b := Calcul{ c: Minus{} }
//fmt.Println(a.Calculate(3,1)) // 4
//fmt.Println(b.Calculate(3,1)) // 2
//}
//Conclusion :
//As Dave Cheney says :
//The Open / Closed Principle encourages you to compose simple types into more complex ones using embedding
