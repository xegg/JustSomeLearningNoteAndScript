package main

//Single Responsibility Principle was define by Robert Martin as :
//A class should have only one reason to change.
//It means that your struct must only have one responsibility.
//It also means that when you create your struct, you should look at 3 things :
//Is my method a behavior of my struct ? (Is this behavior the Single Responsability of my struct ?)
//Is my struct tightly coupled with another struct ?
//Could my method be applied differently ?

//Is my method a behavior of my struct ?
//If yes, don’t change nothing it’s perfect, the only reason it would have to change, it’s if the behavior of your struct change.
//type Book struct {

//}
//func (b Book) GetTitle() {
//.......
//}

//Is my struct tightly coupled with another struct ?
//You can easily understand that if a struct is tightly coupled, it means that if the behavior of one struct change, it can imply the change of the other.
//Could my method be applied differently ?
//type A struct {
//Content string
//....
//}
//func (a A) Save() {
//fmt.Println("Saving in the Terminal .... " + a.Content)
//}

//Could I “Save” my struct in another location ?
//Maybe tomorrow I would like to save in a file, or in a DataBase.
//So the code should be :
//type A struct {
//Content string
//.....
//}
//type APersistence struct {
//}
//func (ap APersistence) Save(a A) {
//fmt.Println("Saving in the Terminal .... " + a.Content)
//}

//Conclusion :
//As Dave Cheney says :
//The Single Responsibility Principle encourages you to structure the functions,
//types, and methods into packages that exhibit natural cohesion; the types
//belong together, the functions serve a single purpose.
