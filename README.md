# SmashedCloudTollManagment
Smashed Cloud Assessment test.
It is Asp.net Web api Project database file is attached with it.
This Project is using identity for authentication . 
You can see the images attatched to call api from postman
you must change connection string in web.config  file according to your server instantce


Introduction
Imagine a government department that is responsible for collecting tolls on a major road in
Lahore, like the ring road. Tolls are a tax calculated by the agency to keep the road maintained,
and therefore all vehicles that enter the ring road have to pay a toll tax.
Tolls are calculated based on the following:
1. Entry Point
2. Exit Point
3. Day of the week
4. Number plate in the format (LLL-NNN) where L is a letter and N is a number.
5. Special discount days

Rules:
1. Toll tax has a base rate of rupees 20 - this is a base rate that is added to the cost the
moment a vehicle enters.
2. For all distance traveled, the customer will be charge 0.2 rupees per KM
3. The distance rate will be 1.5x on weekends (Sat/Sun) - determine at exit point
4. For Mon and Wed, cars with even number in number plate will be given 10% discount,
and for Tues and Thurs, cars with odd number in number plate will be given 10%
discount - for Fri/Sat/Sun no difference on number plate - based on entry date/time
5. On 3 national holidays discount will be given of 50% (23rd march, 14th August, and 25th
December)
6. The actual toll is collected when the vehicle exits the road.

Map of entry points, and distance from zero point:
Zero point: 0KM
NS Interchange: 5KM
Ph4 Interchange: 10KM
Ferozpur Interchange: 17KM
Lake City Interchange: 24KM
Raiwand Interchange: 29KM
Bahria Interchange: 34Km
Wireframe
The frontend application will have two interfaces: an entry point screen to be used by toll plaza
agents for entry of vehicles, and an exit screen to be used by toll plaza agents for exit of
vehicles.
Key: In the wireframe, all boxes are fields, all green boxes are buttons and all dotted lines are
fields that will be represented back to the user and are not editable.
In the entry screen, agents will enter all required information, such as the interchange that the
vehicle is entering from.

In the exit screen, agents will be able to enter all required information, and the application will
also display total cost, once they click the calculate button:
