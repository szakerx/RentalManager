package pl.monochrome.manager.service.db

import org.springframework.beans.factory.annotation.Autowired
import org.springframework.data.repository.findByIdOrNull
import org.springframework.stereotype.Service
import pl.monochrome.manager.model.database.Guest
import pl.monochrome.manager.model.database.UserGuestKey
import pl.monochrome.manager.model.dto.GuestDto
import pl.monochrome.manager.repository.GuestRepository

@Service
class GuestService @Autowired constructor(
    private val repository: GuestRepository,
    private val userService: UserService,
    private val personService: PersonService
) {

    fun getAllGuests(userId: String): Set<Guest> = repository.findAllByUserId(userId)

    fun getGuest(userId: String, guestId: Int) = repository.findByIdOrNull(UserGuestKey(userId, guestId))

    fun addGuest(guestDto: GuestDto): Guest {
        val guest = dtoToObject(guestDto)
        return repository.save(guest)
    }

    fun updateGuest(guestDto: GuestDto): Guest {
        val guest = dtoToObject(guestDto)
        return repository.save(guest)
    }

    fun deleteGuest(userId: String, personId: Int) = repository.deleteById(UserGuestKey(userId, personId))

    private fun dtoToObject(guestDto: GuestDto): Guest {
        val user = userService.getUserById(guestDto.userId)
        val person = personService.getPerson(guestDto.personId)
        val key = UserGuestKey(guestDto.userId, guestDto.personId)
        return Guest(key, user, person, guestDto.note)
    }

}
