package pl.monochrome.manager.service.db

import org.springframework.beans.factory.annotation.Autowired
import org.springframework.stereotype.Service
import pl.monochrome.manager.model.database.Person
import pl.monochrome.manager.repository.PersonRepository

@Service
class PersonService @Autowired constructor(private val repository: PersonRepository) {

    fun getPerson(personId: Int) = repository.findById(personId).get()

    fun addPerson(person: Person) = repository.save(person)

    fun updatePerson(person: Person) = repository.save(person)

    fun getPersonByMail(mail: String) = repository.findByMail(mail)

}