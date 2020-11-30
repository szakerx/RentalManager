package pl.monochrome.manager.controller

import org.springframework.beans.factory.annotation.Autowired
import org.springframework.web.bind.annotation.PostMapping
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RestController
import pl.monochrome.manager.model.database.Person
import pl.monochrome.manager.service.PersonService

@RestController
@RequestMapping("/people")
class PersonController @Autowired constructor(private val service: PersonService) {

    @PostMapping
    fun addDefaultUser() = service.addPerson(Person())

}