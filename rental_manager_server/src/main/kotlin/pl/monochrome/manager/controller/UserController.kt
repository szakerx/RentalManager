package pl.monochrome.manager.controller

import org.springframework.beans.factory.annotation.Autowired
import org.springframework.http.HttpStatus
import org.springframework.http.ResponseEntity
import org.springframework.stereotype.Controller
import org.springframework.web.bind.annotation.*
import pl.monochrome.manager.model.database.User
import pl.monochrome.manager.service.UserService
import javax.persistence.EntityManager
import javax.persistence.PersistenceContext
import javax.transaction.Transactional

@RestController
@RequestMapping("/users")
class UserController @Autowired constructor(private val service: UserService) {

    @GetMapping
    fun getAllUsers(): List<User> = service.getAllUsers()

    @GetMapping("/new")
    @Transactional
    fun addRandomUser(): ResponseEntity<String> {
        service.add(User())
        return ResponseEntity(HttpStatus.OK)
    }

    @DeleteMapping("/deleteAll")
    fun deleteAllUsers(): ResponseEntity<String> {
        service.deleteAllUsers()
        return ResponseEntity(HttpStatus.OK)
    }

}