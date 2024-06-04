# chatapp_ksn

A new Flutter project.

## Getting Started

Functionalities :

- Sign up ( data stored in firebase )

- Sign in ( data stored in firebase )

- Socket integration ( i was unable to find the way to work with the given webscoket testing hence used pietest.com)

- Hive for local storage

- Shared preferneces for simple key storage

- After logged in , user can see available users list..and can chat with anyone he want.

- Note : only when two users are logged into their accounts in different laptops..then only messages will receive..since we are not maintaining database for message storing and relying only on local storage...user need to be active and listening to the socket in order to receive messages.

- Responsive UI

State management Used : GetX (Sorry, i am not well aware of bloc but willing to learn it.)
Pattern Used : MVC
