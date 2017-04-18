package main
SOLID principles was created in 2002 by Robert Martin in his book Agile Software Development, Principles, Patterns, and Practices.
Robert Martin define Interface Segregation Principle as :
Clients should not be forced to depend on methods they do not use.
It means that we shouldn’t create big struct with a lot of behaviors, we should isolate behaviors.
As example, we could think in a Vehicle with almost 2 methods :
type Vehicle struct {
 
}
func (v Vehicle) Accelerate() {
     fmt.Println("Accelerating ....")
}
func (v Vehicle) PlayCD() {
     fmt.Println("Playnig Guns n Roses")
}
A client using our Vehicle, wants to “extend” our vehicle to implement a Bus struct (in composition), but his Bus does not need to PlayCD. But he will be obliged to have the method, even if he will not use it :S
So on this case we should separate in 2 different struct the behaviors (in SRP) CDPlayer and Accelerator.define 2 interfaces, and 2 different struct.
type VehicleCDPlayer interface {
    PlayCD()
}
type VehicleCdPlay struct {
}
func (v VehicleCdPlay) PlayCD() {
     fmt.Println("Playnig Guns n Roses")
}
type VehicleAccelerator interface {
    Accelerate()
}
type VehicleAccelerate struct {
 
}
func (v VehicleAccelerate) Accelerate() {
     fmt.Println("Accelerating ....")
}
type Vehicle struct {
 VehicleAccelerate
 VehicleCdPlay
}
Now if I want to implement a Bus, Ican compose with VehicleAccelerate.
PS: I know, the name I choose are dumbs, but it’s not easy to choose good names.
Conclusion :
As Dave Cheney says :
The Interface Substitution Principle takes that idea further and encourages you to define functions and methods that depend only on the behaviour that they need. If your function only requires a parameter of an interface type with a single method, then it is more likely that this function has only one responsibility.
