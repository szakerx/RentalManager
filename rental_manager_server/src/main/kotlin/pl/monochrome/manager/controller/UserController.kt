package pl.monochrome.manager.controller

import org.springframework.beans.factory.annotation.Autowired
import org.springframework.web.bind.annotation.PostMapping
import org.springframework.web.bind.annotation.RequestBody
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RestController
import pl.monochrome.manager.model.database.User
import pl.monochrome.manager.service.db.UserService

@RestController
@RequestMapping("/users")
class UserController @Autowired constructor(private val service: UserService) {

    @PostMapping
    fun registerUser(@RequestBody user: User) = service.register(user)

}